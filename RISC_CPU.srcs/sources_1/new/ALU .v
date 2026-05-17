`timescale 1ns / 1ps
`include "define.v" 

module ALU(
    input  [`OPCODE_WIDTH-1:0] opcode,
    input  [`DATA_WIDTH-1:0]   inA,
    input  [`DATA_WIDTH-1:0]   inB,
    output reg [`DATA_WIDTH-1:0] out, 
    output is_zero       
);

    assign is_zero = (inA === {`DATA_WIDTH{1'b0}});

    always @(*) begin
        case(opcode)
            `HLT: out = inA;
            `SKZ: out = inA;
            `ADD: out = inA + inB& 'hFF;    
            `AND: out = inA & inB;    
            `XOR: out = inA ^ inB; 
            `LDA: out = inB;       
            `STO: out = inA;     
            `JMP: out = inA;
            default: out = {`DATA_WIDTH{1'b0}}; 
        endcase
    end
    
endmodule
