`timescale 1ns / 1ps
`include "define.v"   // FIX: Thêm include thiếu (DATA_WIDTH, OPCODE_WIDTH)

module IR(
    input  wire                      clk,
    input  wire                      rst,
    input  wire                      ld_ir,
    input  wire [`DATA_WIDTH-1:0]    data_in,
    output wire [`OPCODE_WIDTH-1:0]  opcode,
    output wire [`ADDR_WIDTH-1:0]    operand
);
    reg [`DATA_WIDTH-1:0] ir_reg;

    always @(posedge clk) begin
        if (rst)
            ir_reg <= {`DATA_WIDTH{1'b0}};
        else if (ld_ir)
            ir_reg <= data_in;
    end

    assign opcode  = ir_reg[`DATA_WIDTH-1 : `DATA_WIDTH-`OPCODE_WIDTH];
    assign operand = ir_reg[`ADDR_WIDTH-1 : 0];
endmodule