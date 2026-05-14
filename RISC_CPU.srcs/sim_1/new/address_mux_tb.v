`timescale 1ns / 1ps
`include "define.v"

module address_mux_tb;
    reg sel;
    reg  [`ADDR_WIDTH-1:0] pc_addr;
    reg  [`ADDR_WIDTH-1:0] ir_addr;
    wire [`ADDR_WIDTH-1:0] mem_addr;

    // ── DUT ──────────────────────────────────────────────────────────
    address_mux dut (
        .sel(sel),
        .pc_addr(pc_addr),
        .ir_addr(ir_addr),
        .mem_addr(mem_addr)
    );

    // ── Task tự động kiểm tra ────────────────────────────────────────
    integer pass_count = 0;
    integer fail_count = 0;

    task check_output;
        input [`ADDR_WIDTH-1:0] expected;
        input [63:0]            test_num;
        begin
            #1; // Cho tín hiệu ổn định
            if (mem_addr === expected) begin
                $display("PASS [Test %0d] sel=%b | pc=%h | ir=%h => mem_addr=%h",
                          test_num, sel, pc_addr, ir_addr, mem_addr);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL [Test %0d] sel=%b | pc=%h | ir=%h => mem_addr=%h (expected %h)",
                          test_num, sel, pc_addr, ir_addr, mem_addr, expected);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── Waveform dump ─────────────────────────────────────────────────
    initial begin
        $dumpfile("address_mux_tb.vcd");
        $dumpvars(0, address_mux_tb);
    end

    // ── Stimulus ──────────────────────────────────────────────────────
    initial begin
        $display("=== Bat dau mo phong Address MUX ===");

        // Giá trị mặc định
        sel     = `SEL_IR;
        pc_addr = 32'h00000010;
        ir_addr = 32'h000000FF;
        #10;

        // Test 1: SEL_IR → phải ra ir_addr
        sel = `SEL_IR;
        check_output(ir_addr, 1);

        // Test 2: SEL_PC → phải ra pc_addr
        #10; sel = `SEL_PC;
        check_output(pc_addr, 2);

        // Test 3: PC thay đổi trong khi sel = SEL_PC
        #10; pc_addr = 32'h00000011;
        check_output(32'h00000011, 3);

        // Test 4: Quay lại SEL_IR
        #10; sel = `SEL_IR;
        check_output(ir_addr, 4);

        // Test 5: ir_addr thay đổi trong khi sel = SEL_IR
        #10; ir_addr = 32'hDEADBEEF;
        check_output(32'hDEADBEEF, 5);

        // Test 6: Edge case - địa chỉ 0
        #10;
        pc_addr = 32'h00000000;
        ir_addr = 32'h00000000;
        sel = `SEL_PC;
        check_output(32'h00000000, 6);

        // Test 7: Edge case - địa chỉ max
        #10;
        pc_addr = 32'hFFFFFFFF;
        ir_addr = 32'hFFFFFFFF;
        sel = `SEL_IR;
        check_output(32'hFFFFFFFF, 7);

        // Test 8: Tất cả bit xen kẽ
        #10;
        pc_addr = 32'hAAAAAAAA;
        ir_addr = 32'h55555555;
        sel = `SEL_PC;
        check_output(32'hAAAAAAAA, 8);
        #10; sel = `SEL_IR;
        check_output(32'h55555555, 9);

        // ── Tổng kết ──────────────────────────────────────────────────
        #10;
        $display("=== KET QUA: %0d PASS | %0d FAIL ===", pass_count, fail_count);
        if (fail_count == 0)
            $display(">>> PASS TOAN BO TEST CASES <<<");
        else
            $display(">>> CO %0d LOI CAN KIEM TRA LAI <<<", fail_count);
        $finish;
    end
endmodule