// File này được tạo bởi Nhóm 7 (K25)
`ifndef DEFINES_VH
`define DEFINES_VH
`define DATA_WIDTH    32    
`define ADDR_WIDTH    32    
`define OPCODE_WIDTH  3  
`define ADDR_SPACE    32   
`define HLT 3'b000   
`define SKZ 3'b001  
`define ADD 3'b010   
`define AND 3'b011   
`define XOR 3'b100  
`define LDA 3'b101  
`define STO 3'b110  
`define JMP 3'b111   
`define INST_ADDR  3'b000
`define INST_FETCH 3'b001
`define INST_LOAD  3'b010
`define IDLE       3'b011
`define OP_ADDR    3'b100
`define OP_FETCH   3'b101
`define ALU_OP     3'b110
`define STORE      3'b111
`define READ_MEM  1'b1
`define WRITE_MEM 1'b1
`define SEL_PC    1'b1
`define SEL_IR    1'b0
`endif 