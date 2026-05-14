`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2026 10:17:34 PM
// Design Name: 
// Module Name: address_mux
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
module address_mux(
    input wire sel,                             
    input wire [`ADDR_WIDTH-1:0] pc_addr,       
    input wire [`ADDR_WIDTH-1:0] ir_addr,   
    output wire [`ADDR_WIDTH-1:0] mem_addr
    );
    assign mem_addr = (sel == `SEL_PC) ? pc_addr : ir_addr;
endmodule
