`timescale 1ns / 1ps
`include "define.v"

//////////////////////////////////////////////////////////////////////////////////
// Module Name : RISC_CPU (Top-level)
//
// FIX 1: Thêm output ports (halt, acc_out, pc_out) để Vivado không xóa logic
// FIX 2: Thay thế tristate data_bus nội bộ bằng 2 wire riêng:
//         - mem_data_out : Memory → IR, ALU (đọc)
//         - acc_out      : ACC   → Memory data_in (ghi khi STO)
// Lý do: FPGA chỉ hỗ trợ tristate trên I/O pin, không hỗ trợ bên trong chip.
//////////////////////////////////////////////////////////////////////////////////

module RISC_CPU (
    input  wire                    clk,
    input  wire                    rst,
    // Output ports bắt buộc để tránh synthesizer xóa toàn bộ logic
    output wire                    halt,
    output wire [`DATA_WIDTH-1:0]  acc_out,
    output wire [`DATA_WIDTH-1:0]  pc_out
);

    // =========================================================
    // Internal wires
    // =========================================================

    // FIX: Tách thành 2 wire một chiều thay vì 1 inout tristate
    wire [`DATA_WIDTH-1:0]   mem_data_out;  // Memory → IR & ALU inB
    // acc_out đã là output port, dùng trực tiếp làm data_in cho Memory (STO)

    wire [`ADDR_WIDTH-1:0]   mem_addr;
    wire [`OPCODE_WIDTH-1:0] opcode;
    wire [`ADDR_WIDTH-1:0]   operand;
    wire [`DATA_WIDTH-1:0]   alu_out;
    wire                     is_zero;

    // Control signals
    wire sel, rd, ld_ir, inc_pc, ld_ac, ld_pc, wr, data_e;

    // =========================================================
    // Module instantiation
    // =========================================================

    // 1) Program Counter
    program_counter u_pc (
        .clk    (clk),
        .reset  (rst),
        .inc_pc (inc_pc),
        .ld_pc  (ld_pc),
        .pc_in  ({{(`DATA_WIDTH-`ADDR_WIDTH){1'b0}}, operand}),
        .pc_out (pc_out)
    );

    // 2) Address Mux
    address_mux u_addr_mux (
        .sel      (sel),
        .pc_addr  (pc_out[`ADDR_WIDTH-1:0]),
        .ir_addr  (operand),
        .mem_addr (mem_addr)
    );

    // 3) Memory (đã sửa: inout → data_in + data_out riêng)
    //    data_in = acc_out : khi STO, ghi giá trị ACC vào RAM
    //    data_out = mem_data_out : khi đọc, cấp cho IR và ALU
    memory u_mem (
        .clk      (clk),
        .addr     (mem_addr),
        .data_in  (acc_out),
        .data_out (mem_data_out),
        .rd       (rd),
        .wr       (wr)
    );

    // 4) Instruction Register
    IR u_ir (
        .clk     (clk),
        .rst     (rst),
        .ld_ir   (ld_ir),
        .data_in (mem_data_out),
        .opcode  (opcode),
        .operand (operand)
    );

    // 5) ALU
    //    inA = acc_out | inB = mem_data_out
    ALU u_alu (
        .opcode  (opcode),
        .inA     (acc_out),
        .inB     (mem_data_out),
        .out     (alu_out),
        .is_zero (is_zero)
    );

    // 6) Accumulator (đã sửa: bỏ data_bus tristate)
    ACC u_acc (
        .clk     (clk),
        .rst     (rst),
        .ld_ac   (ld_ac),
        .acc_in  (alu_out),
        .acc_out (acc_out)
    );

    // 7) Controller
    Controller u_ctrl (
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