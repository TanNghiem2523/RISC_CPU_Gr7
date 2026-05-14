`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2026 08:33:44 PM
// Design Name: 
// Module Name: program_counter
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