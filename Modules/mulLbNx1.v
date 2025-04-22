`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    mulLbN2M
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mulLbNx1
    #(parameter L = 1,  // # of data bits
      parameter N = 2,  // # of addr bits (with 2^N inputs)
      parameter M = 1)( // # of output bits
    input [N-1:0] addr,
    input [L-1:0] D,
    output [L-1:0] F
    );


endmodule
