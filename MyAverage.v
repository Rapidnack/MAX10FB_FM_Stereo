`timescale 1ns/1ns


module MyAverage
#(
	parameter DATA_WIDTH = 10,
	parameter AVERAGE_WIDTH = 9,
	parameter AVERAGE = 512,
	parameter MOVING_AVERAGE_WIDTH = 2
)
(
	input wire clk,
	input wire reset_n,
	
	input wire signed [DATA_WIDTH-1:0] in_data,
	input wire in_valid,

	output wire signed [DATA_WIDTH-1:0] out_data,
	output wire out_valid
);


	localparam SUM_WIDTH = AVERAGE_WIDTH + DATA_WIDTH;


	reg [AVERAGE_WIDTH-1:0] cnt;
	
	reg signed [SUM_WIDTH-1:0] sum;
	reg signed [MOVING_AVERAGE_WIDTH+SUM_WIDTH-1:0] ave;

	
	always @(posedge clk)
	begin
		if (~reset_n) begin			
			cnt <= 0;
					
			sum <= 0;
						
			ave <= 0;
		end
		else begin
			
			if (in_valid) begin
				if (cnt == AVERAGE-1) begin
					cnt <= 0;
					
					sum <= 0;
					
					ave <= ave - (ave >>> MOVING_AVERAGE_WIDTH) + (sum >>> AVERAGE_WIDTH);
				end
				else begin				
					cnt <= cnt + 1;
					
					sum <= sum + in_data;
				end
			end
			
		end
	end
	assign out_data = ave >>> MOVING_AVERAGE_WIDTH;
	assign out_valid = (cnt == AVERAGE-1) ? 1'b1 : 1'b0;


endmodule