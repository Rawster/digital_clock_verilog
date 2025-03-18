module main(
	clk,
	START,
	UM,
	UG,
	digit0,
	digit1,
	digit2,
	digit3
);

input wire	clk;
input wire	START;
input wire	UM;
input wire	UG;
output wire	[6:0] digit0;
output wire	[6:0] digit1;
output wire	[6:0] digit2;
output wire	[6:0] digit3;

wire	[3:0] hour_tens;
wire	[3:0] hour_units;
wire	[3:0] min_tens;
wire	[3:0] min_units;
wire	pulse_min_inc;
wire	pulse_hour_inc;
wire	auto_minute_clk;
wire	slow_clk;
wire	UM_debounced;
wire	UG_debounced;

assign	UG_debounced = ~UG;
assign	UM_debounced = ~UM;

debounce_pulse debounce_UM (
	.clk(clk),
	.slow_clk(slow_clk),
	.button(UM_debounced),
	.pulse_out(pulse_min_inc)
);

debounce_pulse debounce_UG (
	.clk(clk),
	.slow_clk(slow_clk),
	.button(UG_debounced),
	.pulse_out(pulse_hour_inc)
);

clock_counter clock_unit (
	.inc_min(pulse_min_inc),
	.inc_hour(pulse_hour_inc),
	.inc_min_auto(auto_minute_clk),
	.start(START),
	.clk(clk),
	.hour_tens(hour_tens),
	.hour_units(hour_units),
	.min_tens(min_tens),
	.min_units(min_units)
);

decoderBCD decode_min_units (
	.BCD(min_units),
	.seg(digit0)
);

decoderBCD decode_min_tens (
	.BCD(min_tens),
	.seg(digit1)
);

decoderBCD decode_hour_units (
	.BCD(hour_units),
	.seg(digit2)
);

decoderBCD decode_hour_tens (
	.BCD(hour_tens),
	.seg(digit3)
);

Prescaler prescaler_unit (
	.clk(clk),
	.start(START),
	.clock_1_60Hz(auto_minute_clk),
	.clock_1000Hz(slow_clk)
);

endmodule
