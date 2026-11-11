// ============================================================================
// Jianyuan Lab EIC Microarchitecture v2.0.0
// Toy Testbench: AXI4 Monitor Interface & Contract Assertions Binding
// ============================================================================

`timescale 1ns/1ps

module toy_top_tb;

    // 1. Clock and Reset Generation
    logic clk;
    logic rst_n;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk; // 100MHz simulation clock
    end

    initial begin
        rst_n = 1'b0;
        #25 rst_n = 1'b1;
        #500 begin
            $display("[EIC-SIM-STATUS] Simulation completed cleanly across 500ns.");
            $finish;
        end
    end

    // 2. Local Signal Harness
    logic illegal_dump_probe;
    logic shadow_bus_divert_en;
    logic decoy_sandbox_active;
    logic egress_leak_detected;

    logic high_voltage_dv_dt_trip;
    logic dynamic_impedance_sink_active;
    logic cdc_flush_complete;
    logic link_reloaded_clean;

    // 3. Instantiate Concrete SVA Verification Contracts
    sandbox_decoy_barrier u_chk_decoy (
        .clk(clk),
        .rst_n(rst_n),
        .illegal_kernel_dump_probe(illegal_dump_probe),
        .shadow_bus_divert_en(shadow_bus_divert_en),
        .decoy_sandbox_active(decoy_sandbox_active),
        .egress_leak_detected(egress_leak_detected)
    );

    oob_fuse_reload #(
        .MAX_RELOAD_CYCLES(16)
    ) u_chk_oob (
        .clk(clk),
        .rst_n(rst_n),
        .high_voltage_dv_dt_trip(high_voltage_dv_dt_trip),
        .dynamic_impedance_sink_active(dynamic_impedance_sink_active),
        .cdc_flush_complete(cdc_flush_complete),
        .link_reloaded_clean(link_reloaded_clean)
    );

    // 4. Stimulus Sequence (Nominal Phase -> Fault Injection Phase)
    initial begin
        // Nominal Initial Conditions
        illegal_dump_probe            = 1'b0;
        shadow_bus_divert_en          = 1'b0;
        decoy_sandbox_active          = 1'b0;
        egress_leak_detected          = 1'b0;
        high_voltage_dv_dt_trip       = 1'b0;
        dynamic_impedance_sink_active = 1'b0;
        cdc_flush_complete            = 1'b0;
        link_reloaded_clean           = 1'b0;

        @(posedge rst_n);
        repeat(5) @(posedge clk);

        // Inject Fault: Bus Dump Probe Trigger (SIG-GATE-05 Stimulus)
        @(posedge clk);
        illegal_dump_probe <= 1'b1;

        // Bounded Hardware Isolation Response (Latency = 2 Cycles <= 4)
        repeat(2) @(posedge clk);
        shadow_bus_divert_en <= 1'b1;
        decoy_sandbox_active <= 1'b1;
        egress_leak_detected <= 1'b0;
        illegal_dump_probe   <= 1'b0;

        // Clear Isolation State
        repeat(3) @(posedge clk);
        shadow_bus_divert_en <= 1'b0;
        decoy_sandbox_active <= 1'b0;
    end

endmodule
