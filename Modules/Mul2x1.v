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
// This module is a 1-bit 2-to-1 multiplexer.
// It selects one of the two 1-bit inputs based on the address input.
// Dependencies: 
//
// Revision: 
// Revision 2.0 - verified
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module Mul2x1(
    input addr,
    input I0,
    input I1,
    output O);
	assign O = (addr) ? I1 : I0;
endmodule
