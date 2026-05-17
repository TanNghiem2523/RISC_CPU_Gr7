`timescale 1ns / 1ps

module ACC_tb();
    reg clk;
    reg rst;
    reg ld_ac;
    reg  [`DATA_WIDTH-1:0] acc_in;
    reg data_e;
    wire [`DATA_WIDTH-1:0] acc_out;
    wire [`DATA_WIDTH-1:0] data_bus;

    ACC UUT (
        .clk(clk),
        .rst(rst),
        .ld_ac(ld_ac),
        .acc_in(acc_in),
        .data_e(data_e),
        .acc_out(acc_out),
        .data_bus(data_bus)
    );
    always #5 clk = ~clk;

    initial begin

        clk = 0;
        rst     = 1;
        ld_ac   = 0;
        acc_in  = 0;
        data_e  = 0;
        
        $display("BAT DAU KIEM THU MODULE ACCUMULATOR...");
        $display("---------------------------------------------------------");

        #15;
        // Testcase 1: Reset accumulator
        @(negedge clk);
        rst    = 1;
        ld_ac  = 0;
        data_e = 0;
        
        @(posedge clk); #1;
        $display("TC1 - Reset        : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 0 && data_bus === {`DATA_WIDTH{1'bz}}) $display(" -> TC1: PASSED");
        else $display(" -> TC1: FAILED");

        // Testcase 2: Load 

        @(negedge clk);
        rst    = 0;     
        ld_ac  = 1;      
        acc_in = 32'h5A; 
        data_e = 0;      
        
        @(posedge clk); #1;
        $display("TC2 - Load 0x5A    : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 32'h5A && data_bus === {`DATA_WIDTH{1'bz}}) $display(" -> TC2: PASSED");
        else $display(" -> TC2: FAILED");

        @(negedge clk);
        ld_ac  = 0; 
        data_e = 1; 
        
        @(posedge clk); #1;
        $display("TC3 - Enable Bus   : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 32'h5A && data_bus === 32'h5A) $display(" -> TC3: PASSED");
        else $display(" -> TC3: FAILED");


        // Testcase 4: Load 

        @(negedge clk);
        data_e = 0;       
        ld_ac  = 1;       
        acc_in = 32'hA5; 
        
        @(posedge clk); #1;
        $display("TC4 - Load 0xA5    : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 32'hA5 && data_bus === {`DATA_WIDTH{1'bz}}) $display(" -> TC4: PASSED");
        else $display(" -> TC4: FAILED");

        // Testcase 5: Reset lại
        @(negedge clk);
        rst   = 1;
        ld_ac = 1; 
        
        @(posedge clk); #1;
        $display("TC5 - Reset lai    : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 0 && data_bus === {`DATA_WIDTH{1'bz}}) $display(" -> TC5: PASSED");
        else $display(" -> TC5: FAILED");
        
        // Testcase 6: Hold State 
        @(negedge clk);
        rst    = 0;
        ld_ac  = 0;        
        acc_in = 32'hFFFF; 
        data_e = 0;
        
        @(posedge clk); #1;
        $display("TC6 - Hold State   : acc_out = %h, data_bus = %h", acc_out, data_bus);
        if (acc_out === 0 && data_bus === {`DATA_WIDTH{1'bz}}) $display(" -> TC6: PASSED");
        else $display(" -> TC6: FAILED");
        $display("---------------------------------------------------------");
        $display("HOAN TAT KIEM THU!");
        
        #20;
        $finish;
    end

endmodule