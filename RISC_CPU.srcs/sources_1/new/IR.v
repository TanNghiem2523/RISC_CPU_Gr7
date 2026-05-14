`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2026 05:05:09 PM
// Design Name: 
// Module Name: IR
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


module IR(
    input clk,
    input rst,
    input ld_ir,
    input [`DATA_WIDTH-1:0] data_in,
    output [`OPCODE_WIDTH-1:0] opcode,
    output [4:0] operand
);
    reg [`DATA_WIDTH-1:0] ir_reg;
    always @(posedge clk) begin
        if (rst) begin
            ir_reg <= 0; 
        end
        else if(ld_ir) begin
            ir_reg <= data_in;
        end
    end
    assign opcode = ir_reg[7:5];
    assign operand = ir_reg[4:0];
endmodule
