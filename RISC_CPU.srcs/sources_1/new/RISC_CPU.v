`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name : RISC_CPU
// Description : Top-level kết nối toàn bộ các module của RISC CPU
//
// ┌─────────────────────────────────────────────────────────────────────┐
// │                      KIẾN TRÚC BUS CHUNG                           │
// │                                                                     │
// │  [PC] ──pc_out──► [address_mux] ──mem_addr──► [memory]             │
// │                         ▲                        │  ▲              │
// │  [IR].operand ──ir_addr─┘          sel(CTR)      │  │wr(CTR)       │
// │                                                  │  │              │
// │                      DATA BUS (tri-state) ◄──────┘  │              │
// │                           │  ▲                      │              │
// │           ┌───────────────┼──┼──────────────────────┘              │
// │           │               │  └─ ACC.data_bus (khi data_e=1)        │
// │    IR.data_in          ALU.inB                                      │
// │                           │                                         │
// │  [ACC].acc_out ──inA──► [ALU] ──alu_out──► [ACC].acc_in            │
// │                                                                     │
// │  [Controller] ◄── opcode, is_zero                                  │
// │       └──────► sel, rd, ld_ir, inc_pc, ld_ac, ld_pc, wr, data_e   │
// └─────────────────────────────────────────────────────────────────────┘
//
// Các giai đoạn FSM (Controller):
//   INST_ADDR  (000): sel=PC  → chuẩn bị địa chỉ lệnh
//   INST_FETCH (001): sel=PC  → rd=1, bộ nhớ xuất lệnh lên bus
//   INST_LOAD  (010): sel=PC  → ld_ir=1, IR chốt lệnh từ bus
//   IDLE       (011): sel=PC  → giải mã, inc_pc chuẩn bị
//   OP_ADDR    (100): sel=IR  → chuẩn bị địa chỉ toán hạng (hoặc HALT)
//   OP_FETCH   (101): sel=IR  → rd=1, bộ nhớ xuất toán hạng lên bus
//   ALU_OP     (110): sel=IR  → ALU tính toán (SKZ check zero / JMP load PC)
//   STORE      (111): sel=IR  → ld_ac=1 (ALU ops) / wr=1 (STO) / ld_pc (JMP)
//////////////////////////////////////////////////////////////////////////////////
`include "define.v"

