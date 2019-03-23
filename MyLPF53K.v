`timescale 1ns/1ns


module MyLPF53K
#(
	parameter RATE = 1,
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

	
	// Normalized Frequency: 0.138
	initial begin
		h[0] = 6;
		h[1] = -2;
		h[2] = -8;
		h[3] = -9;
		h[4] = -3;
		h[5] = 5;
		h[6] = 10;
		h[7] = 9;
		h[8] = 0;
		h[9] = -9;
		h[10] = -13;
		h[11] = -7;
		h[12] = 4;
		h[13] = 14;
		h[14] = 15;
		h[15] = 4;
		h[16] = -11;
		h[17] = -20;
		h[18] = -15;
		h[19] = 2;
		h[20] = 20;
		h[21] = 26;
		h[22] = 13;
		h[23] = -12;
		h[24] = -30;
		h[25] = -29;
		h[26] = -5;
		h[27] = 26;
		h[28] = 41;
		h[29] = 27;
		h[30] = -9;
		h[31] = -43;
		h[32] = -49;
		h[33] = -19;
		h[34] = 29;
		h[35] = 61;
		h[36] = 51;
		h[37] = 2;
		h[38] = -54;
		h[39] = -76;
		h[40] = -43;
		h[41] = 25;
		h[42] = 83;
		h[43] = 85;
		h[44] = 24;
		h[45] = -62;
		h[46] = -110;
		h[47] = -81;
		h[48] = 11;
		h[49] = 104;
		h[50] = 130;
		h[51] = 61;
		h[52] = -59;
		h[53] = -148;
		h[54] = -136;
		h[55] = -21;
		h[56] = 121;
		h[57] = 187;
		h[58] = 121;
		h[59] = -41;
		h[60] = -189;
		h[61] = -212;
		h[62] = -79;
		h[63] = 126;
		h[64] = 258;
		h[65] = 212;
		h[66] = 4;
		h[67] = -229;
		h[68] = -316;
		h[69] = -177;
		h[70] = 110;
		h[71] = 347;
		h[72] = 352;
		h[73] = 94;
		h[74] = -265;
		h[75] = -470;
		h[76] = -347;
		h[77] = 54;
		h[78] = 469;
		h[79] = 590;
		h[80] = 280;
		h[81] = -294;
		h[82] = -740;
		h[83] = -696;
		h[84] = -104;
		h[85] = 696;
		h[86] = 1134;
		h[87] = 780;
		h[88] = -312;
		h[89] = -1520;
		h[90] = -1927;
		h[91] = -834;
		h[92] = 1784;
		h[93] = 5140;
		h[94] = 7950;
		h[95] = 9044;
		h[96] = 7950;
		h[97] = 5140;
		h[98] = 1784;
		h[99] = -834;
		h[100] = -1927;
		h[101] = -1520;
		h[102] = -312;
		h[103] = 780;
		h[104] = 1134;
		h[105] = 696;
		h[106] = -104;
		h[107] = -696;
		h[108] = -740;
		h[109] = -294;
		h[110] = 280;
		h[111] = 590;
		h[112] = 469;
		h[113] = 54;
		h[114] = -347;
		h[115] = -470;
		h[116] = -265;
		h[117] = 94;
		h[118] = 352;
		h[119] = 347;
		h[120] = 110;
		h[121] = -177;
		h[122] = -316;
		h[123] = -229;
		h[124] = 4;
		h[125] = 212;
		h[126] = 258;
		h[127] = 126;
		h[128] = -79;
		h[129] = -212;
		h[130] = -189;
		h[131] = -41;
		h[132] = 121;
		h[133] = 187;
		h[134] = 121;
		h[135] = -21;
		h[136] = -136;
		h[137] = -148;
		h[138] = -59;
		h[139] = 61;
		h[140] = 130;
		h[141] = 104;
		h[142] = 11;
		h[143] = -81;
		h[144] = -110;
		h[145] = -62;
		h[146] = 24;
		h[147] = 85;
		h[148] = 83;
		h[149] = 25;
		h[150] = -43;
		h[151] = -76;
		h[152] = -54;
		h[153] = 2;
		h[154] = 51;
		h[155] = 61;
		h[156] = 29;
		h[157] = -19;
		h[158] = -49;
		h[159] = -43;
		h[160] = -9;
		h[161] = 27;
		h[162] = 41;
		h[163] = 26;
		h[164] = -5;
		h[165] = -29;
		h[166] = -30;
		h[167] = -12;
		h[168] = 13;
		h[169] = 26;
		h[170] = 20;
		h[171] = 2;
		h[172] = -15;
		h[173] = -20;
		h[174] = -11;
		h[175] = 4;
		h[176] = 15;
		h[177] = 14;
		h[178] = 4;
		h[179] = -7;
		h[180] = -13;
		h[181] = -9;
		h[182] = 0;
		h[183] = 9;
		h[184] = 10;
		h[185] = 5;
		h[186] = -3;
		h[187] = -9;
		h[188] = -8;
		h[189] = -2;
		h[190] = 6;
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