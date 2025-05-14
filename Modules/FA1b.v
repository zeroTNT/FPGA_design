`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    FA1b
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// 1-bit full adder
// Dependencies: 
//
// Revision: 
//////////////////////////////////////////////////////////////////////////////////
module FA1b(
	input A,
    input B,
    input Cin,
    output Sum,
    output Cout);
    assign {Cout, Sum} = A + B + Cin;
endmodule
