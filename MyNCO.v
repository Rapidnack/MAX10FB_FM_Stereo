`timescale 1ns/1ns


module MyNCO
 #(
	parameter ACCUMULATOR_WIDTH = 32,
	parameter OUT_WIDTH = 12
 )
(
	input  wire clk,
	input  wire reset_n,
	input  wire clken,
	input  wire [ACCUMULATOR_WIDTH-1:0] phi_inc_i,
	output wire [OUT_WIDTH-1:0] fsin_o,
	output wire [OUT_WIDTH-1:0] fcos_o,
	output wire out_valid
);


	// ROM 18x4096
	localparam ROM_DATA_WIDTH = 18;
	localparam ROM_ADDR_WIDTH = 12;


	wire [ROM_DATA_WIDTH-1:0] cos;
	wire [ROM_DATA_WIDTH-1:0] sin;
	reg [ACCUMULATOR_WIDTH-1:0] addr;
	wire [ACCUMULATOR_WIDTH-1:0] cos_addr;


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
	assign cos_addr = addr + (1'b1 << (ACCUMULATOR_WIDTH - 2));
		
	romsin	romsin_sin_inst (
		.address ( addr[ACCUMULATOR_WIDTH-1 -: ROM_ADDR_WIDTH] ),
		.clock ( clk ),
		.q ( sin )
	);
	
	romsin	romsin_cos_inst (
		.address ( cos_addr[ACCUMULATOR_WIDTH-1 -: ROM_ADDR_WIDTH] ),
		.clock ( clk ),
		.q ( cos )
	);

	assign fcos_o = cos[ROM_DATA_WIDTH-1 -: OUT_WIDTH];
	assign fsin_o = sin[ROM_DATA_WIDTH-1 -: OUT_WIDTH];


endmodule