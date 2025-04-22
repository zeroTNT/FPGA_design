`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    decoder3x8
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
// Decoder only used once in the whole project, it's not necessary to use
// parameterized module.
//////////////////////////////////////////////////////////////////////////////////
module decoder3x8(
	input [2:0] addr, 		// address
	output reg [7:0] F);	// data output
	
endmodule
