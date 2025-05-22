`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Mul8b2x1
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This module is a 8-bit 2-to-1 multiplexer.
// Dependencies: 
// Mul2x1.v
// Revision: 
// Revision 2.0 - verified
//////////////////////////////////////////////////////////////////////////////////
module Mul8b2x1(
	input addr,
	input [7:0] D0,
	input [7:0] D1,
	output [7:0] F);

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin: mux
            Mul2x1 M1(
                .addr(addr),
                .I0(D0[i]),
                .I1(D1[i]),
                .O(F[i])
            );
        end
    endgenerate
endmodule
