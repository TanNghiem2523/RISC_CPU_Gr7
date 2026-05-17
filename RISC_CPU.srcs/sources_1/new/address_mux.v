`timescale 1ns / 1ps
`include "define.v"
module address_mux(
    input wire sel,                             
    input wire [`ADDR_WIDTH-1:0] pc_addr,       
    input wire [`ADDR_WIDTH-1:0] ir_addr,   
    output wire [`ADDR_WIDTH-1:0] mem_addr
    );
    assign mem_addr = (sel == `SEL_PC) ? pc_addr : ir_addr;
endmodule
