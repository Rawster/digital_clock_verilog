module clock_counter (
    input wire inc_min,
    input wire inc_hour,
    input wire inc_min_auto,
    input wire start,
    input wire clk,

    output reg [3:0] min_units = 0,
    output reg [3:0] min_tens = 0,
    output reg [3:0] hour_units = 0,
    output reg [3:0] hour_tens = 0
);

always @(posedge clk) begin
    if (start) begin
        if (inc_min_auto) begin
            if (min_units < 9) begin
                min_units <= min_units + 1;
            end else begin
                min_units <= 0;

                if (min_tens < 5) begin
                    min_tens <= min_tens + 1;
                end else begin
                    min_tens <= 0;

                    if (hour_units < 9) begin
                        hour_units <= hour_units + 1;
                    end else begin
                        hour_units <= 0;

                        if (hour_tens < 2) begin
                            hour_tens <= hour_tens + 1;
                        end else begin
                            hour_tens <= 0;
                        end
                    end
                end
            end
        end
    end else begin
        if (inc_hour) begin
            if (hour_units < 9) begin
                hour_units <= hour_units + 1;
            end else begin
                hour_units <= 0;

                if (hour_tens < 2) begin
                    hour_tens <= hour_tens + 1;
                end else begin
                    hour_tens <= 0;
                end
            end
        end

        if (inc_min) begin
            if (min_units < 9) begin
                min_units <= min_units + 1;
            end else begin
                min_units <= 0;

                if (min_tens < 5) begin
                    min_tens <= min_tens + 1;
                end else begin
                    min_tens <= 0;
                end
            end
        end
    end

    if (hour_units == 4 && hour_tens == 2) begin
        hour_units <= 0;
        hour_tens <= 0;
    end
end

endmodule
