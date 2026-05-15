`timescale 1ns / 1ps
`include "define.v"

module tb_cpu_top;
    // Khai báo Clock và Reset
    reg clk;
    reg reset;

    // Các tín hiệu điều khiển từ Controller 
    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;
    wire is_zero; // Cờ Zero từ ALU [cite: 8]

    // Hệ thống Bus nội bộ
    wire [`DATA_WIDTH-1:0] data_bus;       // Bus dữ liệu 2 chiều 
    wire [`ADDR_WIDTH-1:0] mem_addr;       // Bus địa chỉ bộ nhớ [cite: 5]
    wire [`DATA_WIDTH-1:0] pc_out;         // Đầu ra Program Counter 
    wire [`OPCODE_WIDTH-1:0] opcode;       // Opcode 3-bit từ IR 
    wire [4:0] operand;                    // Operand 5-bit từ IR 
    wire [`DATA_WIDTH-1:0] alu_out;        // Đầu ra ALU 
    wire [`DATA_WIDTH-1:0] acc_out;        // Đầu ra Accumulator 

    // 1. Khởi tạo Program Counter (PC)
    program_counter u_pc (
        .clk(clk), .reset(reset),
        .inc_pc(inc_pc), .ld_pc(ld_pc),
        .pc_in({{(`DATA_WIDTH-5){1'b0}}, operand}), // Mở rộng operand cho vừa DATA_WIDTH
        .pc_out(pc_out)
    );

    // 2. Khởi tạo Address Mux
    address_mux u_mux (
        .sel(sel),
        .pc_addr(pc_out[`ADDR_WIDTH-1:0]),
        .ir_addr(operand),
        .mem_addr(mem_addr) // Chọn địa chỉ dựa trên sel 
    );

    // 3. Khởi tạo ALU
    ALU u_alu (
        .opcode(opcode),
        .inA(acc_out),
        .inB(data_bus),
        .out(alu_out),
        .is_zero(is_zero) // Bằng 1 nếu inA (ACC) bằng 0 [cite: 8, 9]
    );

    // 4. Khởi tạo Memory (RAM)
   memory u_mem (
    .clk(clk),
    .addr(mem_addr),
    .data(data_bus), 
    .rd(rd),
    .wr(wr)
);

    // 5. Khởi tạo Controller
    Controller u_ctrl (
        .clk(clk), .rst(reset),
        .is_zero(is_zero),
        .opcode(opcode),
        .sel(sel), .rd(rd), .ld_ir(ld_ir),
        .halt(halt), .inc_pc(inc_pc), .ld_ac(ld_ac),
        .ld_pc(ld_pc), .wr(wr), .data_e(data_e)
    );

    // 6. Khởi tạo Accumulator (ACC)
    ACC u_acc (
        .clk(clk), .rst(reset),
        .ld_ac(ld_ac),
        .acc_in(alu_out),
        .data_e(data_e),
        .acc_out(acc_out),
        .data_bus(data_bus) // Lái dữ liệu ra bus khi data_e = 1 [cite: 42]
    );

    // 7. Khởi tạo Instruction Register (IR)
    IR u_ir (
        .clk(clk), .rst(reset),
        .ld_ir(ld_ir),
        .data_in(data_bus),
        .opcode(opcode),  // Lấy bit [7:5] làm opcode [cite: 46]
        .operand(operand) // Lấy bit [4:0] làm operand [cite: 46]
    );

    // Tạo Clock chu kỳ 10ns
    always #5 clk = ~clk;

    // Quy trình Kiểm thử (Test Procedure)
    initial begin
        // Khởi tạo trạng thái ban đầu
        clk = 0;
        reset = 1;

        /* NẠP CHƯƠNG TRÌNH TEST VÀO RAM 
           Mô phỏng 1 file hex, cấu trúc: {opcode[2:0], operand[4:0]}
           Các lệnh sẽ lần lượt test từng state từ INST_ADDR đến STORE [cite: 24, 25, 26, 27] */
        
        // --- Vùng lệnh (Instruction Memory) ---
        u_mem.ram[0] = {`LDA, 5'd20}; // Tải dữ liệu từ địa chỉ 20 vào ACC
        u_mem.ram[1] = {`ADD, 5'd21}; // ACC = ACC + dữ liệu tại 21
        u_mem.ram[2] = {`STO, 5'd22}; // Lưu giá trị ACC ra địa chỉ 22 (Test WR)
        u_mem.ram[3] = {`AND, 5'd23}; // ACC = ACC & dữ liệu tại 23
        u_mem.ram[4] = {`XOR, 5'd24}; // ACC = ACC ^ dữ liệu tại 24 (Tạo cờ Zero)
        u_mem.ram[5] = {`SKZ, 5'd0};  // Kiểm tra cờ Zero. Sẽ bỏ qua lệnh kế tiếp.
        u_mem.ram[6] = {`JMP, 5'd9};  // Lệnh nhảy (Sẽ bị SKZ bỏ qua do ở trên XOR tạo ra 0)
        u_mem.ram[7] = {`LDA, 5'd25}; // Nếu SKZ hoạt động đúng, nó sẽ nhảy đến lệnh này
        u_mem.ram[8] = {`HLT, 5'd0};  // Dừng chương trình (Kích hoạt tín hiệu halt [cite: 38])
        u_mem.ram[9] = {`HLT, 5'd0};  // Vị trí dự phòng nếu JMP chạy sai

        // --- Vùng dữ liệu (Data Memory) ---
        u_mem.ram[20] = 8'd10;   // Dữ liệu ban đầu
        u_mem.ram[21] = 8'd5;    // Dữ liệu cộng thêm -> Sau lệnh ADD, ACC = 15
        u_mem.ram[22] = 8'd0;    // Vị trí trống để STO ghi kết quả vào
        u_mem.ram[23] = 8'b0000_1111; // Mask để AND (15 & 15 = 15)
        u_mem.ram[24] = 8'd15;   // Mask để XOR (15 ^ 15 = 0, kích hoạt is_zero = 1 [cite: 8, 9])
        u_mem.ram[25] = 8'd99;   // Giá trị nạp cuối cùng để check luồng chạy

        // Chạy Reset trong 2 chu kỳ để đảm bảo State chuyển về `INST_ADDR [cite: 21]
        #20 reset = 0; 

        // Giám sát và đợi cho đến khi tín hiệu Halt được bật [cite: 38]
        wait(halt == 1'b1);
        
        // Hiển thị kết quả ra Console với đánh giá tự động
        #10;
        $display("\n===========================================");
        $display("             KẾT QUẢ KIỂM THỬ (TEST LOG)   ");
        $display("===========================================");

        // Task 1: Test STO (và hệ quả của LDA, ADD)
        if (u_mem.ram[22] == 8'd15) 
            $display("[PASSED] Task 1 (LDA, ADD, STO): Ghi vao RAM[22] thanh cong gia tri 15.");
        else 
            $display("[FAILED] Task 1 (LDA, ADD, STO): RAM[22] = %d (Ky vong: 15).", u_mem.ram[22]);

        // Task 2: Test Logic & Co Zero (AND, XOR)
        if (is_zero == 1'b1) 
            $display("[PASSED] Task 2 (AND, XOR): Phep XOR (15^15) da tao ra ket qua 0, kich hoat co is_zero = 1.");
        else 
            $display("[FAILED] Task 2 (AND, XOR): Co is_zero khong bat (Gia tri: %b).", is_zero);

        // Task 3: Test Re nhanh (SKZ, JMP)
        if (acc_out == 8'd99) 
            $display("[PASSED] Task 3 (SKZ, JMP): Lenh SKZ hoat dong dung, da bo qua JMP, ACC nhan gia tri 99.");
        else if (acc_out == 8'd0)
            $display("[FAILED] Task 3 (SKZ, JMP): Lenh SKZ that bai, CPU da chay lenh JMP va roi vao HLT som.");
        else
            $display("[FAILED] Task 3 (SKZ, JMP): ACC hien tai la %d (Ky vong: 99).", acc_out);

        $display("===========================================\n");
        $finish;
    end
endmodule