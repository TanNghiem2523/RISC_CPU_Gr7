`timescale 1ns / 1ps
`include "define.v"

module controller_tb();
    reg clk;
    reg rst;
    reg is_zero;
    reg [2:0] opcode; 
    wire sel;
    wire rd;
    wire ld_ir;
    wire halt;
    wire inc_pc;
    wire ld_ac;
    wire ld_pc;
    wire wr;
    wire data_e;

    Controller dut (
        .clk(clk),
        .rst(rst),
        .is_zero(is_zero),
        .opcode(opcode),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .ld_ac(ld_ac),
        .ld_pc(ld_pc),
        .wr(wr),
        .data_e(data_e)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    task check_and_tick;
        input [8*12:1] state_name;
        input e_sel, e_rd, e_ld_ir, e_halt, e_inc_pc, e_ld_ac, e_ld_pc, e_wr, e_data_e;
        reg pass;
        begin
            pass = (sel === e_sel) && (rd === e_rd) && (ld_ir === e_ld_ir) && 
                   (halt === e_halt) && (inc_pc === e_inc_pc) && (ld_ac === e_ld_ac) && 
                   (ld_pc === e_ld_pc) && (wr === e_wr) && (data_e === e_data_e);
            
            if (pass) begin
                $display("[PASSED] %s | sel=%b rd=%b ld_ir=%b halt=%b inc_pc=%b ld_ac=%b ld_pc=%b wr=%b data_e=%b", 
                         state_name, sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e);
            end else begin
                $display("[FAILED] %s", state_name);
                $display("   + Thuc te (Actual)  : sel=%b rd=%b ld_ir=%b halt=%b inc_pc=%b ld_ac=%b ld_pc=%b wr=%b data_e=%b", 
                         sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e);
                $display("   + Ky vong (Expected): sel=%b rd=%b ld_ir=%b halt=%b inc_pc=%b ld_ac=%b ld_pc=%b wr=%b data_e=%b", 
                         e_sel, e_rd, e_ld_ir, e_halt, e_inc_pc, e_ld_ac, e_ld_pc, e_wr, e_data_e);
            end
            
            @(negedge clk);
        end
    endtask

    initial begin
        $display("=========================================================");
        $display("BAT DAU MO PHONG CONTROLLER (AUTO CHECKING & PRINTING)");
        $display("=========================================================");

        opcode  = 3'b010; 
        is_zero = 0;
        rst = 1;      
        
        @(negedge clk); 
        @(negedge clk); 
        rst = 0;      
       
        $display("\n--- TC1: Lenh ADD (010) - Kiem tra du 8 trang thai ---");
        check_and_tick("0:INST_ADDR ", 1,0,0,0,0,0,0,0,0);
        check_and_tick("1:INST_FETCH", 1,1,0,0,0,0,0,0,0);
        check_and_tick("2:INST_LOAD ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("3:IDLE      ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("4:OP_ADDR   ", 0,0,0,0,1,0,0,0,0); 
        check_and_tick("5:OP_FETCH  ", 0,1,0,0,0,0,0,0,0); 
        check_and_tick("6:ALU_OP    ", 0,1,0,0,0,0,0,0,0); 
        check_and_tick("7:STORE     ", 0,1,0,0,0,1,0,0,0); 

        $display("\n--- TC2: Lenh STO (110) - Ghi Memory ---");
        opcode = 3'b110; 
        check_and_tick("0:INST_ADDR ", 1,0,0,0,0,0,0,0,0);
        check_and_tick("1:INST_FETCH", 1,1,0,0,0,0,0,0,0);
        check_and_tick("2:INST_LOAD ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("3:IDLE      ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("4:OP_ADDR   ", 0,0,0,0,1,0,0,0,0); 
        check_and_tick("5:OP_FETCH  ", 0,0,0,0,0,0,0,0,0); 
        check_and_tick("6:ALU_OP    ", 0,0,0,0,0,0,0,0,1); 
        check_and_tick("7:STORE     ", 0,0,0,0,0,0,0,1,1); 

        $display("\n--- TC3: Lenh JMP (111) - Nhay vo dieu kien ---");
        opcode = 3'b111; 
        check_and_tick("0:INST_ADDR ", 1,0,0,0,0,0,0,0,0);
        check_and_tick("1:INST_FETCH", 1,1,0,0,0,0,0,0,0);
        check_and_tick("2:INST_LOAD ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("3:IDLE      ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("4:OP_ADDR   ", 0,0,0,0,1,0,0,0,0); 
        check_and_tick("5:OP_FETCH  ", 0,0,0,0,0,0,0,0,0); 
        check_and_tick("6:ALU_OP    ", 0,0,0,0,0,0,1,0,0); 
        check_and_tick("7:STORE     ", 0,0,0,0,0,0,1,0,0); 

        $display("\n--- TC4: Lenh SKZ (001) voi is_zero = 1 ---");
        opcode = 3'b001; 
        is_zero = 1; 
        check_and_tick("0:INST_ADDR ", 1,0,0,0,0,0,0,0,0);
        check_and_tick("1:INST_FETCH", 1,1,0,0,0,0,0,0,0);
        check_and_tick("2:INST_LOAD ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("3:IDLE      ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("4:OP_ADDR   ", 0,0,0,0,1,0,0,0,0); 
        check_and_tick("5:OP_FETCH  ", 0,0,0,0,0,0,0,0,0); 
        check_and_tick("6:ALU_OP    ", 0,0,0,0,1,0,0,0,0); 
        check_and_tick("7:STORE     ", 0,0,0,0,0,0,0,0,0);

        $display("\n--- TC5: Lenh HLT (000) - Kiem tra dong bang FSM ---");
        opcode = 3'b000; 
        is_zero = 0;
        check_and_tick("0:INST_ADDR ", 1,0,0,0,0,0,0,0,0);
        check_and_tick("1:INST_FETCH", 1,1,0,0,0,0,0,0,0);
        check_and_tick("2:INST_LOAD ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("3:IDLE      ", 1,1,1,0,0,0,0,0,0);
        check_and_tick("4:OP_ADDR   ", 0,0,0,1,0,0,0,0,0); 
        
        $display("   (Kiem tra FSM bi mac ket tai OP_ADDR du clock van chay)");
        check_and_tick("4:OP_ADDR(F)", 0,0,0,1,0,0,0,0,0); 
        check_and_tick("4:OP_ADDR(F)", 0,0,0,1,0,0,0,0,0); 

        $display("=========================================================");
        $display("KET THUC MO PHONG");
        $display("=========================================================");
        $finish; 
    end

endmodule