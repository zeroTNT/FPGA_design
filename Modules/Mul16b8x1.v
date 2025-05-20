`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Mul16b8x1
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
//	This multiplexer is used to select one of the 16-bit inputs within 3 inputs.
//	
//////////////////////////////////////////////////////////////////////////////////
module Mul16b8x1(
	input [2:0] addr,
	input [15:0] D0,
	input [15:0] D1,
	input [15:0] D2,
	input [15:0] D3,
	input [15:0] D4,
	input [15:0] D5,
	input [15:0] D6,
	input [15:0] D7,
	output reg [15:0] OutData);

    always @(*) begin
    	case (addr)
            3'b000: OutData = D0;
            3'b001: OutData = D1;
            3'b010: OutData = D2;
            3'b011: OutData = D3;
            3'b100: OutData = D4;
            3'b101: OutData = D5;
            3'b110: OutData = D6;
            3'b111: OutData = D7;
            default: OutData = 16'bx;
        endcase
    end
endmodule
