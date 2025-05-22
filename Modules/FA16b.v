`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    FA16b
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// 16-bit ripple carry adder consists of 16 1-bit full adders.
// Dependencies: 
// FA1b.v
// Revision:
// Revision 2.0 - verified 
//////////////////////////////////////////////////////////////////////////////////
module FA16b(
	input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] Sum,
    output Cout);
    wire [15:0] C;
    genvar i;
    generate
        for (i=0; i<16; i=i+1) begin: FA
            if (i==0) begin
                FA1b FA1b_inst(
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(Cin),
                    .Sum(Sum[i]),
                    .Cout(C[i])
                );
            end else begin
                FA1b FA1b_inst(
                    .A(A[i]),
                    .B(B[i]),
                    .Cin(C[i-1]),
                    .Sum(Sum[i]),
                    .Cout(C[i])
                );
            end
        end
    endgenerate
    assign Cout = C[15];
endmodule
