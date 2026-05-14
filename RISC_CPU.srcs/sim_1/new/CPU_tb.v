`timescale 1ns / 1ps
`include "define.v"

module RISC_CPU_tb;

    // --- Tín hiệu điều khiển ---
    reg clk;
    reg rst;

    // --- Kết nối với khối CPU tổng ---
    RISC_CPU dut (
        .clk(clk),
        .rst(rst)
    );

    // --- Tạo xung nhịp Clock ---
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Chu kỳ 10ns
    end

    // --- Task hỗ trợ ghi LỆNH vào RAM (Zero-extend 8 bit thành 32 bit) ---
    task write_inst;
        input [4:0] addr;
        input [2:0] op;
        input [4:0] opr;
        begin
            dut.u_memory.ram[addr] = {24'd0, op, opr};
        end
    endtask

    // --- Task hỗ trợ ghi DỮ LIỆU vào RAM ---
    task write_data;
        input [4:0] addr;
        input [31:0] data;
        begin
            dut.u_memory.ram[addr] = data;
        end
    endtask

    // --- KỊCH BẢN KIỂM THỬ ---
    initial begin
        // 1. Kích hoạt Reset
        rst = 1;
        $display("=================================================");
        $display("=== KHOI TAO BO NHO VA NAP CHUONG TRINH       ===");
        $display("=================================================");
        
        // --- NẠP DỮ LIỆU (Data Segment) từ địa chỉ 25 đến 31 ---
        write_data(5'd25, 32'h00000000); 
        write_data(5'd26, 32'hAAAAAAAA); // Mẫu bit xen kẽ 1
        write_data(5'd27, 32'h55555555); // Mẫu bit xen kẽ 2
        write_data(5'd28, 32'hFFFFFFFF); // Giá trị Max (Edge case)
        write_data(5'd29, 32'h00000005); // Giá trị 5
        write_data(5'd30, 32'h00000000); // Ô trống để test lệnh STO
        
        // --- NẠP LỆNH (Instruction Segment) từ địa chỉ 0 ---
        
        // Lệnh 0: LDA 26 -> Nạp AAAAAAAA vào ACC
        write_inst(5'd0, `LDA, 5'd26);
        
        // Lệnh 1: AND 27 -> ACC = AAAAAAAA & 55555555 = 0 (Cố tình tạo ra số 0)
        write_inst(5'd1, `AND, 5'd27);
        
        // Lệnh 2: SKZ 0  -> ACC đang bằng 0, cờ is_zero=1 -> SẼ NHẢY CÓC lệnh tiếp theo
        write_inst(5'd2, `SKZ, 5'd0);
        
        // Lệnh 3: JMP 31 -> LỆNH NÀY SẼ BỊ BỎ QUA do SKZ. Nếu PC chạy vào đây là LỖI.
        write_inst(5'd3, `JMP, 5'd31); 
        
        // Lệnh 4: LDA 28 -> Nạp FFFFFFFF vào ACC
        write_inst(5'd4, `LDA, 5'd28);
        
        // Lệnh 5: ADD 29 -> ACC = FFFFFFFF + 5 = 00000004 (Test tràn số - Overflow 32-bit)
        write_inst(5'd5, `ADD, 5'd29);
        
        // Lệnh 6: STO 30 -> Lưu kết quả tính toán (00000004) vào ô nhớ 30
        write_inst(5'd6, `STO, 5'd30);
        
        // Lệnh 7: XOR 29 -> ACC = 00000004 ^ 00000005 = 00000001
        write_inst(5'd7, `XOR, 5'd29);
        
        // Lệnh 8: SKZ 0  -> ACC = 1 (khác 0) -> KHÔNG NHẢY CÓC, chạy bình thường
        write_inst(5'd8, `SKZ, 5'd0);
        
        // Lệnh 9: JMP 11 -> Nhảy vô điều kiện xuống lệnh số 11
        write_inst(5'd9, `JMP, 5'd11);
        
        // Lệnh 10: HLT 0 -> Lệnh này bị bỏ qua do lệnh JMP vừa nhảy qua nó
        write_inst(5'd10, `HLT, 5'd0);
        
        // Lệnh 11: HLT 0 -> Dừng chương trình thành công. PC bị khóa.
        write_inst(5'd11, `HLT, 5'd0);

        // 2. Bắt đầu chạy CPU
        #20 rst = 0; // Thả reset
        $display("=== CPU BAT DAU THUC THI CHUONG TRINH ===");
        
        // Đợi đủ thời gian cho chương trình chạy (12 lệnh * 8 chu kỳ * 10ns = ~960ns)
        #1500;
        
        // 3. Tự động đánh giá kết quả (Self-checking)
        $display("=================================================");
        $display("=== KET QUA KIEM THU TONG THE (TOP-LEVEL)     ===");
        $display("=================================================");
        
        // Test 1: Kiểm tra kết quả STO và lỗi tràn số (Overflow)
        if (dut.u_memory.ram[30] === 32'h00000004)
            $display("[PASS] Lenh ADD xu ly tran so dung, STO ghi dung (Mem[30] = 4)");
        else
            $display("[FAIL] Lenh STO/ADD sai. Ky vong 4, thuc te %h", dut.u_memory.ram[30]);
            
        // Test 2: Kiểm tra kết quả cuối cùng trong Accumulator
        if (dut.u_acc.acc_out === 32'h00000001)
            $display("[PASS] Cac lenh logic (AND, XOR, LDA) tinh toan chuan xac (ACC = 1)");
        else
            $display("[FAIL] ACC sai gia tri. Ky vong 1, thuc te %h", dut.u_acc.acc_out);
            
        // Test 3: Kiểm tra luồng điều khiển (Control Flow)
        if (dut.u_pc.pc_out === 32'd11)
            $display("[PASS] Lenh SKZ, JMP va HLT hoat dong dung luong (PC dung tai 11)");
        else
            $display("[FAIL] PC dung sai vi tri. Ky vong 11, thuc te %d", dut.u_pc.pc_out);

        $display("=================================================");
        $finish;
    end

    // --- Monitor: In ra quá trình chạy của FSM ---
    // (Bỏ comment dòng dưới nếu bạn muốn xem chi tiết từng nhịp clock trên console)
    // initial begin
    //     $monitor("Time=%0t | State=%b | PC=%d | IR=%h | ACC=%h | Bus=%h", 
    //              $time, dut.u_controller.state, dut.u_pc.pc_out, dut.u_ir.ir_reg, dut.u_acc.acc_out, dut.data_bus);
    // end

endmodule