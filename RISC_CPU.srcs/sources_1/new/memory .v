`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2026 02:10:14 AM
// Design Name: 
// Module Name: memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`include "define.v" // Chèn file define để lấy thông số

module memory (
    input clk,
    input  [`ADDR_WIDTH-1:0] addr,     // Tự động lấy độ rộng địa chỉ (32-bit)
    inout  [`DATA_WIDTH-1:0] data,     // Tự động lấy độ rộng dữ liệu (32-bit)
    input rd,              // Tín hiệu Read từ Controller
    input wr               // Tín hiệu Write từ Controller
);

    // Khai báo mảng RAM với chiều sâu ADDR_SPACE (32 ô nhớ)
    reg [`DATA_WIDTH-1:0] ram [0:`ADDR_SPACE-1]; 

    // Chỉ lái bus ra khi rd = 1, còn lại thả Z hết. 
    // Dùng replication operator {`DATA_WIDTH{1'bz}} để thả Z chuẩn theo số bit.

   assign data = (rd) ? ram[addr] : {`DATA_WIDTH{1'bz}};
integer i;
initial begin
    for (i = 0; i < `ADDR_SPACE; i = i + 1) begin
        ram[i] = {`DATA_WIDTH{1'b0}};
    end
end
always @(posedge clk) begin
    if (wr) ram[addr] <= data;
end
endmodule