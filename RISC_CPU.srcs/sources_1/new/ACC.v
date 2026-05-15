`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2026 08:34:54 PM
// Design Name: 
// Module Name: ACC
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
module ACC(
    input clk, 
    input rst, 
    input ld_ac,
    input [`DATA_WIDTH-1:0] acc_in, 
    input data_e,
    output reg[`DATA_WIDTH-1:0] acc_out,
    output wire[`DATA_WIDTH-1:0] data_bus
    );
    always @(posedge clk) begin
        if(rst) begin
            acc_out <= {`DATA_WIDTH{1'b0}};
        end 
        else if(ld_ac) begin
            acc_out <= acc_in;
        end
    end
    assign data_bus = (data_e) ? acc_out : {`DATA_WIDTH{1'bz}};
endmodule
