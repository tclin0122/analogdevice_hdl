module dma_tdd_sync (
  input                   clk,
  input                   rstn,
  input                   sync_in,
  output  reg             sync_out
);

  parameter PULSE_WIDTH = 100000;  // Duration of sync_out pulse in clock cycles

  reg [31:0] counter;  // Counter for pulse width
  reg sync_in_d;       // Delayed version of sync_in to detect rising edge

  // output logic
  assign sync_external = sync_in;
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
