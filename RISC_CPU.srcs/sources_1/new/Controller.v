`timescale 1ns / 1ps
`include "define.v"
module Controller(
    input clk, rst, is_zero,
    input [`OPCODE_WIDTH-1:0] opcode,
    output sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e
    );
    reg [2:0] state, next_state;
    wire is_aluop = (opcode == `ADD) || (opcode == `AND) || (opcode == `XOR) || (opcode == `LDA);
    
    always @(posedge clk) begin
        if(rst) 
            state <= `INST_ADDR;
        else if(halt) 
                state <= state;
            else 
                state <= next_state;
    end
    always @(*) begin
        case (state)
            `INST_ADDR:  next_state = `INST_FETCH;
            `INST_FETCH: next_state = `INST_LOAD;
            `INST_LOAD:  next_state = `IDLE;
            `IDLE:       next_state = `OP_ADDR;
            `OP_ADDR:    next_state = `OP_FETCH;
            `OP_FETCH:   next_state = `ALU_OP;
            `ALU_OP:     next_state = `STORE;
            `STORE:      next_state = `INST_ADDR;
            default:     next_state = `INST_ADDR;
        endcase
    end

    assign sel = ((state == `INST_ADDR) || (state == `INST_FETCH) || 
                  (state == `INST_LOAD) || (state == `IDLE)) ? `SEL_PC : `SEL_IR;
    assign rd = (state == `INST_FETCH || state == `INST_LOAD || state == `IDLE) || 
                (is_aluop && (state == `OP_FETCH || state == `ALU_OP || state == `STORE));
    assign ld_ir = (state == `INST_LOAD || state == `IDLE);

    assign inc_pc = ((state == `OP_ADDR) && (opcode != `HLT)) || 
                    ((state == `ALU_OP) && (opcode == `SKZ) && (is_zero == 1'b1));

    assign data_e = (opcode == `STO) && (state == `ALU_OP || state == `STORE);


    assign ld_pc = (opcode == `JMP) && (state == `ALU_OP || state == `STORE);

    assign ld_ac = (state == `STORE) && is_aluop;
    assign wr    = (state == `STORE) && (opcode == `STO) ? `WRITE_MEM : 1'b0;

    assign halt  = (state == `OP_ADDR) && (opcode == `HLT);
    
endmodule
