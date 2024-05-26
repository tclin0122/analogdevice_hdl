`timescale 1ns/1ps

module tdd_sync_buffer (
    input              clk,
    input              rstn,
    input              sync_in,
    input  [15:0]      data_in_I,data_in_Q,  // 16-bit input
    output [15:0]      data_out_I,data_out_Q, // 16-bit output
    output reg         sync_out
);

  parameter PULSE_WIDTH = 3;  // Duration of sync_out pulse in clock cycles

  reg [31:0] counter;  // Counter for pulse width
  reg sync_in_d;       // Delayed version of sync_in to detect rising edge
  //reg sync_out;

  assign data_out_I = sync_out ? data_in_I : 16'b0;
  assign data_out_Q = sync_out ? data_in_Q : 16'b0;

  always @(posedge clk) begin
        if (rstn) begin
            sync_out <= 0;
            counter <= 0;
            sync_in_d <= 0;
        end 
        else begin
            sync_in_d <= sync_in;
            if (sync_in && !sync_in_d) begin
                // sync_in rising edge detected
                sync_out <= 1;
                counter <= PULSE_WIDTH;
            end 
            else if (counter > 0) begin
                counter <= counter - 1;
                if (counter == 1) begin
                    sync_out <= 0;
                end
            end
        end
    end

endmodule
