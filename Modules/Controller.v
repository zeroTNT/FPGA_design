`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Controller
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This module is the controller of the datapath.
// It generates control signals for the datapath & record the current stage of PC.
// Dependencies: 
// InsDecoder.v, TimingGenerator.v
// Revision: 2.2 - verified & revise the comment
//////////////////////////////////////////////////////////////////////////////////
module Controller(
    input clk,          input Rst,
    input [15:8] InsM,  input [1:0] InsL,   input [1:0] PSW_NZC,
    output Buff_PC,     output PCplus1orWB, output [1:0] Jump,  output Branch,
    output Buff_MEMIns, output MEMresource, output WE_MEM,
    output WBresource,  output RBresource,  output WE_RF,
    output Buff_OutR,   output Buff_PSW,    output OprandB,     output Flag, output ALUop, 
    output LIorMOV,     output ALUorNot,    output LI,
    output Done
    );
    //=============== Internal signal =============//
    wire [2:0] Cnt;
    wire clk_done;
    assign clk_done= clk & (~Done);
    //=============================================//
    TimingGenerator TG(
        .clk(clk_done), .Rst(Rst), .LastStage(Buff_PC),
        .Cnt(Cnt)
    );
    InsDecoder ID(
        .Rst(Rst),
        .InsM(InsM), .InsL(InsL),
        .Cnt(Cnt), .PSW_NZC(PSW_NZC),
        .Buff_PC(Buff_PC), .PCplus1orWB(PCplus1orWB), .Branch(Branch), .Jump(Jump), 
        .WE_MEM(WE_MEM), .MEMresource(MEMresource), .Buff_MEMIns(Buff_MEMIns),
        .WE_RF(WE_RF), .RBresource(RBresource), .WBresource(WBresource),
        .Buff_OutR(Buff_OutR), .Buff_PSW(Buff_PSW), .Flag(Flag), .ALUop(ALUop), .OprandB(OprandB),
        .ALUorNot(ALUorNot), .LI(LI), .LIorMOV(LIorMOV),
        .Done(Done)
    );
endmodule
