`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    FA16b2c
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// 16-bit ripple carry adder
// Dependencies: 
// FA1b.v
// Revision: 
// Revision 2.0 - verified
//////////////////////////////////////////////////////////////////////////////////
module FA16b2c(
	input [15:0] A,
    input [15:0] B,
    input Flag,
    input PSW_C,
    input ALUop,
    output [15:0] Sum,
    output Cout,
    output Z,
    output N);
    
    wire [15:0] oprandB;
    wire Cin;

    Mul2x1 M1(
        .addr(Flag),
        .I0(ALUop),
        .I1(PSW_C),
        .O(Cin)
    );
    assign oprandB = {16{ALUop}} ^ B;
    FA16b FA16b_inst(
        .A(A),
        .B(oprandB),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
    assign Z = ~(|Sum);
    assign N = Sum[15];
endmodule
