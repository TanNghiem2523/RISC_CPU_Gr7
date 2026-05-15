`timescale 1ns / 1ps
`include "define.v"
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
            ir_reg <= 32'b0; 
        end
        else if(ld_ir) begin
            ir_reg <= data_in;
        end
    end
    assign opcode = ir_reg[7:5];
    assign operand = ir_reg[4:0];
endmodule