module RISC_CPU (
    input wire clk,
    input wire rst,
    output wire out_halt
);

    //==========================================================================
    // BUS DỮ LIỆU CHUNG (Shared Tri-state Data Bus - 32-bit)
    //   Ai lái bus:
    //     memory : khi rd   = 1  (xuất lệnh hoặc toán hạng ra bus)
    //     ACC    : khi data_e = 1 (lệnh STO - đưa giá trị ACC lên bus để ghi)
    //   Ai đọc bus:
    //     IR     : qua data_in   (chốt lệnh vào thanh ghi)
    //     ALU    : qua inB       (đọc toán hạng từ bộ nhớ)
    //==========================================================================
    wire [`DATA_WIDTH-1:0] data_bus;

    // --- Địa chỉ ---
    wire [`ADDR_WIDTH-1:0] pc_out;   // Địa chỉ hiện tại của PC
    wire [4:0]             operand;  // 5-bit toán hạng từ IR [4:0]
    wire [`ADDR_WIDTH-1:0] ir_addr;  // operand zero-extended → 32-bit
    wire [`ADDR_WIDTH-1:0] mem_addr; // Địa chỉ sau MUX → bộ nhớ

    // --- Dữ liệu / Trạng thái ---
    wire [`OPCODE_WIDTH-1:0] opcode;  // Mã lệnh từ IR [7:5]
    wire [`DATA_WIDTH-1:0]   acc_out; // Giá trị hiện tại của ACC
    wire [`DATA_WIDTH-1:0]   alu_out; // Kết quả tính toán ALU
    wire                     is_zero; // Cờ Zero: ACC = 0

    // --- Tín hiệu điều khiển (từ Controller) ---
    wire sel;     // Chọn địa chỉ : SEL_PC=1 (fetch), SEL_IR=0 (data)
    wire rd;      // Kích hoạt đọc bộ nhớ
    wire ld_ir;   // Nạp lệnh vào IR
    wire halt;
    

    wire inc_pc;  // Tăng PC + 1
    wire ld_ac;   // Nạp kết quả ALU vào ACC
    wire ld_pc;   // Nạp địa chỉ nhảy vào PC (JMP)
    wire wr;      // Kích hoạt ghi bộ nhớ (STO)
    wire data_e;  // Cho phép ACC lái data_bus

    //==========================================================================
    // Zero-extend: operand[4:0] → ir_addr[31:0]
    // Dùng làm địa chỉ toán hạng (address_mux) và địa chỉ nhảy (PC khi JMP)
    //==========================================================================
    assign ir_addr = {{(`ADDR_WIDTH - 5){1'b0}}, operand};
    assign out_halt = halt;    //==========================================================================
    // Program Counter
    //   inc_pc=1 : PC ← PC + 1
    //   ld_pc=1  : PC ← ir_addr  (nhảy vô điều kiện JMP)
    //   Tên port reset (không phải rst) theo đúng program_counter.v
    //==========================================================================
    program_counter u_pc (
        .clk    (clk),
        .reset  (rst),
        .inc_pc (inc_pc),
        .ld_pc  (ld_pc),
        .pc_in  (ir_addr),
        .pc_out (pc_out)
    );

    //==========================================================================
    // Address MUX
    //   sel=SEL_PC(1) → mem_addr = pc_out   (đang fetch lệnh)
    //   sel=SEL_IR(0) → mem_addr = ir_addr  (đang truy cập toán hạng)
    //==========================================================================
    address_mux u_address_mux (
        .sel     (sel),
        .pc_addr (pc_out),
        .ir_addr (ir_addr),
        .mem_addr(mem_addr)
    );

    //==========================================================================
    // Memory (inout data bus)
    //   rd=1 → memory lái data_bus (đọc ra ngoài)
    //   wr=1 → memory đọc data_bus (ACC đang lái qua data_e)
    //==========================================================================
    memory u_memory (
        .clk  (clk),
        .addr (mem_addr),
        .data (data_bus),
        .rd   (rd),
        .wr   (wr)
    );

    //==========================================================================
    // Instruction Register (IR)
    //   ld_ir=1 → chốt data_bus vào ir_reg tại posedge clk
    //   Xuất: opcode = ir_reg[7:5], operand = ir_reg[4:0]
    //==========================================================================
    IR u_ir (
        .clk     (clk),
        .rst     (rst),
        .ld_ir   (ld_ir),
        .data_in (data_bus),
        .opcode  (opcode),
        .operand (operand)
    );

    //==========================================================================
    // ALU
    //   inA = acc_out  : toán hạng A (thanh ghi tích lũy)
    //   inB = data_bus : toán hạng B (dữ liệu từ bộ nhớ)
    //   is_zero kiểm tra inA=0, phục vụ lệnh SKZ
    //==========================================================================
    ALU u_alu (
        .opcode  (opcode),
        .inA     (acc_out),
        .inB     (data_bus),
        .out     (alu_out),
        .is_zero (is_zero)
    );

    //==========================================================================
    // Accumulator (ACC)
    //   ld_ac=1  : acc_out ← alu_out  (cập nhật kết quả tính toán)
    //   data_e=1 : acc_out → data_bus  (lái bus để ghi vào bộ nhớ - STO)
    //==========================================================================
    ACC u_acc (
        .clk      (clk),
        .rst      (rst),
        .ld_ac    (ld_ac),
        .acc_in   (alu_out),
        .data_e   (data_e),
        .acc_out  (acc_out),
        .data_bus (data_bus)
    );

    //==========================================================================
    // Controller (FSM 8 trạng thái)
    //   Đầu vào : opcode, is_zero
    //   Đầu ra  : toàn bộ tín hiệu điều khiển hệ thống
    //==========================================================================
    Controller u_controller (
        .clk     (clk),
        .rst     (rst),
        .is_zero (is_zero),
        .opcode  (opcode),
        .sel     (sel),
        .rd      (rd),
        .ld_ir   (ld_ir),
        .halt    (halt),
        .inc_pc  (inc_pc),
        .ld_ac   (ld_ac),
        .ld_pc   (ld_pc),
        .wr      (wr),
        .data_e  (data_e)
    );
    
endmodule