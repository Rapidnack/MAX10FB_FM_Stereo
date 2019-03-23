`timescale 1ns/1ns


module MyDeEmphasis
#(
	parameter DATA_WIDTH = 10
)
(
	input wire clk,
	input wire reset_n,
	
	input wire signed [DATA_WIDTH-1:0] in_data,
	input wire in_valid,

	output reg signed [DATA_WIDTH-1:0] out_data,
	output wire out_valid
);

	
	always @(posedge clk)
	begin
		if (~reset_n) begin			
			out_data <= 0;
		end
		else begin
			
			if (in_valid) begin
				// y[n] = 0.7058823529411764 * y[n-1] + 0.2941176470588236 * x[n]
								// 0 . 1011 0100 1011 0100 1011 0100 * y[n-1]
				out_data <=   (out_data >>> 1)
								+ (out_data >>> 3)
								+ (out_data >>> 4)
								+ (out_data >>> 6)
								+ (out_data >>> 9)
								// + 0 . 0100 1011 0100 1011 0100 1011 * x[n]
								+ (in_data >>> 2)
								+ (in_data >>> 5)
								+ (in_data >>> 7)
								+ (in_data >>> 8)
								+ (in_data >>> 10);
			end
			
		end
	end
	assign out_valid = in_valid;


endmodule