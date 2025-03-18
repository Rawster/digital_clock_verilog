module debounce_pulse (
    input wire clk,         // 50 MHz Clock
    input wire slow_clk,    // Slow clock (e.g., 100 Hz)
    input wire button,      // Input signal (button)
    output reg pulse_out    // Output - pulse of 1 clock cycle duration
);

    reg [3:0] shiftregister = 4'b0000; 
    reg debounced_signal = 0;    // Stable signal after debounce
    reg last_state = 0;          // Previous state of debounced_signal


    // Pulse generation section: operates on the fast clock (clk)
    always @(posedge clk)  if (slow_clk) shiftregister <= {shiftregister[2:0], button};

	 
	 always @(posedge clk) begin
		  if (shiftregister == 4'b1111) debounced_signal <= 1;    // If all bits are 1, signal is stable
		  else if (shiftregister == 4'b0000) debounced_signal <= 0; // If all bits are 0, signal is stable
		  last_state <= debounced_signal;                           // Store previous state of debounced signal
	  end
	  
	  always @(*) begin
			if (debounced_signal == 1 && last_state == 0) pulse_out <= 1;  // Generate pulse when signal transitions from 0 to 1
			else pulse_out <= 0;  // Otherwise, set pulse to 0
		  
	  end
       

endmodule
