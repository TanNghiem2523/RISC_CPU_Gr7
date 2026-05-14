`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 09:19:51 PM
// Design Name: 
// Module Name: ALU
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


`timescale 1ns / 1ps
`include "define.v" // Khai bao file define de lay cac thong so do rong va Opcode

module ALU(
    input  [`OPCODE_WIDTH-1:0] opcode,
    input  [`DATA_WIDTH-1:0]   inA,
    input  [`DATA_WIDTH-1:0]   inB,
    output reg [`DATA_WIDTH-1:0] out, 
    output is_zero       
);
    // Kiem tra co Zero (Bang 1 neu inA bang 0)
    assign is_zero = (inA == {`DATA_WIDTH{1'b0}}) ? 1'b1 : 1'b0;

    always @(*) begin
        case(opcode)
            `HLT: out = inA;
            `SKZ: out = inA;
            `ADD: out = inA + inB;    
            `AND: out = inA & inB;    
            `XOR: out = inA ^ inB; 
            `LDA: out = inB;       
            `STO: out = inA;     
            `JMP: out = inA;
            default: out = {`DATA_WIDTH{1'b0}}; // Tra ve 0 neu opcode khong hop le
        endcase
    end
    
endmodule
