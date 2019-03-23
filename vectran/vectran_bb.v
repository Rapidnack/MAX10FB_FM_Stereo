
module vectran (
	clk,
	areset,
	x,
	y,
	q,
	r,
	en);	

	input		clk;
	input		areset;
	input	[15:0]	x;
	input	[15:0]	y;
	output	[15:0]	q;
	output	[15:0]	r;
	input	[0:0]	en;
endmodule
