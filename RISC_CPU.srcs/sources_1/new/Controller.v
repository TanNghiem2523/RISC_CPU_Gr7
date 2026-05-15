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
//    assign sel    = ((state == `INST_ADDR) || (state == `INST_FETCH) || 
//                     (state == `INST_LOAD)  || (state == `IDLE)) ? `SEL_PC : `SEL_IR;
//    // Chỉ rd=1 tại INST_FETCH (kích hoạt đọc)
//// Dữ liệu sẵn sàng tại INST_LOAD → ld_ir chỉ cần ở INST_LOAD
//assign rd = (state == `INST_FETCH || state == `INST_LOAD) || 
//                (is_aluop && (state == `OP_FETCH || state == `ALU_OP || state == `STORE));
//assign ld_ir = (state == `INST_LOAD); // bỏ IDLE
//    assign halt   = (state == `OP_ADDR) && (opcode == `HLT);
//    assign inc_pc = (rst) ? 1'b0 :
//                    ((state == `OP_ADDR) && (opcode != `HLT)) || 
//                    ((state == `ALU_OP) && (opcode == `SKZ) && (is_zero === 1'b1));
//    assign ld_ac  = (state == `STORE)   && is_aluop;
//    assign ld_pc  = (state == `STORE) && (opcode == `JMP);
//    assign data_e = (state == `STORE) && (opcode == `STO);
//    assign wr     = ((state == `STORE)  && (opcode == `STO)) ? `WRITE_MEM : 1'b0;
// sel: Giữ nguyên như bạn đã làm (Đúng theo ảnh)
    assign sel = ((state == `INST_ADDR) || (state == `INST_FETCH) || 
                  (state == `INST_LOAD) || (state == `IDLE)) ? `SEL_PC : `SEL_IR;

    // rd: Mở rộng thêm state IDLE để khớp testbench
    assign rd = (state == `INST_FETCH || state == `INST_LOAD || state == `IDLE) || 
                (is_aluop && (state == `OP_FETCH || state == `ALU_OP || state == `STORE));

    // ld_ir: Bật ở cả LOAD và IDLE theo kỳ vọng của TB
    assign ld_ir = (state == `INST_LOAD || state == `IDLE);

    // inc_pc: Bật ở nhịp địa chỉ (trừ HLT) và nhịp ALU_OP nếu là SKZ và có cờ Zero
    assign inc_pc = ((state == `OP_ADDR) && (opcode != `HLT)) || 
                    ((state == `ALU_OP) && (opcode == `SKZ) && (is_zero == 1'b1));

    // data_e: Bật sớm từ nhịp ALU_OP cho lệnh STO
    assign data_e = (opcode == `STO) && (state == `ALU_OP || state == `STORE);

    // ld_pc: Bật sớm từ nhịp ALU_OP cho lệnh JMP
    assign ld_pc = (opcode == `JMP) && (state == `ALU_OP || state == `STORE);

    // ld_ac và wr: Giữ nguyên ở nhịp STORE (Cuối chu kỳ)
    assign ld_ac = (state == `STORE) && is_aluop;
    assign wr    = (state == `STORE) && (opcode == `STO) ? `WRITE_MEM : 1'b0;

    // halt: Vẫn giữ ở OP_ADDR để dừng sớm
    assign halt  = (state == `OP_ADDR) && (opcode == `HLT);
    
endmodule
