`timescale 1ns / 1ps
`include "define.v"

// FIX: Tách inout data thành data_in (ghi) và data_out (đọc)
// FPGA không hỗ trợ tristate bus nội bộ → phải dùng cổng riêng biệt
module memory (
    input  wire                    clk,
    input  wire [`ADDR_WIDTH-1:0]  addr,
    input  wire [`DATA_WIDTH-1:0]  data_in,   // Dữ liệu ghi vào RAM (từ ACC khi STO)
    output reg  [`DATA_WIDTH-1:0]  data_out,  // Dữ liệu đọc ra (đến IR / ALU)
    input  wire                    rd,
    input  wire                    wr
);
    reg [`DATA_WIDTH-1:0] ram [0:`ADDR_SPACE-1];

    always @(posedge clk) begin
        if (rd)
            data_out <= ram[addr];
        else if (wr)
            ram[addr] <= data_in;
    end
endmodule