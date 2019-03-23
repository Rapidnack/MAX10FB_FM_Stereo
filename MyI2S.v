`timescale 1ns/1ns


module MyI2S
 #(
	parameter VOLUME_WIDTH = 4,
	parameter IN_WIDTH = 10,
	parameter OUT_WIDTH = 32
 )
(
	input wire clk, // 73.728M
	input wire reset_n,
	
	input wire [VOLUME_WIDTH-1:0] volume,
	input wire signed [IN_WIDTH-1:0] in_left,
	input wire signed [IN_WIDTH-1:0] in_right,
	input wire in_valid,

	output reg SCK,
	output reg BCK,
	output reg LRCK,
	output reg DATA
);


	localparam LRCK_CLK = 1536;
	localparam LRCK_HALF_CLK = LRCK_CLK >> 1;
	localparam BCK_CLK = 24;
	localparam BCK_HALF_CLK = BCK_CLK >> 1;


	reg [10:0] lrck_cnt; // fs = 48k = clk / 1536
	reg [5:0] bck_cnt; // fs * 64 = clk / 24
	
	reg signed [OUT_WIDTH-1:0] out_left;
	reg signed [OUT_WIDTH-1:0] out_right;


	always @(posedge clk) begin
		if (~reset_n) begin
			lrck_cnt <= 0;
			
			LRCK <= 1'b1;
		end
		else begin
			if (in_valid) begin
				lrck_cnt <= 0;
				
				LRCK <= 1'b1;
			end
			else begin
				lrck_cnt <= lrck_cnt + 1;
				
				if (lrck_cnt == LRCK_HALF_CLK-1) begin
					LRCK <= 1'b0;
				end
			end
		end
	end

	always @(posedge clk) begin
		if (~reset_n) begin
			bck_cnt <= 0;

			BCK <= 1'b0;

			DATA <= 1'b0;
			out_left <= 0;
			out_right <= 0;
		end
		else begin
			if (in_valid) begin
				bck_cnt <= 0;

				BCK <= 1'b0;

				DATA <= (lrck_cnt < LRCK_HALF_CLK) ? out_left[OUT_WIDTH-1] : out_right[OUT_WIDTH-1];
				out_left <= in_left <<< (OUT_WIDTH - IN_WIDTH - volume);
				out_right <= in_right <<< (OUT_WIDTH - IN_WIDTH - volume);
			end
			else begin
				if (bck_cnt == BCK_CLK-1) begin
					bck_cnt <= 0;
					
					BCK <= 1'b0;
					
					DATA <= (lrck_cnt < LRCK_HALF_CLK) ? out_left[OUT_WIDTH-1] : out_right[OUT_WIDTH-1];
					if (lrck_cnt < LRCK_HALF_CLK) out_left <= out_left <<< 1;
					else out_right <= out_right <<< 1;
				end
				else begin
					bck_cnt <= bck_cnt + 1;
					
					if (bck_cnt == BCK_HALF_CLK-1) begin
						BCK <= 1'b1;
					end
				end
			end
		end
	end


endmodule