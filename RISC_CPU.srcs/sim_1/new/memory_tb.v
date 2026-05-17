`timescale 1ns / 1ps
`include "define.v" // Chèn file define để đồng bộ thông số hệ thống

module memory_tb;

    reg clk;
    reg [`ADDR_WIDTH-1:0] addr;
    // Tín hiệu điều khiển mới (2 dây)
    reg rd;
    reg wr;
    reg [`DATA_WIDTH-1:0] data_reg; 
    wire [`DATA_WIDTH-1:0] data;

    // Khởi tạo Memory (phiên bản 2 chân)
    memory uut (
        .clk(clk),
        .addr(addr),
        .data(data),
        .rd(rd),
        .wr(wr)
    );

    // Testbench lái bus khi GHI (wr = 1), còn lại thả Z linh hoạt theo độ rộng dữ liệu
    assign data = (wr == 1'b1) ? data_reg : {`DATA_WIDTH{1'bz}};

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // --- 1. KHỞI TẠO (IDLE MODE) ---
        addr = 0;
        data_reg = 0;
        rd = 0; wr = 0; // Đưa vào trạng thái Nghỉ ban đầu
        
        $display("--- START TEST MEMORY (2-WIRE CONTROL) ---");
        #20; 

        // --- 2. QUY TRÌNH GHI (WRITE MODE) ---
        @(posedge clk); #1;  
        rd = 0; wr = 1;      // Bật chân Ghi, tắt chân Đọc
        addr = 5;
        data_reg = 32'hdeadbeef;
        $display("[%t] WRITE: Addr=%d, Data=%h", $time, addr, data_reg);
        
        @(posedge clk); #1;
        addr = 10;
        data_reg = 32'h12345678;
        $display("[%t] WRITE: Addr=%d, Data=%h", $time, addr, data_reg);

        // --- 3. TRẠNG THÁI NGHỈ & THẢ BUS (IDLE MODE) ---
        @(posedge clk); #1;
        rd = 0; wr = 0;      // Tắt cả Đọc và Ghi -> Idle
        data_reg = {`DATA_WIDTH{1'bz}};    // Testbench buông bus
        addr = 0;
        #10;                 // Chờ một chút để chứng minh bus đang ở trạng thái Z

        // --- 4. QUY TRÌNH ĐỌC (READ MODE) ---
        @(posedge clk); #1;    
        rd = 1; wr = 0;      // Bật chân Đọc, tắt chân Ghi
        addr = 5;      
        
        @(posedge clk); #1;    
        $display("[%t] READ Addr %d : Data=%h (Expected: deadbeef)", $time, addr, data);

        @(posedge clk); #1;
        addr = 10;     
        
        @(posedge clk); #1;
        $display("[%t] READ Addr %d : Data=%h (Expected: 12345678)", $time, addr, data);

        #50;
        $display("--- FINISH ---");
        $finish;
    end

endmodule