`timescale 1ns / 1ps

`include "define.v"

module RISC_CPU (
    input wire clk,
    input wire rst,
    output wire out_halt
);
    wire [`DATA_WIDTH-1:0] data_bus;
    wire [`ADDR_WIDTH-1:0] pc_out;   
    wire [4:0]             operand;  
    wire [`ADDR_WIDTH-1:0] ir_addr;  
    wire [`ADDR_WIDTH-1:0] mem_addr;
    wire [`OPCODE_WIDTH-1:0] opcode; 
    wire [`DATA_WIDTH-1:0]   acc_out; 
    wire [`DATA_WIDTH-1:0]   alu_out; 
    wire                     is_zero; 
 
    wire sel;     
    wire rd;   
    wire ld_ir;   
    wire halt;
    

    wire inc_pc;  
    wire ld_ac;  
    wire ld_pc;   
    wire wr;     
    wire data_e; 
    assign ir_addr = {{(`ADDR_WIDTH - 5){1'b0}}, operand};
    assign out_halt = halt;   
    program_counter u_pc (
        .clk    (clk),
        .reset  (rst),
        .inc_pc (inc_pc),
        .ld_pc  (ld_pc),
        .pc_in  (ir_addr),
        .pc_out (pc_out)
    );
    address_mux u_address_mux (
        .sel     (sel),
        .pc_addr (pc_out),
        .ir_addr (ir_addr),
        .mem_addr(mem_addr)
    );
    memory u_memory (
        .clk  (clk),
        .addr (mem_addr),
        .data (data_bus),
        .rd   (rd),
        .wr   (wr)
    );

    IR u_ir (
        .clk     (clk),
        .rst     (rst),
        .ld_ir   (ld_ir),
        .data_in (data_bus),
        .opcode  (opcode),
        .operand (operand)
    );

    ALU u_alu (
        .opcode  (opcode),
        .inA     (acc_out),
        .inB     (data_bus),
        .out     (alu_out),
        .is_zero (is_zero)
    );

    ACC u_acc (
        .clk      (clk),
        .rst      (rst),
        .ld_ac    (ld_ac),
        .acc_in   (alu_out),
        .data_e   (data_e),
        .acc_out  (acc_out),
        .data_bus (data_bus)
    );

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
