`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 02:10:14 AM
// Design Name: 
// Module Name: memory
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

module memory (
    input clk,
    input  [`ADDR_WIDTH-1:0] addr,   
    inout  [`DATA_WIDTH-1:0] data,    
    input rd,             
    input wr               
);
    reg [`DATA_WIDTH-1:0] ram [0:`ADDR_SPACE-1]; 
   assign data = (rd) ? ram[addr] : {`DATA_WIDTH{1'bz}};
integer i;
initial begin
    for (i = 0; i < `ADDR_SPACE; i = i + 1) begin
        ram[i] = {`DATA_WIDTH{1'b0}};
    end
end
always @(posedge clk) begin
    if (wr) ram[addr] <= data;
end
endmodule