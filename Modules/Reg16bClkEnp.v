`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Reg16bClkEnp
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
// Reg series naming rule:
// 		Clkf: falling edge trigger(f)
//  	En(or not): has Enable control or not.
//////////////////////////////////////////////////////////////////////////////////
module Reg16bClkEnp(
	input clk, 		// clock
	input clk_en,	// clock enable
	input [15:0] D,	// data input
	output reg [15:0] Q);	// data output

	// module body
	always @(negedge clk) begin
		if (clk_en) Q <= D;
		else Q <= Q;
	end
endmodule
