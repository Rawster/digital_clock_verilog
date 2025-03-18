module Prescaler (
    input wire clk,
     input wire start,
    output reg clock_1_60Hz,
    output reg clock_1000Hz
);
    reg [15:0] count_1_60Hz = 0;
    reg [15:0] count_1000Hz = 0;
    
    reg pulse_1_60Hz = 0;
    reg pulse_1000Hz = 0;

    localparam MAX_COUNT_1_60Hz = 60000 - 1;
    localparam MAX_COUNT_1000Hz = 50000 - 1;

    always @(posedge clk) begin
        
		  if(~start) count_1_60Hz <= 0;
		  
        if (count_1000Hz == MAX_COUNT_1000Hz) begin
            pulse_1000Hz <= 1;
            count_1000Hz <= 0;
			  if (count_1_60Hz == MAX_COUNT_1_60Hz) begin
					  pulse_1_60Hz <= 1;
					  count_1_60Hz <= 0;
				end
				else begin
					count_1_60Hz <= count_1_60Hz + 1;
			  end
            
        end 
        else begin
            pulse_1000Hz <= 0;
				count_1000Hz <= count_1000Hz + 1;
				pulse_1_60Hz <= 0;
			  end
		  
    end

    always @(*) begin
        clock_1_60Hz = pulse_1_60Hz;
        clock_1000Hz = pulse_1000Hz;
        
    end

endmodule