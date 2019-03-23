`timescale 1ns/1ns


module MyFIR
#(
	parameter RATE = 8,
	parameter DATA_WIDTH = 16
)
(
	input wire clk,
	input wire reset_n,
	
	input wire signed [DATA_WIDTH-1:0] ast_sink_data,
	input wire ast_sink_valid,
	input wire [1:0] ast_sink_error,

	output reg signed [DATA_WIDTH-1:0] ast_source_data,
	output reg ast_source_valid,
	output wire [1:0] ast_source_error
);


	localparam NUM_TAPS = 191;
	localparam H_WIDTH = 16;
	localparam Y_WIDTH = H_WIDTH + DATA_WIDTH - 1;

	// RAM 16x256
	localparam RAM_NUM_ADDRS = 256;
	
	
	integer i;

	reg signed [H_WIDTH-1:0] h[0:NUM_TAPS-1];
	wire signed [DATA_WIDTH-1:0] x;
	reg signed [Y_WIDTH-1:0] y;
	
	wire [7:0] raddr;
	reg [7:0] waddr;
	reg [7:0] last_waddr;

	reg [8:0] cnt;
	reg [7:0] deci_cnt;

	
	// Normalized Frequency: 0.0625
	initial begin
		h[0] = -3;
		h[1] = -6;
		h[2] = -8;
		h[3] = -9;
		h[4] = -9;
		h[5] = -7;
		h[6] = -4;
		h[7] = 0;
		h[8] = 4;
		h[9] = 9;
		h[10] = 12;
		h[11] = 14;
		h[12] = 13;
		h[13] = 11;
		h[14] = 6;
		h[15] = 0;
		h[16] = -7;
		h[17] = -14;
		h[18] = -20;
		h[19] = -23;
		h[20] = -23;
		h[21] = -19;
		h[22] = -11;
		h[23] = 0;
		h[24] = 12;
		h[25] = 24;
		h[26] = 33;
		h[27] = 39;
		h[28] = 38;
		h[29] = 31;
		h[30] = 18;
		h[31] = 0;
		h[32] = -20;
		h[33] = -39;
		h[34] = -54;
		h[35] = -62;
		h[36] = -60;
		h[37] = -49;
		h[38] = -28;
		h[39] = 0;
		h[40] = 31;
		h[41] = 60;
		h[42] = 83;
		h[43] = 95;
		h[44] = 92;
		h[45] = 74;
		h[46] = 42;
		h[47] = 0;
		h[48] = -47;
		h[49] = -90;
		h[50] = -124;
		h[51] = -141;
		h[52] = -136;
		h[53] = -109;
		h[54] = -62;
		h[55] = 0;
		h[56] = 68;
		h[57] = 132;
		h[58] = 181;
		h[59] = 206;
		h[60] = 200;
		h[61] = 160;
		h[62] = 91;
		h[63] = 0;
		h[64] = -100;
		h[65] = -195;
		h[66] = -267;
		h[67] = -304;
		h[68] = -296;
		h[69] = -238;
		h[70] = -136;
		h[71] = 0;
		h[72] = 152;
		h[73] = 296;
		h[74] = 410;
		h[75] = 471;
		h[76] = 463;
		h[77] = 377;
		h[78] = 218;
		h[79] = 0;
		h[80] = -251;
		h[81] = -501;
		h[82] = -710;
		h[83] = -838;
		h[84] = -850;
		h[85] = -719;
		h[86] = -435;
		h[87] = 0;
		h[88] = 563;
		h[89] = 1218;
		h[90] = 1915;
		h[91] = 2597;
		h[92] = 3205;
		h[93] = 3684;
		h[94] = 3990;
		h[95] = 4096;
		h[96] = 3990;
		h[97] = 3684;
		h[98] = 3205;
		h[99] = 2597;
		h[100] = 1915;
		h[101] = 1218;
		h[102] = 563;
		h[103] = 0;
		h[104] = -435;
		h[105] = -719;
		h[106] = -850;
		h[107] = -838;
		h[108] = -710;
		h[109] = -501;
		h[110] = -251;
		h[111] = 0;
		h[112] = 218;
		h[113] = 377;
		h[114] = 463;
		h[115] = 471;
		h[116] = 410;
		h[117] = 296;
		h[118] = 152;
		h[119] = 0;
		h[120] = -136;
		h[121] = -238;
		h[122] = -296;
		h[123] = -304;
		h[124] = -267;
		h[125] = -195;
		h[126] = -100;
		h[127] = 0;
		h[128] = 91;
		h[129] = 160;
		h[130] = 200;
		h[131] = 206;
		h[132] = 181;
		h[133] = 132;
		h[134] = 68;
		h[135] = 0;
		h[136] = -62;
		h[137] = -109;
		h[138] = -136;
		h[139] = -141;
		h[140] = -124;
		h[141] = -90;
		h[142] = -47;
		h[143] = 0;
		h[144] = 42;
		h[145] = 74;
		h[146] = 92;
		h[147] = 95;
		h[148] = 83;
		h[149] = 60;
		h[150] = 31;
		h[151] = 0;
		h[152] = -28;
		h[153] = -49;
		h[154] = -60;
		h[155] = -62;
		h[156] = -54;
		h[157] = -39;
		h[158] = -20;
		h[159] = 0;
		h[160] = 18;
		h[161] = 31;
		h[162] = 38;
		h[163] = 39;
		h[164] = 33;
		h[165] = 24;
		h[166] = 12;
		h[167] = 0;
		h[168] = -11;
		h[169] = -19;
		h[170] = -23;
		h[171] = -23;
		h[172] = -20;
		h[173] = -14;
		h[174] = -7;
		h[175] = 0;
		h[176] = 6;
		h[177] = 11;
		h[178] = 13;
		h[179] = 14;
		h[180] = 12;
		h[181] = 9;
		h[182] = 4;
		h[183] = 0;
		h[184] = -4;
		h[185] = -7;
		h[186] = -9;
		h[187] = -9;
		h[188] = -8;
		h[189] = -6;
		h[190] = -3;
	end

	
	assign ast_source_error = 2'b00;
	
	always @(posedge clk)
	begin
		if (~reset_n) begin
			waddr <= 0;
			cnt <= 0;
			
			deci_cnt <= 0;
			
			y <= 0;
			ast_source_data <= 0;
			ast_source_valid <= 1'b0;
		end
		else begin
			
			if (ast_sink_valid) begin			
				if (waddr == RAM_NUM_ADDRS-1) begin
					waddr <= 0;
				end
				else begin
					waddr <= waddr + 1;			
				end
								
				if (deci_cnt == RATE-1) begin
					deci_cnt <= 0;
					
					ast_source_data <= y[Y_WIDTH-1 -: DATA_WIDTH];
					ast_source_valid <= 1'b1;
					
					last_waddr <= waddr;
					cnt <= 0;
					y <= 0;
				end
				else begin
					deci_cnt <= deci_cnt + 1;
					
					if (cnt < NUM_TAPS) begin
						cnt <= cnt + 1;
					end
					if (cnt < NUM_TAPS) begin
						y <= y + h[cnt] * x;
					end
					ast_source_valid <= 1'b0;
				end
			end
			else begin
				if (cnt < NUM_TAPS) begin
					cnt <= cnt + 1;
				end
				if (cnt < NUM_TAPS) begin
					y <= y + h[cnt] * x;
				end
				ast_source_valid <= 1'b0;
			end
		end
	end
	
	assign raddr = (RAM_NUM_ADDRS + last_waddr - (NUM_TAPS - 1) + cnt <= RAM_NUM_ADDRS-1)
					? RAM_NUM_ADDRS + last_waddr - (NUM_TAPS - 1) + cnt
					: RAM_NUM_ADDRS + last_waddr - (NUM_TAPS - 1) + cnt - RAM_NUM_ADDRS;

	ram16x256 ram16x256_inst (
		.clock (clk),
		.data (ast_sink_data),
		.rdaddress (raddr),
		.wraddress (waddr),
		.wren (ast_sink_valid),
		.q (x)
	);


endmodule