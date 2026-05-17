`timescale 1ns / 1ps
`include "define.v"
module program_counter (
    input wire clk,
    input wire reset,
    input wire inc_pc,
    input wire ld_pc,
    input wire [`DATA_WIDTH-1:0] pc_in,
    output reg [`DATA_WIDTH-1:0] pc_out
);
always @(posedge clk) begin
if (reset) begin
pc_out <= {`DATA_WIDTH{1'b0}};
end
else if(ld_pc)begin
pc_out <= pc_in;
end
else if (inc_pc) begin
            pc_out <= pc_out + 1'b1; 
        end
end
endmodule