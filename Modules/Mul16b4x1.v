`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Mul16b4x1
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
// Mul2x1.v
// Revision: 
// Revision 2.0 - verified
// Additional Comments: 
//	This multiplexer is used to select one of the 16-bit inputs within 4 inputs.
//	
//////////////////////////////////////////////////////////////////////////////////
module Mul16b4x1(
	input [1:0] addr,
	input [15:0] D0,
	input [15:0] D1,
    input [15:0] D2,
    input [15:0] D3,
	output reg [15:0] F);
    always @(*) begin
        case (addr)
            2'b00: F = D0;
            2'b01: F = D1;
            2'b10: F = D2;
            2'b11: F = D3;
            default: F = 16'b0; // Default case to avoid latches
        endcase
    end
endmodule
