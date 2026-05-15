//==============================================================================
// cpu_tb.v - Comprehensive RISC CPU Testbench (Extended)
//
// Kiến trúc CPU 8 trạng thái (mỗi lệnh tốn 8 chu kỳ xung):
//   INST_ADDR(0) → INST_FETCH(1) → INST_LOAD(2) → IDLE(3)
//   → OP_ADDR(4) → OP_FETCH(5) → ALU_OP(6) → STORE(7) → ...
//
// Tập lệnh (opcode 3-bit, [7:5] trong byte lệnh):
//   000=HLT  001=SKZ  010=ADD  011=AND
//   100=XOR  101=LDA  110=STO  111=JMP
//==============================================================================
`timescale 1ns / 1ps
`include "define.v"

module cpu_tb;

    // =========================================================================
    // 1. DUT & Clock
    // =========================================================================
    reg clk, rst;
    wire out_halt;

    RISC_CPU dut (
        .clk(clk),
        .rst(rst),
        .out_halt(out_halt)
    );

    // Clock 10 ns (100 MHz)
    initial clk = 0;
    always  #5 clk = ~clk;

    // =========================================================================
    // 2. Waveform dump
    // =========================================================================
    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);
    end

    // =========================================================================
    // 3. Helper macros & counters
    // =========================================================================
    integer pass_cnt, fail_cnt, test_num;

    task check;
        input [127:0] label;
        input [`DATA_WIDTH-1:0] actual;
        input [`DATA_WIDTH-1:0] expected;
        begin
            if (actual === expected) begin
                $display("  [PASS] %-28s actual=%02h  expected=%02h", label, actual, expected);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("  [FAIL] %-28s actual=%02h  expected=%02h  <- WRONG", label, actual, expected);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    // =========================================================================
    // 4. Memory & CPU helper tasks
    // =========================================================================
    task clear_mem;
        integer i;
        begin
            for (i = 0; i < `ADDR_SPACE; i = i + 1)
                dut.u_memory.ram[i] = 8'h00;
        end
    endtask

    task cpu_reset;
        begin
            rst = 1;
            clear_mem;
            repeat(4) @(posedge clk);
            #1 rst = 0;
            @(posedge clk);
        end
    endtask

    task wait_halt;
        input integer max_cycles;
        integer i;
        reg timed_out;
        begin
            timed_out = 1;
            for (i = 0; i < max_cycles; i = i + 1) begin
                @(posedge clk); #1;
                if (out_halt === 1'b1) begin
                    timed_out = 0;
                    i = max_cycles;
                end
            end
            if (timed_out) begin
                $display("  [WARN] CPU did not HALT within %0d cycles", max_cycles);
                fail_cnt = fail_cnt + 1;
            end else begin
                repeat(2) @(posedge clk);
            end
        end
    endtask

    task print_header;
        input [511:0] title;
        begin
            test_num = test_num + 1;
            $display("\n===========================================================");
            $display("|  TEST %02d: %s", test_num, title);
            $display("===========================================================");
            $display("  [SIM TIME: %0t ns]", $time); // <-- dễ theo dõi tiến trình
        end
    endtask

    // =========================================================================
    // 5. Testbench body
    // =========================================================================
    initial begin
        pass_cnt = 0;
        fail_cnt = 0;
        test_num = 0;
        rst      = 1;
        clk      = 0;

        // ==================================================================
        // TEST 1: LDA + ADD + STO + HLT  (baseline)
        // ==================================================================
        print_header("LDA / ADD / STO / HLT (baseline)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h05;
        dut.u_memory.ram[21] = 8'h03;

        $display("  LDA [20]=05, ADD [21]=03, STO [22], HLT");
        $display("  Expect: ACC=08h  mem[22]=08h");
        wait_halt(100);

        check("ACC after ADD",   dut.u_acc.acc_out,    8'h08);
        check("mem[22] (STO)",   dut.u_memory.ram[22], 8'h08);
        check("mem[20] intact",  dut.u_memory.ram[20], 8'h05);

        // ==================================================================
        // TEST 2: AND + XOR
        // ==================================================================
        print_header("AND / XOR");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`AND, 5'd21};
        dut.u_memory.ram[2]  = {`XOR, 5'd22};
        dut.u_memory.ram[3]  = {`STO, 5'd23};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hFF;
        dut.u_memory.ram[21] = 8'h0F;
        dut.u_memory.ram[22] = 8'hAA;

        // FF AND 0F = 0F,  0F XOR AA = A5
        $display("  LDA FF, AND 0F -> 0F, XOR AA -> A5, STO, HLT");
        $display("  Expect: ACC=A5h  mem[23]=A5h");
        wait_halt(120);

        check("ACC after XOR",   dut.u_acc.acc_out,    8'hA5);
        check("mem[23] (STO)",   dut.u_memory.ram[23], 8'hA5);

        // ==================================================================
        // TEST 3: SKZ - bỏ qua khi ACC = 0
        // ==================================================================
        print_header("SKZ - skip when ACC=0");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`SKZ, 5'd0};
        dut.u_memory.ram[2]  = {`ADD, 5'd21};
        dut.u_memory.ram[3]  = {`STO, 5'd22};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h00;
        dut.u_memory.ram[21] = 8'h55;

        $display("  LDA 00, SKZ -> skip ADD 55, STO, HLT");
        $display("  Expect: ACC=00h  mem[22]=00h");
        wait_halt(120);

        check("ACC (skip active)",  dut.u_acc.acc_out,    8'h00);
        check("mem[22] skipped",    dut.u_memory.ram[22], 8'h00);
        $display("  [DONE] TEST 03 complete at t=%0t", $time);

        // ==================================================================
        // TEST 4: SKZ - KHÔNG bỏ qua khi ACC ≠ 0
        // ==================================================================
        print_header("SKZ - no skip when ACC≠0");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`SKZ, 5'd0};
        dut.u_memory.ram[2]  = {`ADD, 5'd21};
        dut.u_memory.ram[3]  = {`STO, 5'd22};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h07;
        dut.u_memory.ram[21] = 8'h01;

        $display("  LDA 07, SKZ (no-skip), ADD 01, STO, HLT");
        $display("  Expect: ACC=08h  mem[22]=08h");
        wait_halt(120);

        check("ACC (no skip)",  dut.u_acc.acc_out,    8'h08);
        check("mem[22]",        dut.u_memory.ram[22], 8'h08);

        // ==================================================================
        // TEST 5: JMP - nhảy đến địa chỉ chỉ định
        // ==================================================================
        print_header("JMP - unconditional jump");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`JMP, 5'd4};
        dut.u_memory.ram[2]  = {`ADD, 5'd21};   // bị nhảy qua
        dut.u_memory.ram[3]  = {`ADD, 5'd21};   // bị nhảy qua
        dut.u_memory.ram[4]  = {`STO, 5'd22};
        dut.u_memory.ram[5]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h01;
        dut.u_memory.ram[21] = 8'hFF;

        $display("  LDA 01, JMP 4 (skip 2×ADD FF), STO, HLT");
        $display("  Expect: ACC=01h  mem[22]=01h");
        wait_halt(120);

        check("ACC after JMP",  dut.u_acc.acc_out,    8'h01);
        check("mem[22] (JMP)",  dut.u_memory.ram[22], 8'h01);

        // ==================================================================
        // TEST 6: ADD Overflow - kết quả tràn 8-bit (wrap-around)
        // ==================================================================
        print_header("ADD overflow (8-bit wrap-around)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hFF;   // 255
        dut.u_memory.ram[21] = 8'h01;   // 1

        // 255 + 1 = 256 → truncate 8-bit → 0x00
        $display("  LDA FF, ADD 01 -> overflow 00h, STO, HLT");
        $display("  Expect: ACC=00h  mem[22]=00h");
        wait_halt(100);
        check("mem[22] ovf",    dut.u_memory.ram[22], 8'h00);

        // ==================================================================
        // TEST 7: ADD lớn - không tràn (max hợp lệ: 7F + 7F = FE)
        // ==================================================================
        print_header("ADD large values (no overflow)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h7F;
        dut.u_memory.ram[21] = 8'h7F;

        $display("  LDA 7F, ADD 7F -> FEh, STO, HLT");
        $display("  Expect: ACC=FEh  mem[22]=FEh");
        wait_halt(100);

        check("ACC 7F+7F",   dut.u_acc.acc_out,    8'hFE);
        check("mem[22]",     dut.u_memory.ram[22], 8'hFE);

        // ==================================================================
        // TEST 8: XOR self → ACC = 0  (tự XOR)
        // ==================================================================
        print_header("XOR self → ACC=0 (zero detection)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`STO, 5'd21};   // mem[21] = A3
        dut.u_memory.ram[2]  = {`XOR, 5'd21};   // A3 XOR A3 = 00
        dut.u_memory.ram[3]  = {`STO, 5'd22};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hA3;

        $display("  LDA A3, STO 21, XOR 21 (self) -> 00h, STO 22, HLT");
        $display("  Expect: ACC=00h  mem[22]=00h");
        wait_halt(120);

        check("XOR self → 0",  dut.u_acc.acc_out,    8'h00);
        check("mem[22]=0",     dut.u_memory.ram[22], 8'h00);

        // ==================================================================
        // TEST 9: AND với 0x00 → ACC = 0  (AND mask = 0)
        // ==================================================================
        print_header("AND mask=00 → ACC=0");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`AND, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hFF;
        dut.u_memory.ram[21] = 8'h00;

        $display("  LDA FF, AND 00 -> 00h, STO, HLT");
        $display("  Expect: ACC=00h  mem[22]=00h");
        wait_halt(100);

        check("AND with 0",  dut.u_acc.acc_out,    8'h00);
        check("mem[22]=0",   dut.u_memory.ram[22], 8'h00);

        // ==================================================================
        // TEST 10: AND với 0xFF → ACC không đổi  (AND mask = FF)
        // ==================================================================
        print_header("AND mask=FF → ACC unchanged");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`AND, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hB7;
        dut.u_memory.ram[21] = 8'hFF;

        $display("  LDA B7, AND FF -> B7h (unchanged), STO, HLT");
        $display("  Expect: ACC=B7h  mem[22]=B7h");
        wait_halt(100);

        check("AND with FF",  dut.u_acc.acc_out,    8'hB7);
        check("mem[22]=B7",   dut.u_memory.ram[22], 8'hB7);

        // ==================================================================
        // TEST 11: XOR với 0xFF → bitwise NOT
        // ==================================================================
        print_header("XOR 0xFF → bitwise NOT");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`XOR, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h3C;   // 0011_1100
        dut.u_memory.ram[21] = 8'hFF;

        // 3C XOR FF = C3
        $display("  LDA 3C, XOR FF -> C3h (bitwise NOT), STO, HLT");
        $display("  Expect: ACC=C3h  mem[22]=C3h");
        wait_halt(100);

        check("XOR FF = NOT",  dut.u_acc.acc_out,    8'hC3);
        check("mem[22]=C3",    dut.u_memory.ram[22], 8'hC3);

        // ==================================================================
        // TEST 12: LDA → STO (data transfer, không ALU)
        // ==================================================================
        print_header("LDA / STO - pure data transfer");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`STO, 5'd21};
        dut.u_memory.ram[2]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hDE;

        $display("  LDA DE, STO 21, HLT");
        $display("  Expect: ACC=DEh  mem[21]=DEh");
        wait_halt(80);

        check("ACC = DE",    dut.u_acc.acc_out,    8'hDE);
        check("mem[21]=DE",  dut.u_memory.ram[21], 8'hDE);

        // ==================================================================
        // TEST 13: Chuỗi ADD nhiều lần (accumulation)
        // ==================================================================
        print_header("Multi-ADD accumulation");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};
        dut.u_memory.ram[2]  = {`ADD, 5'd21};
        dut.u_memory.ram[3]  = {`ADD, 5'd21};
        dut.u_memory.ram[4]  = {`STO, 5'd22};
        dut.u_memory.ram[5]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h02;   // base = 2
        dut.u_memory.ram[21] = 8'h05;   // delta = 5

        // 2 + 5 + 5 + 5 = 17 = 0x11
        $display("  LDA 02, ADD 05, ADD 05, ADD 05, STO, HLT");
        $display("  Expect: ACC=11h  mem[22]=11h");
        wait_halt(160);

        check("ACC accum",   dut.u_acc.acc_out,    8'h11);
        check("mem[22]=11",  dut.u_memory.ram[22], 8'h11);

        // ==================================================================
        // TEST 14: ADD overflow chain (cascaded carries)
        // ==================================================================
        print_header("ADD overflow chain (cascaded)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};   // FE + FE = 1FC -> 0xFC
        dut.u_memory.ram[2]  = {`ADD, 5'd21};   // FC + FE = 1FA -> 0xFA
        dut.u_memory.ram[3]  = {`STO, 5'd22};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hFE;
        dut.u_memory.ram[21] = 8'hFE;

        // FE + FE = 0xFC (carry out discarded), FC + FE = 0xFA
        $display("  LDA FE, ADD FE -> FC (ovf), ADD FE -> FA, STO, HLT");
        $display("  Expect: ACC=FAh  mem[22]=FAh");
        wait_halt(120);
        check("mem[22]=FA",     dut.u_memory.ram[22], 8'hFA);

        // ==================================================================
        // TEST 15: SKZ → JMP (conditional branch pattern)
        //          Nếu ACC = 0 → bỏ qua JMP → dừng tại HLT sớm
        //          Nếu ACC ≠ 0 → thực thi JMP → nhảy đến STO+HLT khác
        // ==================================================================
        print_header("SKZ + JMP - conditional branch (ACC=0 path)");
        cpu_reset;

        // addr: 0=LDA  1=SKZ  2=JMP(target=5)  3=STO(23)  4=HLT
        //       5=STO(24)    6=HLT
        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`SKZ, 5'd0};    // ACC=0 → skip JMP
        dut.u_memory.ram[2]  = {`JMP, 5'd5};    // (bị skip khi ACC=0)
        dut.u_memory.ram[3]  = {`STO, 5'd23};   // zero-path: STO mem[23]
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[5]  = {`STO, 5'd24};   // non-zero-path: STO mem[24]
        dut.u_memory.ram[6]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h00;            // ACC = 0 → zero-path

        $display("  ACC=00 → SKZ skip JMP → STO mem[23], HLT");
        $display("  Expect: mem[23]=00h  mem[24]=00h(uninit)");
        wait_halt(150);

        check("mem[23]=00",    dut.u_memory.ram[23], 8'h00);
        check("mem[24]=00",    dut.u_memory.ram[24], 8'h00);

        print_header("SKZ + JMP - conditional branch (ACC≠0 path)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`SKZ, 5'd0};    // ACC≠0 → NO skip
        dut.u_memory.ram[2]  = {`JMP, 5'd5};    // nhảy đến addr 5
        dut.u_memory.ram[3]  = {`STO, 5'd23};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[5]  = {`STO, 5'd24};   // non-zero-path
        dut.u_memory.ram[6]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hAB;            // ACC ≠ 0 → non-zero-path

        $display("  ACC=AB → SKZ no-skip → JMP 5 → STO mem[24], HLT");
        $display("  Expect: mem[24]=ABh  mem[23]=00h(uninit)");
        wait_halt(150);

        check("mem[24]=AB",    dut.u_memory.ram[24], 8'hAB);
        check("mem[23]=00",    dut.u_memory.ram[23], 8'h00);

        // ==================================================================
        // TEST 16: Đếm ngược đơn giản bằng XOR + SKZ + JMP (software loop)
        //   Ý tưởng: nạp giá trị, XOR với chính nó, kết quả 0 → SKZ kích
        //   hoạt → vượt qua JMP → thoát vòng lặp
        //   (Vì CPU không có lệnh DEC/SUB, ta dùng pattern XOR-self-detect)
        // ------------------------------------------------------------------
        //   addr 0: LDA 20     ; ACC = val
        //   addr 1: STO 21     ; mem[21] = val
        //   addr 2: XOR 21     ; ACC XOR ACC = 0 (vòng 1 luôn ra 0)
        //   addr 3: SKZ        ; ACC=0 → skip JMP → thoát
        //   addr 4: JMP 2      ; (không bao giờ chạy với XOR-self)
        //   addr 5: STO 22     ; lưu kết quả (= 0)
        //   addr 6: HLT
        // ==================================================================
        print_header("XOR-self zero-detect loop exit");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`STO, 5'd21};
        dut.u_memory.ram[2]  = {`XOR, 5'd21};
        dut.u_memory.ram[3]  = {`SKZ, 5'd0};
        dut.u_memory.ram[4]  = {`JMP, 5'd2};
        dut.u_memory.ram[5]  = {`STO, 5'd22};
        dut.u_memory.ram[6]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h77;

        $display("  XOR-self detect zero, skip JMP, STO result=0");
        $display("  Expect: ACC=00h  mem[22]=00h");
        wait_halt(200);

        check("ACC = 0 (loop exit)", dut.u_acc.acc_out,    8'h00);
        check("mem[22]=0",           dut.u_memory.ram[22], 8'h00);

        // ==================================================================
        // TEST 17: JMP chaining (nhiều JMP liên tiếp)
        // ==================================================================
        print_header("JMP chaining (multiple jumps)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`JMP, 5'd5};    // jump → addr 5
        dut.u_memory.ram[2]  = {`ADD, 5'd21};   // DEAD CODE
        dut.u_memory.ram[3]  = {`ADD, 5'd21};   // DEAD CODE
        dut.u_memory.ram[4]  = {`ADD, 5'd21};   // DEAD CODE
        dut.u_memory.ram[5]  = {`JMP, 5'd8};    // jump → addr 8
        dut.u_memory.ram[6]  = {`ADD, 5'd21};   // DEAD CODE
        dut.u_memory.ram[7]  = {`ADD, 5'd21};   // DEAD CODE
        dut.u_memory.ram[8]  = {`STO, 5'd22};
        dut.u_memory.ram[9]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hCA;
        dut.u_memory.ram[21] = 8'hFF;

        $display("  LDA CA, JMP 5 -> JMP 8 -> STO, HLT (skip all ADDs)");
        $display("  Expect: ACC=CAh  mem[22]=CAh");
        wait_halt(150);

        check("ACC after chain JMP",  dut.u_acc.acc_out,    8'hCA);
        check("mem[22]=CA",           dut.u_memory.ram[22], 8'hCA);

        // ==================================================================
        // TEST 18: STO nhiều địa chỉ (multi-STO fan-out)
        // ==================================================================
        print_header("Multi-STO fan-out");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`STO, 5'd21};
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`STO, 5'd23};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h5A;

        $display("  LDA 5A, STO 21, STO 22, STO 23, HLT");
        $display("  Expect: mem[21]=mem[22]=mem[23]=5Ah");
        wait_halt(120);

        check("mem[21]=5A",  dut.u_memory.ram[21], 8'h5A);
        check("mem[22]=5A",  dut.u_memory.ram[22], 8'h5A);
        check("mem[23]=5A",  dut.u_memory.ram[23], 8'h5A);

        // ==================================================================
        // TEST 19: Ghi đè bộ nhớ (STO rồi LDA lại)
        // ==================================================================
        print_header("Write-then-read (mem overwrite)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};   // ACC = 11
        dut.u_memory.ram[1]  = {`STO, 5'd21};   // mem[21] = 11
        dut.u_memory.ram[2]  = {`LDA, 5'd22};   // ACC = 99
        dut.u_memory.ram[3]  = {`STO, 5'd21};   // mem[21] = 99 (overwrite)
        dut.u_memory.ram[4]  = {`LDA, 5'd21};   // ACC = 99 (read back)
        dut.u_memory.ram[5]  = {`STO, 5'd23};
        dut.u_memory.ram[6]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h11;
        dut.u_memory.ram[22] = 8'h99;

        $display("  STO 11->21, STO 99->21(overwrite), LDA 21, STO 23, HLT");
        $display("  Expect: ACC=99h  mem[23]=99h");
        wait_halt(160);

        check("ACC = 99",    dut.u_acc.acc_out,    8'h99);
        check("mem[23]=99",  dut.u_memory.ram[23], 8'h99);
        check("mem[21]=99",  dut.u_memory.ram[21], 8'h99);

        // ==================================================================
        // TEST 20: AND + XOR pipeline phức tạp
        //   Bitmask extraction: lấy nibble cao rồi XOR flip
        // ==================================================================
        print_header("AND high-nibble + XOR flip");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};   // ACC = 0xF5
        dut.u_memory.ram[1]  = {`AND, 5'd21};   // AND F0 -> F0
        dut.u_memory.ram[2]  = {`XOR, 5'd22};   // XOR 55 -> A5
        dut.u_memory.ram[3]  = {`STO, 5'd23};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hF5;
        dut.u_memory.ram[21] = 8'hF0;   // high-nibble mask
        dut.u_memory.ram[22] = 8'h55;

        // F5 AND F0 = F0,  F0 XOR 55 = A5
        $display("  LDA F5, AND F0 -> F0, XOR 55 -> A5, STO, HLT");
        $display("  Expect: ACC=A5h  mem[23]=A5h");
        wait_halt(120);

        check("ACC = A5",    dut.u_acc.acc_out,    8'hA5);
        check("mem[23]=A5",  dut.u_memory.ram[23], 8'hA5);

        // ==================================================================
        // TEST 21: Boundary - LDA địa chỉ cao nhất hợp lệ
        // ==================================================================
        print_header("LDA from high memory address");
        cpu_reset;

        dut.u_memory.ram[0]   = {`LDA, 5'd31};  // addr 31 (5-bit max)
        dut.u_memory.ram[1]   = {`STO, 5'd30};
        dut.u_memory.ram[2]   = {`HLT, 5'd0};
        dut.u_memory.ram[31]  = 8'hBE;

        $display("  LDA from addr 31 (5-bit max), STO 30, HLT");
        $display("  Expect: ACC=BEh  mem[30]=BEh");
        wait_halt(80);

        check("ACC = BE",    dut.u_acc.acc_out,    8'hBE);
        check("mem[30]=BE",  dut.u_memory.ram[30], 8'hBE);

        // ==================================================================
        // TEST 22: ADD với giá trị 0 (identity element)
        // ==================================================================
        print_header("ADD identity (add zero)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`ADD, 5'd21};   // +0
        dut.u_memory.ram[2]  = {`STO, 5'd22};
        dut.u_memory.ram[3]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'h42;
        dut.u_memory.ram[21] = 8'h00;

        $display("  LDA 42, ADD 00 -> 42 (unchanged), STO, HLT");
        $display("  Expect: ACC=42h  mem[22]=42h");
        wait_halt(100);

        check("ACC = 42",    dut.u_acc.acc_out,    8'h42);
        check("mem[22]=42",  dut.u_memory.ram[22], 8'h42);

        // ==================================================================
        // TEST 23: Immediate reset - cpu_reset ổn định (test harness)
        // ==================================================================
        print_header("Immediate double-reset stability");
        cpu_reset;
        cpu_reset;   // reset hai lần liên tiếp

        dut.u_memory.ram[0]  = {`LDA, 5'd20};
        dut.u_memory.ram[1]  = {`STO, 5'd21};
        dut.u_memory.ram[2]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hAA;

        $display("  Double-reset then LDA AA, STO 21, HLT");
        $display("  Expect: ACC=AAh  mem[21]=AAh");
        wait_halt(80);

        check("ACC = AA",    dut.u_acc.acc_out,    8'hAA);
        check("mem[21]=AA",  dut.u_memory.ram[21], 8'hAA);

        // ==================================================================
        // TEST 24: AND + AND (chained masking, lower nibble extract)
        // ==================================================================
        print_header("Chained AND masking");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};   // 0xAB
        dut.u_memory.ram[1]  = {`AND, 5'd21};   // AND 0xF0 -> 0xA0
        dut.u_memory.ram[2]  = {`AND, 5'd22};   // AND 0x0F -> 0x00
        dut.u_memory.ram[3]  = {`STO, 5'd23};
        dut.u_memory.ram[4]  = {`HLT, 5'd0};
        dut.u_memory.ram[20] = 8'hAB;
        dut.u_memory.ram[21] = 8'hF0;
        dut.u_memory.ram[22] = 8'h0F;

        // AB AND F0 = A0,  A0 AND 0F = 00
        $display("  LDA AB, AND F0 -> A0, AND 0F -> 00, STO, HLT");
        $display("  Expect: ACC=00h  mem[23]=00h");
        wait_halt(120);

        check("AND chain = 0",  dut.u_acc.acc_out,    8'h00);
        check("mem[23]=0",      dut.u_memory.ram[23], 8'h00);

        // ==================================================================
        // TEST 25: Toàn bộ lệnh ALU chuỗi dài (integration)
        //   LDA → ADD → AND → XOR → STO → LDA kết quả → ADD → STO → HLT
        // ==================================================================
        print_header("Full ALU pipeline integration");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};   // ACC = 0x36
        dut.u_memory.ram[1]  = {`ADD, 5'd21};   // + 0x12 = 0x48
        dut.u_memory.ram[2]  = {`AND, 5'd22};   // AND 0xF0 = 0x40
        dut.u_memory.ram[3]  = {`XOR, 5'd23};   // XOR 0x0F = 0x4F
        dut.u_memory.ram[4]  = {`STO, 5'd24};   // mem[24] = 0x4F
        dut.u_memory.ram[5]  = {`LDA, 5'd24};   // ACC = 0x4F
        dut.u_memory.ram[6]  = {`ADD, 5'd25};   // + 0x01 = 0x50
        dut.u_memory.ram[7]  = {`STO, 5'd26};   // mem[26] = 0x50
        dut.u_memory.ram[8]  = {`HLT, 5'd0};

        dut.u_memory.ram[20] = 8'h36;
        dut.u_memory.ram[21] = 8'h12;
        dut.u_memory.ram[22] = 8'hF0;
        dut.u_memory.ram[23] = 8'h0F;
        dut.u_memory.ram[25] = 8'h01;

        $display("  36+12=48, AND F0=40, XOR 0F=4F, STO 24");
        $display("  LDA 4F, ADD 01=50, STO 26, HLT");
        $display("  Expect: ACC=50h  mem[24]=4Fh  mem[26]=50h");
        wait_halt(250);

        check("mem[24]=4F",      dut.u_memory.ram[24], 8'h4F);
        check("ACC final=50",    dut.u_acc.acc_out,    8'h50);
        check("mem[26]=50",      dut.u_memory.ram[26], 8'h50);

        // ==================================================================
        // TEST 26: [CPU_tb] Simple integration - LDA/ADD/STO/HLT
        // ------------------------------------------------------------------
        // Nguồn gốc : CPU_tb (tìm trên mạng, module tên "CPU")
        // Nguồn gốc : CPU_tb (tìm trên mạng, module tên "CPU")
        // Thích nghi : đổi sang RISC_CPU + dut.u_memory.ram[] + define macros
        //
        // Verify encoding gốc (hex → opcode/operand):
        //   0xB4 = 1011_0100 → [7:5]=101(LDA) [4:0]=10100=20  ✓
        //   0x55 = 0101_0101 → [7:5]=010(ADD) [4:0]=10101=21  ✓
        //   0xD6 = 1101_0110 → [7:5]=110(STO) [4:0]=10110=22  ✓
        //   0x00 = 0000_0000 → [7:5]=000(HLT)                 ✓
        // ==================================================================
        print_header("[CPU_tb] LDA 5 / ADD 3 / STO / HLT (integration)");
        cpu_reset;

        dut.u_memory.ram[0]  = {`LDA, 5'd20};   // 8'hB4
        dut.u_memory.ram[1]  = {`ADD, 5'd21};   // 8'h55
        dut.u_memory.ram[2]  = {`STO, 5'd22};   // 8'hD6
        dut.u_memory.ram[3]  = {`HLT, 5'd0};    // 8'h00

        dut.u_memory.ram[20] = 8'd5;
        dut.u_memory.ram[21] = 8'd3;
        dut.u_memory.ram[22] = 8'd0;

        $display("  [CPU_tb] LDA mem[20]=5, ADD mem[21]=3, STO mem[22], HLT");
        $display("  Expect : ACC=08h  mem[22]=08h (decimal 8)");

        // Monitor per-cycle giống CPU_tb - Verilog thuần, không dùng join_none
        begin : mon26
            integer k;
            for (k = 0; k < 15; k = k + 1) begin
                @(posedge clk); #1;
                $display("  [MON] t=%4t PC=%02d state=%0d op=%03b ACC=%02h halt=%b",
                    $time,
                    dut.u_pc.pc_out,
                    dut.u_controller.state,
                    dut.opcode,
                    dut.u_acc.acc_out,
                    out_halt);
                if (out_halt === 1'b1) k = 15; // thoát sớm nếu đã halt
            end
        end

        wait_halt(100);

        $display("  --- FINAL RESULT CHECK (CPU_tb style) ---");
        $display("  Mem[22] (Expected 8): %0d", dut.u_memory.ram[22]);
        check("[CPU_tb] ACC=08",    dut.u_acc.acc_out,    8'h08);
        check("[CPU_tb] mem[22]=8", dut.u_memory.ram[22], 8'h08);

        // ==================================================================
        // TEST 27: [CPU2_tb] Full integration - ADD/SKZ/JMP/XOR/AND chain
        // ------------------------------------------------------------------
        // Nguồn gốc : CPU2_tb (tìm trên mạng, module tên "CPU")
        // Thích nghi : đổi sang RISC_CPU + dut.u_memory.ram[] + define macros
        //
        // Verify encoding gốc:
        //   0xB4=LDA 20, 0x55=ADD 21, 0xD6=STO 22, 0x20=SKZ
        //   0xE6=JMP  6, 0x55=ADD 21, 0x94=XOR 20, 0x75=AND 21
        //   0xD7=STO 23, 0xB8=LDA 24, 0x20=SKZ,    0xD9=STO 25
        //   0x00=HLT
        //
        // Luồng thực thi:
        //   AC=5 → +3=8 → STO 22 → SKZ(8≠0,no-skip) → JMP 6
        //   → [addr5 ADD bị nhảy qua] → XOR 5 (8^5=13) → AND 3 (13&3=1)
        //   → STO 23 → LDA 24(=0) → SKZ(0,skip) → [addr11 STO 25 bị skip]
        //   → HLT
        //
        // Tính tay:
        //   8 XOR 5 = 0b1000 ^ 0b0101 = 0b1101 = 13 = 0x0D
        //   13 AND 3 = 0b1101 & 0b0011 = 0b0001 = 1  = 0x01
        // ==================================================================
        print_header("[CPU2_tb] Full chain: ADD/SKZ/JMP/XOR/AND");
        cpu_reset;

        //  addr | hex   | macro equiv        | ghi chú
        // ------+-------+--------------------+-----------------------------
        dut.u_memory.ram[0]  = {`LDA, 5'd20};  // 0xB4 → AC = 5
        dut.u_memory.ram[1]  = {`ADD, 5'd21};  // 0x55 → AC = 8
        dut.u_memory.ram[2]  = {`STO, 5'd22};  // 0xD6 → mem[22] = 8
        dut.u_memory.ram[3]  = {`SKZ, 5'd0};   // 0x20 → AC=8≠0, NO skip
        dut.u_memory.ram[4]  = {`JMP, 5'd6};   // 0xE6 → nhảy tới addr 6
        dut.u_memory.ram[5]  = {`ADD, 5'd21};  // 0x55 → BỊ BỎ QUA (JMP)
        dut.u_memory.ram[6]  = {`XOR, 5'd20};  // 0x94 → 8 XOR 5 = 13
        dut.u_memory.ram[7]  = {`AND, 5'd21};  // 0x75 → 13 AND 3 = 1
        dut.u_memory.ram[8]  = {`STO, 5'd23};  // 0xD7 → mem[23] = 1
        dut.u_memory.ram[9]  = {`LDA, 5'd24};  // 0xB8 → AC = 0 (mem[24]=0)
        dut.u_memory.ram[10] = {`SKZ, 5'd0};   // 0x20 → AC=0, SKIP next
        dut.u_memory.ram[11] = {`STO, 5'd25};  // 0xD9 → BỊ BỎ QUA (SKZ)
        dut.u_memory.ram[12] = {`HLT, 5'd0};   // 0x00 → dừng

        dut.u_memory.ram[20] = 8'd5;
        dut.u_memory.ram[21] = 8'd3;
        dut.u_memory.ram[22] = 8'd0;
        dut.u_memory.ram[23] = 8'd0;
        dut.u_memory.ram[24] = 8'd0;   // LDA 24 → AC = 0

        $display("  Bước 1: LDA 5, ADD 3 -> AC=8, STO mem[22]");
        $display("  Bước 2: SKZ(8≠0,no-skip) -> JMP 6 -> skip ADD");
        $display("  Bước 3: XOR 5 -> 13, AND 3 -> 1, STO mem[23]");
        $display("  Bước 4: LDA 24(=0) -> SKZ(skip STO 25) -> HLT");
        $display("  Expect : mem[22]=08h, mem[23]=01h, mem[25]=00h(untouched)");

        wait_halt(350);

        $display("  --- FINAL RESULT CHECK (CPU2_tb style) ---");
        $display("  Mem[22] (Expected 8) : %0d", dut.u_memory.ram[22]);
        $display("  Mem[23] (Expected 1) : %0d", dut.u_memory.ram[23]);
        $display("  Mem[25] (Expected 0) : %0d", dut.u_memory.ram[25]);

        check("[CPU2_tb] mem[22]=8",       dut.u_memory.ram[22], 8'h08);
        check("[CPU2_tb] mem[23]=1",       dut.u_memory.ram[23], 8'h01);
        check("[CPU2_tb] mem[25]=0(skip)", dut.u_memory.ram[25], 8'h00);
        check("[CPU2_tb] ACC final=0",     dut.u_acc.acc_out,    8'h00);

        // ==================================================================
        // SUMMARY
        // ==================================================================
        $display("\n===========================================================");
        $display("|                      SUMMARY                             |");
        $display("-----------------------------------------------------------");
        $display("|  Total Tests : %2d                                        |", test_num);
        $display("|  Passed      : %3d                                        |", pass_cnt);
        $display("|  Failed      : %3d                                        |", fail_cnt);
        if (fail_cnt == 0)
            $display("|  Status      : ALL TESTS PASSED  [PASS]                  |");
        else
            $display("|  Status      : SOME TESTS FAILED [FAIL]                  |");
        $display("===========================================================\n");
        $finish;
    end

    // =========================================================================
    // 7. Global timeout - 500 µs đủ cho 27 test (ước tính ~54 µs thực tế)
    // =========================================================================
    initial begin
        #500000;
        $display("[GLOBAL TIMEOUT] Simulation exceeded 500 us - possible infinite loop");
        $finish;
    end

endmodule