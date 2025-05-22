`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    PCFA2c
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// A simple 16-bit adder for the PC circuitry.
// Dependencies: 
// FA1b.v
// Revision:
// Revision 2.0 - verified
//////////////////////////////////////////////////////////////////////////////////
module PCFA2c(
	input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] Sum
    );
    //=========== Internal signal ============//
	wire [15:0] C;	// carry
	//========================================//

    //========== Full Adder Chain ============//
    genvar i;
    generate
        for (i=0; i<16; i=i+1) begin: FAchain
            if (i==0) begin
                FA1b FA1b_0(
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(Cin),
                    .Sum(Sum[i]),
                    .Cout(C[i])
                );
            end else begin
                FA1b FA1b_others(
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(C[i-1]),
                    .Sum(Sum[i]),
                    .Cout(C[i])
                );
            end
        end
    endgenerate
    //========================================//
endmodule
