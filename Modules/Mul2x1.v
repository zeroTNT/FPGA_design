`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Mul2x1
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
//	This multiplexer is used to select one of the 1-bit inputs within 1 input.
//	
//////////////////////////////////////////////////////////////////////////////////
module Mul2x1(
    input addr,
    input I0,
    input I1,
    output O);
	assign O = (addr) ? I1 : I0;
endmodule
