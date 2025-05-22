`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Reg16bClkEnRp
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This module is a 16-bit register with clock enable.
// It captures the input data on the posedge of the clock,
// if the clock enable signal is high.
// It also has a reset signal that clear the output when high.
// Dependencies: 
//
// Revision: 
// Revision 1.1 - non-verified
// Additional Comments: 
// Reg series naming rule:
// 		Reg16bClk
//		En: has Enable control
//  	R(or not): reset (or not)
//  	p(or not): posedge (or negedge)
//////////////////////////////////////////////////////////////////////////////////
module Reg16bClkEnRp(
	input clk, 				// clock
	input clk_en,			// clock enable
	input rst,				// reset
	input [15:0] D,			// data input
	output reg [15:0] Q);	// data output

	// module body
	always @(posedge clk, posedge rst) begin
		if(rst) Q <= 16'b0;
		else if (clk_en) Q <= D;
	end
endmodule
