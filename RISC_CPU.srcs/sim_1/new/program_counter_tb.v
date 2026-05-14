`timescale 1ns / 1ps
`include "define.v"

// ============================================================
// PC_tb.v - Testbench for Program Counter (PC)
// Covers 9 scenarios including edge cases and normal operations
// ============================================================
module PC_tb;

    // ── Signals ─────────────────────────────────────────
    reg                    clk;
    reg                    reset;
    reg                    ld_pc;
    reg                    inc_pc;
    reg  [`DATA_WIDTH-1:0] pc_in;
    wire [`DATA_WIDTH-1:0] pc_out;

    // ── DUT instantiation ────────────────────────────────
    program_counter uut (
        .clk     (clk),
        .reset   (reset),
        .inc_pc  (inc_pc),
        .ld_pc   (ld_pc),
        .pc_in   (pc_in),
        .pc_out  (pc_out)
    );

    // ── Clock: 10 ns period ──────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── Task: tick one clock and display state ───────────
    task tick;
        input [63:0] cycle;
        begin
            @(posedge clk); #1;
            $display("cycle=%0d | reset=%b | ld_pc=%b | inc_pc=%b | pc_in=%0d | pc_out=%0d",
                      cycle, reset, ld_pc, inc_pc, pc_in, pc_out);
        end
    endtask

    initial begin
        // Init
        reset = 1; ld_pc = 0; inc_pc = 0; pc_in = 0;
        // ── TC1: Reset ───────────────────────────────────
        $display("--- TC1: Reset ---");
        tick(1);   // rst=1 -> pc_out should be 0
        reset = 0;
        // ── TC2: Increment ───────────────────────────────
        $display("--- TC2: Increment ---");
        inc_pc = 1;
        tick(2);   // pc_out = 1
        tick(3);   // pc_out = 2
        tick(4);   // pc_out = 3
        inc_pc = 0;
        // ── TC3: Load ────────────────────────────────────
        $display("--- TC3: Load ---");
        pc_in = 32'd20;
        ld_pc   = 1;
        tick(5);   // pc_out = 20
        ld_pc   = 0;
        tick(6);   // pc_out = 20 (hold, no inc)

        // ── TC4: Priority rst > ld_pc > inc_pc ───────────
        $display("--- TC4: Priority ---");
        pc_in = 32'd99;
        reset = 1; ld_pc = 1; inc_pc = 1;
        tick(7);   // rst dominates -> pc_out = 0
        reset = 0;
        tick(8);   // ld_pc dominates over inc_pc -> pc_out = 99
        ld_pc = 0;
        tick(9);   // inc_pc -> pc_out = 100
        inc_pc = 0;

        // -- TC5: Hold/Idle State -- 
        $display("--- TC5: Hold State ---");
        reset = 0; ld_pc = 0; inc_pc = 0;
        tick(10);  // pc_out stays 100
        tick(11);  // pc_out stays 100

        // -- TC6: Wrap-around (Max value limit) -- 
        $display("--- TC6: Wrap-around ---");
        pc_in = {`DATA_WIDTH{1'b1}}; // Tự động fill toàn bit 1 tùy theo DATA_WIDTH
        ld_pc = 1;
        tick(12);  // pc_out = Max value
        ld_pc = 0; inc_pc = 1;
        tick(13);  // pc_out wraps to 0
        inc_pc = 0;
        // -- TC7: Jump & Increment Sequence --
        $display("--- TC7: Jump & Increment ---");
        pc_in = 32'd1000;
        ld_pc = 1;
        tick(14);  // pc_out = 1000
        ld_pc = 0; inc_pc = 1;
        tick(15);  // pc_out = 1001
        tick(16);  // pc_out = 1002
        inc_pc = 0;

        // -- TC8: Reset from Non-Zero Value --
        $display("--- TC8: Reset from High Value ---");
        pc_in = 32'hABCDE000;
        ld_pc = 1;
        tick(17);  // pc_out = 2882396160 (nếu DATA_WIDTH >= 32)
        ld_pc = 0;
        reset = 1;   // Reset
        tick(18);  // pc_out must be 0
        reset = 0;

        // -- TC9: Data Noise Immunity --
        $display("--- TC9: Data Noise Immunity ---");
        inc_pc = 1;
        tick(19);  // pc_out = 1
        pc_in = 32'hFFFFFFFF; 
        tick(20);  // pc_out = 2 (pc_in thay đổi không ảnh hưởng vì ld_pc = 0)
        inc_pc = 0;

        $display("--- DONE ---");
        $finish;
    end

endmodule