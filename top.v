`timescale 1 ps / 1 ps

module top
#(
	parameter DAC_WIDTH = 8,
	parameter LED_WIDTH = 3
)
(
	input wire CLK,
		
	input wire SPI_SCLK,
	input wire SPI_NSS,
	input wire SPI_MOSI,
	output wire SPI_MISO,
	
	input wire [7:0] ADC,
	output wire ENCODE,

	output wire I2S_SCK,
	output wire I2S_BCK,
	output wire I2S_LRCK,
	output wire I2S_DATA,
	
	output reg [DAC_WIDTH-1:0] DACA,
	output reg [DAC_WIDTH-1:0] DACB,
	
	output wire [LED_WIDTH-1:0] LED
);

	localparam CIC_WIDTH = 19;
	localparam FIR_WIDTH = 16;
	localparam PI = 17'sb0011_0010_0100_0011_1; // pi = 0011 . 0010 0100 0011 1111 0110 1010
	localparam NCO19K_WIDTH = 16;

	wire [31:0] pio0;
	wire [31:0] pio1;
	
	wire clk; // 73.728M (actual 73.714286M)
	
	wire [3:0] volume;
	wire [3:0] cic_out_gain;
	wire [3:0] fir_out_gain;

	reg [7:0] uadc_r;
	wire signed [7:0] adc;
	
	wire signed [11:0] sin;
	wire signed [11:0] cos;
	
	reg signed [CIC_WIDTH-1:0] i;
	reg signed [CIC_WIDTH-1:0] q;

	wire signed [CIC_WIDTH-1:0] icic;
	wire signed [CIC_WIDTH-1:0] qcic;
	wire icic_valid;

	wire signed [FIR_WIDTH-1:0] ifir;
	wire signed [FIR_WIDTH-1:0] qfir;
	wire ifir_valid;

	wire signed [FIR_WIDTH-1:0] phase;
	reg signed [FIR_WIDTH-1:0] phase_r;
	wire signed [FIR_WIDTH:0] phase_diff;
	reg signed [FIR_WIDTH:0] freq;
	wire signed [FIR_WIDTH-1:0] freq53k;

	wire signed [NCO19K_WIDTH-1:0] sin19k;
	wire signed [NCO19K_WIDTH-1:0] sin38k;
	wire signed [FIR_WIDTH+NCO19K_WIDTH-1:0] freqsin19k;
	wire signed [FIR_WIDTH+NCO19K_WIDTH-1:0] freqsin19k_ave;
	wire signed [FIR_WIDTH+NCO19K_WIDTH-1:0] freqsin19k_fb;
	wire signed [FIR_WIDTH+NCO19K_WIDTH-1:0] freqsin38k;
	
	wire signed [FIR_WIDTH-1:0] freq_LPR;
	wire signed [FIR_WIDTH-1:0] freq_LMR;
	wire freq_LPR_valid;
	wire signed [FIR_WIDTH-1:0] freq_L;
	wire signed [FIR_WIDTH-1:0] freq_R;
	wire signed [FIR_WIDTH-1:0] freq_LD;
	wire signed [FIR_WIDTH-1:0] freq_RD;
	
	wire signed [DAC_WIDTH-1:0] daca;
	wire signed [DAC_WIDTH-1:0] dacb;

	pll	pll_inst (
		.inclk0 (CLK),
		.c0 (clk)
	);
	
	QsysCore u0 (
		.clk_clk                                                                                         (clk),
		.reset_reset_n                                                                                   (1'b1),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_mosi_to_the_spislave_inst_for_spichain          (SPI_MOSI),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_nss_to_the_spislave_inst_for_spichain           (SPI_NSS),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_miso_to_and_from_the_spislave_inst_for_spichain (SPI_MISO),
		.spi_slave_to_avalon_mm_master_bridge_0_export_0_sclk_to_the_spislave_inst_for_spichain          (SPI_SCLK),
		.pio_0_external_connection_export                                                                (pio0),
		.pio_1_external_connection_export                                                                (pio1)
	);

	assign LED = ~pio0[LED_WIDTH-1:0];
	
	assign volume = pio0[3:0];
	assign cic_out_gain = 3;
	assign fir_out_gain = 0;
	
	always @(posedge clk) begin
		uadc_r <= ADC;
	end
	assign ENCODE = clk;
	assign adc = (uadc_r[7] == 0) ? uadc_r + 8'h80 : uadc_r - 8'h80;

	MyNCO #(
		.OUT_WIDTH(12)
	) nco_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.clken     (1'b1),
		.phi_inc_i (pio1),
		.fsin_o    (sin),
		.fcos_o    (cos),
		.out_valid ()
	);

	always @(posedge clk) begin
		i <= adc * cos;
		q <= adc * sin;
	end
	
	MyCIC #(
		.DATA_WIDTH(CIC_WIDTH)
	) cic_inst_i (
		.clk       (clk),
		.reset_n   (1'b1),
		.in_error  (2'b00),
		.in_valid  (1'b1),
		.in_ready  (),
		.in_data   (i),
		.out_data  (icic),
		.out_error (),
		.out_valid (icic_valid),
		.out_ready (1'b1)
	);

	MyCIC #(
		.DATA_WIDTH(CIC_WIDTH)
	) cic_inst_q (
		.clk       (clk),
		.reset_n   (1'b1),
		.in_error  (2'b00),
		.in_valid  (1'b1),
		.in_ready  (),
		.in_data   (q),
		.out_data  (qcic),
		.out_error (),
		.out_valid (),
		.out_ready (1'b1)
	);
  
	MyFIR #(
		.DATA_WIDTH(FIR_WIDTH)
	) fir8_inst_i (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (icic[CIC_WIDTH-1 -cic_out_gain -: FIR_WIDTH]),
		.ast_sink_valid (icic_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (ifir),
		.ast_source_valid (ifir_valid),
		.ast_source_error ()
	);
 
	MyFIR #(
		.DATA_WIDTH(FIR_WIDTH)
	) fir8_inst_q (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (qcic[CIC_WIDTH-1 -cic_out_gain -: FIR_WIDTH]),
		.ast_sink_valid (icic_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (qfir),
		.ast_source_valid (),
		.ast_source_error ()
	);
 
	vectran vectran_inst (
		.clk    (clk),
		.areset (1'b0),
		.x      (ifir <<< fir_out_gain),
		.y      (qfir <<< fir_out_gain),
		.q      (phase),
		.r      (),
		.en     (ifir_valid)
	);

	always @(posedge clk) begin
		if (ifir_valid) begin
			phase_r <= phase;

			if (phase_diff > PI) begin
				freq <= phase_diff - (PI <<< 1);
			end
			else if (phase_diff < -PI) begin
				freq <= phase_diff + (PI <<< 1);
			end
			else begin
				freq <= phase_diff;
			end
		end
	end
	assign phase_diff = phase - phase_r;
 
	MyLPF53K #(
		.DATA_WIDTH(FIR_WIDTH)
	) lpf_53k_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (freq[FIR_WIDTH-1 -: FIR_WIDTH]),
		.ast_sink_valid (ifir_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (freq53k),
		.ast_source_valid (),
		.ast_source_error ()
	);
 
	MyNCO2X #(
		.OUT_WIDTH(NCO19K_WIDTH)
	) MyNCO2X_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.clken     (ifir_valid),
		.phi_inc_i (32'sd212550939 - (freqsin19k_fb <<< 2)),
		.fsin_o    (sin19k),
		.fsin2x_o    (sin38k),
		.out_valid ()
		);
	assign freqsin19k = $signed(freq53k) * sin19k;
	assign freqsin38k = $signed(freq53k) * sin38k;

	MyAverage #(
		.DATA_WIDTH(FIR_WIDTH+NCO19K_WIDTH),
		.AVERAGE_WIDTH(9),
		.AVERAGE(384),
		.MOVING_AVERAGE_WIDTH(8)
	) MyAverage_LOOP_inst (
		.clk (clk),
		.reset_n (1'b1),
		.in_data (freqsin19k),
		.in_valid (ifir_valid),
		.out_data (freqsin19k_ave),
		.out_valid (freqsin19k_ave_valid)
	);
	assign freqsin19k_fb = freqsin19k_ave_valid ? freqsin19k_ave : 0;
 
	MyLPF #(
		.DATA_WIDTH(FIR_WIDTH)
	) lpf8_LPR_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (freq53k),
		.ast_sink_valid (ifir_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (freq_LPR),
		.ast_source_valid (freq_LPR_valid),
		.ast_source_error ()
	);

	MyLPF #(
		.DATA_WIDTH(FIR_WIDTH)
	) lpf8_LMR_inst (
		.clk       (clk),
		.reset_n   (1'b1),
		.ast_sink_data (freqsin38k[FIR_WIDTH+NCO19K_WIDTH-1-1-1 -: FIR_WIDTH]),
		.ast_sink_valid (ifir_valid),
		.ast_sink_error (2'b00),
		.ast_source_data (freq_LMR),
		.ast_source_valid (),
		.ast_source_error ()
	);
	
	assign freq_L = freq_LPR + freq_LMR;
	assign freq_R = freq_LPR - freq_LMR;

	MyDeEmphasis #(
		.DATA_WIDTH(FIR_WIDTH)
	) MyDeEmphasis_L_inst (
		.clk (clk),
		.reset_n (1'b1),
		.in_data (freq_L),
		.in_valid (freq_LPR_valid),
		.out_data (freq_LD),
		.out_valid ()
	);

	MyDeEmphasis #(
		.DATA_WIDTH(FIR_WIDTH)
	) MyDeEmphasis_R_inst (
		.clk (clk),
		.reset_n (1'b1),
		.in_data (freq_R),
		.in_valid (freq_LPR_valid),
		.out_data (freq_RD),
		.out_valid ()
	);
	
	MyI2S #(
		.IN_WIDTH(FIR_WIDTH)
	) MyI2S_inst (
		.clk (clk),
		.reset_n (1'b1),	
		.volume (4'b1111 - volume),
		.in_left (freq_LD),
		.in_right (freq_RD),
		.in_valid (freq_LPR_valid),
		.SCK (I2S_SCK),
		.BCK (I2S_BCK),
		.LRCK (I2S_LRCK),
		.DATA (I2S_DATA)
	);


//	assign daca = sin[11 -: DAC_WIDTH];
//	assign dacb = cos[11 -: DAC_WIDTH];	
//	assign daca = i[CIC_WIDTH-1 -: DAC_WIDTH];
//	assign dacb = q[CIC_WIDTH-1 -: DAC_WIDTH];
//	assign daca = icic[CIC_WIDTH-1 -: DAC_WIDTH]; // icic_valid
//	assign dacb = qcic[CIC_WIDTH-1 -: DAC_WIDTH]; // icic_valid
//	assign daca = ifir[FIR_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = qfir[FIR_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign daca = phase[FIR_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = freq[FIR_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = freq53k[FIR_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign daca = freq_LPR[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign dacb = freq_LMR[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign daca = freq_L[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign dacb = freq_R[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign daca = freq_LD[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign dacb = freq_RD[FIR_WIDTH-1 -: DAC_WIDTH]; // freq_LPR_valid
//	assign daca = sin19k[NCO19K_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = sin38k[NCO19K_WIDTH-1 -: DAC_WIDTH]; // ifir_valid
//	assign daca = freqsin19k[FIR_WIDTH+NCO19K_WIDTH-1-1-1 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = freqsin38k[FIR_WIDTH+NCO19K_WIDTH-1-1-1 -: DAC_WIDTH]; // ifir_valid
//	assign daca = freqsin19k_ave[FIR_WIDTH+NCO19K_WIDTH-1-1-1-5 -: DAC_WIDTH]; // ifir_valid
//	assign dacb = freqsin19k_fb[FIR_WIDTH+NCO19K_WIDTH-1-1-1-5 -: DAC_WIDTH]; // ifir_valid

	assign daca = freqsin19k_ave[FIR_WIDTH+NCO19K_WIDTH-1-1-1-5 -: DAC_WIDTH]; // ifir_valid
	assign dacb = freqsin19k_fb[FIR_WIDTH+NCO19K_WIDTH-1-1-1-5 -: DAC_WIDTH]; // ifir_valid
	always @(posedge clk) begin
		if (ifir_valid)
			DACA <= (daca[DAC_WIDTH-1] == 0) ? daca + (1'b1 << DAC_WIDTH-1) : daca - (1'b1 << DAC_WIDTH-1);
		if (ifir_valid)
			DACB <= (dacb[DAC_WIDTH-1] == 0) ? dacb + (1'b1 << DAC_WIDTH-1) : dacb - (1'b1 << DAC_WIDTH-1);
	end
 	
endmodule