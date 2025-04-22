`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    mulLbNx1
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
//
//////////////////////////////////////////////////////////////////////////////////
module mulLbNx1
	#(	parameter L = 1,  		// # of inputs
		parameter N = 2,  		// # of addr bits (with 2^N inputs)
		parameter M = 4)( 		// # of output bits
		input [N-1:0] addr, 		// address
		input [M*(L-1):0] D,    // data input with format: {L'bx, L'bx, ..., L'bx}
		output reg [L-1:0] F);	// data output

	// rearrange D to 2D array
	wire [L-1:0] D_temp [0:M-1];
	genvar i;
	generate
	   for (i = 0; i < M; i = i + 1) begin: genD
	   	assign D_temp[i] = D[((i+1)*L)-1 +: L];
	   end
	endgenerate

	integer j;
	// module body
	always @(*) begin
		F = 0;
		for (j = 0; j < M; j = j + 1) begin
			if (addr == j) F = D_temp[j];
		end
	end
endmodule
