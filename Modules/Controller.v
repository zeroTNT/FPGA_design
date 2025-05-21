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
// 16-bit ripple carry adder
// Dependencies: 
//
// Revision:
// Revision 0.1 - not verified
//////////////////////////////////////////////////////////////////////////////////
module TimingGenerator(
    input clk,
    input Rst,
    input [1:0] PSW_NZC,
    input [15:8] InsM,
    input [1:0] InsL,

    output ALUop,
    output ALUorNot,
    output Branch,
    output Buff_MEMIns,
    output Buff_PC,
    output Buff_PSW,
    output Done,
    output Flag,
    output [1:0] Jump,
    output LI,
    output LIorMOV,
    output MEMresource,
    output OprandB,
    output PCplus1orWB,
    output RBresource,
    output WBresource,
    output WE_MEM,
    output WE_RF
    );
    //=============== Internal signal =============//
    wire [2:0] Cnt;
    wire clk_done;
    assign clk_done= clk & (~Done);
    //=============================================//
    TimingGenerator TG(
        .clk(clk_done),
        .Rst(Rst),
        .LastStage(Buff_PC),
        .Cnt(Cnt)
    );
    InsDecoder ID(
        .Rst(Rst),
        .InsM(InsM),
        .InsL(InsL),
        .Cnt(Cnt),
        .PSW_NZC(PSW_NZC),

        .Branch(Branch),
        .Jump(Jump),
        .Buff_PC(Buff_PC),
        .MEMresource(MEMresource),
        .ALUorNot(ALUorNot),
        .LIorMOV(LIorMOV),
        .WE_MEM(WE_MEM),
        .Buff_MEMIns(Buff_MEMIns),
        .OprandB(OprandB),
        .RBresource(RBresource),
        .WBresource(WBresource),
        .LI(LI),
        .PCplus1orWB(PCplus1orWB),
        .WE_RF(WE_RF),
        .Flag(Flag),
        .ALUop(ALUop),
        .Buff_PSW(Buff_PSW),
        .Done(Done)
    );
endmodule
