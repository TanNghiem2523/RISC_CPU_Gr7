`timescale 1ns / 1ps
`include "define.v" // Chèn file define để lấy các thông số hệ thống

module ALU_tb;

    // 1. Khai báo các tín hiệu kết nối bằng Macro từ define.v
    reg  [`OPCODE_WIDTH-1:0] opcode;
    reg  [`DATA_WIDTH-1:0]   inA;
    reg  [`DATA_WIDTH-1:0]   inB;
    wire [`DATA_WIDTH-1:0]   out;
    wire is_zero;

    // 2. Gọi module ALU cần kiểm tra
    ALU uut (
        .opcode(opcode),
        .inA(inA),
        .inB(inB),
        .out(out),
        .is_zero(is_zero)
    );

    // 3. Quy trình kiểm tra (Stimulus)
    initial begin
        // Định dạng hiển thị kết quả ra màn hình console
        $display("Time | Op |   inA    |   inB    |   Out    | Zero");
        $display("--------------------------------------------------");

        // --- Test HLT (000): Output = inA --- 
        inA = 32'd10; inB = 32'd50; opcode = `HLT;
        #10; $display("%4t | HLT| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // --- Test SKZ (001): Output = inA --- 
        // Kiểm tra xem is_zero có lên 1 khi inA = 0 không 
        inA = 32'd0; inB = 32'd99; opcode = `SKZ;
        #10; $display("%4t | SKZ| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // --- Test ADD (010): Output = inA + inB --- 
        inA = 32'd100; inB = 32'd250; opcode = `ADD;
        #10; $display("%4t | ADD| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // --- Test AND (011): Output = inA & inB --- 
        inA = 32'h0000FFFF; inB = 32'hFFFF0001; opcode = `AND;
        #10; $display("%4t | AND| %h | %h | %h |  %b", $time, inA, inB, out, is_zero);

        // --- Test XOR (100): Theo code bạn là inA ^ inB --- 
        inA = 32'hAAAAAAAA; inB = 32'h55555555; opcode = `XOR;
        #10; $display("%4t | XOR| %h | %h | %h |  %b", $time, inA, inB, out, is_zero);

        // --- Test LDA (101): Output = inB --- 
        inA = 32'd44; inB = 32'd88; opcode = `LDA;
        #10; $display("%4t | LDA| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // --- Test STO (110): Output = inA --- 
        inA = 32'd123; inB = 32'd456; opcode = `STO;
        #10; $display("%4t | STO| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // --- Test JMP (111): Output = inA --- 
        inA = 32'd555; inB = 32'd0; opcode = `JMP;
        #10; $display("%4t | JMP| %8d | %8d | %8d |  %b", $time, inA, inB, out, is_zero);

        // Kết thúc mô phỏng
        $display("--------------------------------------------------");
        #20;
        $finish;
    end

endmodule