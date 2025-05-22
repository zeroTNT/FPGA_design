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
// This module is a 16-bit register file with 8 registers.
// It has a write enable signal, a write address, and a write data input.
// It also has two read addresses and outputs the corresponding read data.
// The write operation is performed on the negedge of the clock.
// The read operation is performed as combinaitonal circuit.
//
// Dependencies: 
//
// Revision: 
// Revision 2.0 - verified
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
	output [15:0] Adata,	// read data A
	output [15:0] Bdata);	// read data B
	
	wire [7:0] WEtarget;		// write enable target
	wire [15:0] regs [0:7];	// register array

	Decoder3x8 decoder(		// decoder
		.I(Waddr),			// address
		.Enable(WE),		// enable
		.O(WEtarget));		// data output
	
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin: genReg
			// register
			Reg16bClkEn reg16b(
				.clk_n(clk_n),			// clock
				.clk_en(WEtarget[i]),	// clock enable
				.D(Wdata),				// data input
				.Q(regs[i]));			// data output
		end
	endgenerate

	Mul16b8x1 muxA(			// multiplexer A
		.addr(Aaddr),			// address
		.D0(regs[0]),			// data input 0
		.D1(regs[1]),			// data input 1
		.D2(regs[2]),			// data input 2
		.D3(regs[3]),			// data input 3
		.D4(regs[4]),			// data input 4
		.D5(regs[5]),			// data input 5
		.D6(regs[6]),			// data input 6
		.D7(regs[7]),			// data input 7
		.OutData(Adata));		// output data
	Mul16b8x1 muxB(			// multiplexer B
		.addr(Baddr),			// address
		.D0(regs[0]),			// data input 0
		.D1(regs[1]),			// data input 1
		.D2(regs[2]),			// data input 2
		.D3(regs[3]),			// data input 3
		.D4(regs[4]),			// data input 4
		.D5(regs[5]),			// data input 5
		.D6(regs[6]),			// data input 6
		.D7(regs[7]),			// data input 7
		.OutData(Bdata));		// output data
endmodule
