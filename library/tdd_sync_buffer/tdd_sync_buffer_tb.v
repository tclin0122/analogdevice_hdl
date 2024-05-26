`timescale 1ns/1ps

module tb_tdd_sync_buffer;

    // Testbench signals
    reg clk;
    reg rstn;
    reg sync_in;
    reg [15:0] data_in_I, data_in_Q;  // 16-bit inputs
    wire sync_out;
    wire [15:0] data_out_I, data_out_Q; // 16-bit outputs

    // Instantiate the design under test (DUT)
    tdd_sync_buffer dut (
        .clk(clk),
        .rstn(rstn),
        .sync_in(sync_in),
        .data_in_I(data_in_I),
        .data_in_Q(data_in_Q),
        .data_out_I(data_out_I),
        .data_out_Q(data_out_Q),
        .sync_out(sync_out)
    );

    // Clock generation
    always #5 clk = ~clk; // 10 ns period

    initial begin
        // Initialize signals
        clk = 0;
        rstn = 0;
        sync_in = 0;
        data_in_I = 16'b0;
        data_in_Q = 16'b0;

        // Reset sequence
        #10;
        rstn = 1;
        #10;
        rstn = 0;
        #10;

        // Test case 1: Apply sync_in with in1 and in2
        data_in_I = 16'b1010101010101010;
        data_in_Q = 16'b0101010101010101;
        sync_in = 1;
        #10;
        sync_in = 0;
        #100; // Wait to observe pulse width effect

        // Test case 2: Apply another sync_in pulse
        data_in_I = 16'b1111000011110000;
        data_in_Q = 16'b0000111100001111;
        sync_in = 1;
        #10;
        sync_in = 0;
        #100; // Wait to observe pulse width effect

        // Test case 3: Apply sync_in pulse with all 1s
        data_in_I = 16'b1111111111111111;
        data_in_Q = 16'b1111111111111111;
        sync_in = 1;
        #10;
        sync_in = 0;
        #100; // Wait to observe pulse width effect

        // End simulation
        $stop;
    end

    initial begin
        // Monitor changes in the signals
        $monitor("Time: %0t | rstn: %b | sync_in: %b | sync_out: %b | data_in_I: %b | data_in_Q: %b | data_out_I: %b | data_out_Q: %b", $time, rstn, sync_in, sync_out, data_in_I, data_in_Q, data_out_I, data_out_Q);
    end

endmodule

