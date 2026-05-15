`timescale 1ns / 1ps
`include "define.v"

// FIX: Bỏ data_bus tristate nội bộ
// acc_out luôn có giá trị; top-level sẽ dùng nó trực tiếp khi cần (STO)
module ACC(
    input  wire                    clk,
    input  wire                    rst,
    input  wire                    ld_ac,
    input  wire [`DATA_WIDTH-1:0]  acc_in,
    output reg  [`DATA_WIDTH-1:0]  acc_out
);
    always @(posedge clk) begin
        if (rst)
            acc_out <= {`DATA_WIDTH{1'b0}};
        else if (ld_ac)
            acc_out <= acc_in;
    end
endmodule