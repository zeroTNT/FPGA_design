`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    TimingGenerator
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This module is a timing generator that counts up to 7 (3 bits) and resets when
// LastStage or Rst is high. The count is used to control the timing of operations
// for executing a instruction.
// Dependencies: 
//
// Revision:
// Revision 2.0 - verified
//////////////////////////////////////////////////////////////////////////////////
module TimingGenerator(
    input clk,
    input Rst,
    input LastStage,
    output [2:0] Cnt
    );
    reg [2:0] Cnt;
    wire OR_LastStageRst;
    assign OR_LastStageRst = LastStage | Rst;
    always @(posedge clk) begin
        if(OR_LastStageRst) Cnt <= 3'b000;
        else begin
            Cnt <= Cnt + 1;
        end
    end
endmodule
