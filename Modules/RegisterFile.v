`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    RegisterFile
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
//
// Revision: 
// Revision 1.1 - non-verified
// Additional Comments: 
// Decoder only used once in the whole project, it's not necessary to use parameterized module.
//////////////////////////////////////////////////////////////////////////////////
module RegisterFile(
	input clk_n,				// clock
	input WE,					// write enable
	input [2:0] Waddr,			// write address
	input [15:0] Wdata,			// write data
	input [2:0] Aaddr,			// read address A
	input [2:0] Baddr,			// read address B
	output reg [15:0] Adata,	// read data A
	output reg [15:0] Bdata);	// read data B
	
	wire [7:0] WEtarget;		// write enable target
	Decoder3x8 decoder(		// decoder
		.I(Waddr),			// address
		.O(WEtarget));		// data output
	
	wire [15:0] regs [0:7];	// register array
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin: genReg
			// register
			Reg16bClkEn reg16b(
				.clk(clk_n),			// clock
				.clk_en(WEtarget[i]),	// clock enable
				.rst(1'b0),				// reset
				.D(Wdata),				// data input
				.Q(regs[i]));			// data output
		end
	endgenerate

	// read data A
	always @(*) begin
		case (Aaddr)
			3'b000: Adata = regs[0];
			3'b001: Adata = regs[1];
			3'b010: Adata = regs[2];
			3'b011: Adata = regs[3];
			3'b100: Adata = regs[4];
			3'b101: Adata = regs[5];
			3'b110: Adata = regs[6];
			3'b111: Adata = regs[7];
			default: Adata = 16'b0;
		endcase
	end
	// read data B
	always @(*) begin
		Bdata = 16'b0;
		case (Baddr)
			3'b000: Bdata = regs[0];
			3'b001: Bdata = regs[1];
			3'b010: Bdata = regs[2];
			3'b011: Bdata = regs[3];
			3'b100: Bdata = regs[4];
			3'b101: Bdata = regs[5];
			3'b110: Bdata = regs[6];
			3'b111: Bdata = regs[7];
			default: Bdata = 16'b0;
		endcase
	end
endmodule
