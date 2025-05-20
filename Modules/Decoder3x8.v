`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Decoder3x8
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
//
// Revision: 
// Revision 2.0 - verified
// Additional Comments: 
// Decoder only used once in the whole project, it's not necessary to use parameterized module.
//////////////////////////////////////////////////////////////////////////////////
module Decoder3x8(
	input [2:0] I, 		// address
	input Enable,	// enable
	output reg [7:0] O);	// data output

	integer i;
	// module body
	always @(*) begin
		if(Enable) begin
			for (i = 0; i<8 ; i=i+1) begin
				if (I == i) O[i] = 1'b1;
				else O[i] = 1'b0;
			end
		end
		else O = 8'b00000000;
	end
endmodule
