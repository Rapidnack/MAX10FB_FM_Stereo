`timescale 1ns/1ns


module MyNCO2X
 #(
	parameter OUT_WIDTH = 10
 )
(
	input  wire clk,
	input  wire clken,
	input  wire [31:0] phi_inc_i,
	output wire [OUT_WIDTH-1:0] fsin_o,
	output wire [OUT_WIDTH-1:0] fsin2x_o,
	output wire out_valid,
	input  wire reset_n
);


	wire [17:0] sin2x;
	wire [17:0] sin;
	reg [31:0] addr;
	wire [31:0] sin2x_addr;


	assign out_valid = 1'b1;

	always @(posedge clk)
	begin
		if (~reset_n)
		begin
			addr <= 0;
		end else if (clken) begin
			addr <= addr + phi_inc_i;
		end
	end
	assign sin2x_addr = addr << 1;
			
	romsin	romsin_sin_inst (
		.address ( addr[31 -: 12] ),
		.clock ( clk ),
		.q ( sin )
	);
	
	romsin	romsin_sin2x_inst (
		.address ( sin2x_addr[31 -: 12] ),
		.clock ( clk ),
		.q ( sin2x )
	);

	assign fsin2x_o = sin2x[17 -: OUT_WIDTH];
	assign fsin_o = sin[17 -: OUT_WIDTH];


endmodule