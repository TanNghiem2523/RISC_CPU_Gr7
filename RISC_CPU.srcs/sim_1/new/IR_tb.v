`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 05:51:54 PM
// Design Name: 
// Module Name: IR_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IR_tb();
reg clk_cpu;
reg ld_ir;
reg rst;
reg  [`DATA_WIDTH-1:0]     data_in;  
wire [`OPCODE_WIDTH-1:0]   opcode;
wire [4:0]                 operand;
IR UUT (
        .clk_cpu(clk_cpu),
        .rst(rst),
        .ld_ir(ld_ir),
        .data_in(data_in),
        .opcode(opcode),
        .operand(operand)
    );
always #5 clk_cpu = ~clk_cpu;
initial begin
clk_cpu = 0;
ld_ir = 0;
data_in = 0;
rst = 1;
#10
rst = 0;
//Test1 
data_in = 32'b10101010; 
        ld_ir   = 1;
        #10; 
        $display("TC1 - Nap lan dau: data_in = %b | opcode = %b, operand = %b", data_in[7:0], opcode, operand);
        if (opcode == 3'b101 && operand == 5'b01010) $display(" -> TC1: PASSED");
        else $display(" -> TC1: FAILED");

//test 2
        data_in = 32'b01110011; 
        ld_ir   = 1;
        #10;
        $display("TC2 - Ghi de   : data_in = %b | opcode = %b, operand = %b", data_in[7:0], opcode, operand);
        if (opcode == 3'b011 && operand == 5'b10011) $display(" -> TC2: PASSED");
        else $display(" -> TC2: FAILED");
        
//test 3
        data_in = 32'b00010001; 
        ld_ir   = 0;  
        #10;
        $display("TC3 - ld_ir=0  : data_in = %b | opcode = %b, operand = %b", data_in[7:0], opcode, operand);
        if (opcode == 3'b011 && operand == 5'b10011) $display(" -> TC3: PASSED");
        else $display(" -> TC3: FAILED");

//test 4
        data_in = 32'b00010001; 
        ld_ir   = 1; 
        #10;
        $display("TC4 - ld_ir=1  : data_in = %b | opcode = %b, operand = %b", data_in[7:0], opcode, operand);
        if (opcode == 3'b000 && operand == 5'b10001) $display(" -> TC4: PASSED");
        else $display(" -> TC4: FAILED");

//test 5
          
        data_in = 32'b11100000; 
        ld_ir   = 1;
        #6
        ld_ir   = 0;   
        #4   
        $display("TC5 - Nhay cam : data_in = %b | opcode = %b, operand = %b", data_in[7:0], opcode, operand);
        if (opcode == 3'b111 && operand == 5'b00000) $display(" -> TC5: PASSED");
        else $display(" -> TC5: FAILED");
// Test 6
        rst = 1;
        #10;
        $display("TC6 - Test rst : rst = 1 | opcode = %b, operand = %b ", opcode, operand);
        if (opcode == 3'b000 && operand == 5'b00000) $display(" -> TC6: PASSED");
        else $display(" -> TC6: FAILED");

// Test 7
        rst = 1;
        ld_ir = 1;
        data_in = 32'b11111111;
        #10;
        $display("TC7 - Uu tien  : rst=1, ld_ir=1 | opcode = %b, operand = %b ", opcode, operand);
        if (opcode == 3'b000 && operand == 5'b00000) $display(" -> TC7: PASSED");
        else $display(" -> TC7: FAILED");
        $finish;
end 
endmodule
