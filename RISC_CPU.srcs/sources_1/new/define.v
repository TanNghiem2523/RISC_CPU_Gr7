// -------------------------------------------------------------------------
// Project: Thiet ke RISC CPU don gian
// Khoa Khoa hoc va Ky thuat May tinh - HCMUT
// -------------------------------------------------------------------------
// Mục đích tạo file này: Tăng tính thống nhất, dễ dàng chỉnh sửa
//Cách dùng : Import source vào vivado, click chuột phải chọn Set Global Include 
`ifndef DEFINES_VH
`define DEFINES_VH

// 1. THÔNG SỐ ĐỘ RỘNG (Parameters)
`define DATA_WIDTH    32    // Do rong du lieu mac dinh
`define ADDR_WIDTH    32    // Do rong dia chi (Memory/Mux)
`define OPCODE_WIDTH  3     // 3-bit opcode
`define ADDR_SPACE    32    // 32 khong gian dia chi

// 2. MÃ OPCODE (ALU Operations)
`define HLT 3'b000   // Dung hoat dong chuong trinh
`define SKZ 3'b001   // Kiem tra zero, bo qua lenh tiep theo
`define ADD 3'b010   // Cong Accumulator voi bo nho
`define AND 3'b011   // Phep toan AND logic
`define XOR 3'b100   // Phep toan XOR logic
`define LDA 3'b101   // Doc gia tri tu bo nho vao Accumulator
`define STO 3'b110   // Ghi du lieu Accumulator vao bo nho
`define JMP 3'b111   // Lenh nhay khong dieu kien

// 3. CÁC TRẠNG THÁI CỦA BỘ ĐIỀU KHIỂN (Controller States)
// Gom 8 trang thai hoat dong lien tuc
`define INST_ADDR  3'b000
`define INST_FETCH 3'b001
`define INST_LOAD  3'b010
`define IDLE       3'b011
`define OP_ADDR    3'b100
`define OP_FETCH   3'b101
`define ALU_OP     3'b110
`define STORE      3'b111

// 4. CÁC TÍN HIỆU ĐIỀU KHIỂN (Control Signals Logic)[cite: 1]
`define READ_MEM  1'b1
`define WRITE_MEM 1'b1
`define SEL_PC    1'b1
`define SEL_IR    1'b0

`endif // DEFINES_VH