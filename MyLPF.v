`timescale 1ns/1ns


module MyLPF
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


	localparam NUM_TAPS = 199;
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

	
	// Normalized Frequency: 0.039
	initial begin
		h[0] = -6;
		h[1] = -8;
		h[2] = -9;
		h[3] = -9;
		h[4] = -9;
		h[5] = -8;
		h[6] = -7;
		h[7] = -5;
		h[8] = -3;
		h[9] = -1;
		h[10] = 2;
		h[11] = 5;
		h[12] = 8;
		h[13] = 11;
		h[14] = 14;
		h[15] = 16;
		h[16] = 17;
		h[17] = 18;
		h[18] = 17;
		h[19] = 14;
		h[20] = 11;
		h[21] = 6;
		h[22] = 0;
		h[23] = -6;
		h[24] = -13;
		h[25] = -20;
		h[26] = -27;
		h[27] = -32;
		h[28] = -36;
		h[29] = -39;
		h[30] = -38;
		h[31] = -36;
		h[32] = -30;
		h[33] = -22;
		h[34] = -11;
		h[35] = 1;
		h[36] = 15;
		h[37] = 30;
		h[38] = 44;
		h[39] = 57;
		h[40] = 68;
		h[41] = 75;
		h[42] = 78;
		h[43] = 76;
		h[44] = 69;
		h[45] = 57;
		h[46] = 39;
		h[47] = 18;
		h[48] = -7;
		h[49] = -34;
		h[50] = -62;
		h[51] = -88;
		h[52] = -111;
		h[53] = -129;
		h[54] = -140;
		h[55] = -144;
		h[56] = -138;
		h[57] = -123;
		h[58] = -98;
		h[59] = -65;
		h[60] = -24;
		h[61] = 22;
		h[62] = 71;
		h[63] = 120;
		h[64] = 166;
		h[65] = 206;
		h[66] = 237;
		h[67] = 255;
		h[68] = 259;
		h[69] = 246;
		h[70] = 216;
		h[71] = 169;
		h[72] = 106;
		h[73] = 30;
		h[74] = -56;
		h[75] = -148;
		h[76] = -241;
		h[77] = -329;
		h[78] = -406;
		h[79] = -466;
		h[80] = -504;
		h[81] = -513;
		h[82] = -490;
		h[83] = -431;
		h[84] = -336;
		h[85] = -203;
		h[86] = -34;
		h[87] = 168;
		h[88] = 398;
		h[89] = 650;
		h[90] = 916;
		h[91] = 1188;
		h[92] = 1458;
		h[93] = 1715;
		h[94] = 1951;
		h[95] = 2158;
		h[96] = 2327;
		h[97] = 2452;
		h[98] = 2530;
		h[99] = 2556;
		h[100] = 2530;
		h[101] = 2452;
		h[102] = 2327;
		h[103] = 2158;
		h[104] = 1951;
		h[105] = 1715;
		h[106] = 1458;
		h[107] = 1188;
		h[108] = 916;
		h[109] = 650;
		h[110] = 398;
		h[111] = 168;
		h[112] = -34;
		h[113] = -203;
		h[114] = -336;
		h[115] = -431;
		h[116] = -490;
		h[117] = -513;
		h[118] = -504;
		h[119] = -466;
		h[120] = -406;
		h[121] = -329;
		h[122] = -241;
		h[123] = -148;
		h[124] = -56;
		h[125] = 30;
		h[126] = 106;
		h[127] = 169;
		h[128] = 216;
		h[129] = 246;
		h[130] = 259;
		h[131] = 255;
		h[132] = 237;
		h[133] = 206;
		h[134] = 166;
		h[135] = 120;
		h[136] = 71;
		h[137] = 22;
		h[138] = -24;
		h[139] = -65;
		h[140] = -98;
		h[141] = -123;
		h[142] = -138;
		h[143] = -144;
		h[144] = -140;
		h[145] = -129;
		h[146] = -111;
		h[147] = -88;
		h[148] = -62;
		h[149] = -34;
		h[150] = -7;
		h[151] = 18;
		h[152] = 39;
		h[153] = 57;
		h[154] = 69;
		h[155] = 76;
		h[156] = 78;
		h[157] = 75;
		h[158] = 68;
		h[159] = 57;
		h[160] = 44;
		h[161] = 30;
		h[162] = 15;
		h[163] = 1;
		h[164] = -11;
		h[165] = -22;
		h[166] = -30;
		h[167] = -36;
		h[168] = -38;
		h[169] = -39;
		h[170] = -36;
		h[171] = -32;
		h[172] = -27;
		h[173] = -20;
		h[174] = -13;
		h[175] = -6;
		h[176] = 0;
		h[177] = 6;
		h[178] = 11;
		h[179] = 14;
		h[180] = 17;
		h[181] = 18;
		h[182] = 17;
		h[183] = 16;
		h[184] = 14;
		h[185] = 11;
		h[186] = 8;
		h[187] = 5;
		h[188] = 2;
		h[189] = -1;
		h[190] = -3;
		h[191] = -5;
		h[192] = -7;
		h[193] = -8;
		h[194] = -9;
		h[195] = -9;
		h[196] = -9;
		h[197] = -8;
		h[198] = -6;
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