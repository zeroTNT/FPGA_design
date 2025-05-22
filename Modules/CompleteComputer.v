`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    CompleteComputer
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// Connent the controller and datapath together.
// Dependencies: 
//
// Revision: 2.1 - verified & add Buff_OutR
//////////////////////////////////////////////////////////////////////////////////
module CompleteComputer(
    input clk,          input Rst,
    input TBorNot,      input Tb_MEMWE,         input [7:0] Tb_MEMAddr, input [15:0] Tb_MEMData,
    output [15:0] OutPC,output [15:0] OutNextPC,output [15:0] OutMEM,   output [2:0] OutPSW_NZC,
    output Done,        output [15:0] OutReg
    );
    //=============== Internal signal =============//
    wire ALUop;
    wire ALUorNot;
    wire Branch;
    wire Buff_MEMIns;
    wire Buff_PC;
    wire Buff_PSW;
    wire Flag;
    wire [1:0] Jump;
    wire LI;
    wire Buff_OutR;
    wire LIorMOV;
    wire MEMresource;
    wire OprandB;
    wire PCplus1orWB;
    wire RBresource;
    wire WBresource;
    wire WE_MEM;
    wire WE_RF;

    wire [15:8] InsM;
    wire [1:0] InsL;
    //=============================================//
    Controller C(
        .clk(clk), .Rst(Rst),
        .PSW_NZC(OutPSW_NZC[1:0]), .InsM(InsM[15:8]), .InsL(InsL[1:0]),
        .Buff_MEMIns(Buff_MEMIns), .WE_MEM(WE_MEM), .MEMresource(MEMresource), 
        .ALUorNot(ALUorNot), .LIorMOV(LIorMOV), .LI(LI),
        .WE_RF(WE_RF), .Buff_OutR(Buff_OutR), .WBresource(WBresource), .RBresource(RBresource),
        .Buff_PSW(Buff_PSW), .OprandB(OprandB), .Flag(Flag), .ALUop(ALUop),
        .Buff_PC(Buff_PC), .PCplus1orWB(PCplus1orWB), .Branch(Branch), .Jump(Jump),
        .Done(Done)
    );
    Datapath DP(
        .clk(clk), .Rst(Rst), .TBorNot(TBorNot),
        .Tb_MEMWE(Tb_MEMWE), .Tb_MEMAddr(Tb_MEMAddr[7:0]), .Tb_MEMData(Tb_MEMData[15:0]),
        .Buff_MEMIns(Buff_MEMIns), .WE_MEM(WE_MEM), .MEMresource(MEMresource), 
        .ALUorNot(ALUorNot), .LIorMOV(LIorMOV), .LI(LI),
        .WE_RF(WE_RF), .Buff_OutR(Buff_OutR), .WBresource(WBresource), .RBresource(RBresource),  
        .Buff_PSW(Buff_PSW), .oprandB(OprandB), .Flag(Flag), .ALUop(ALUop),
        .Buff_PC(Buff_PC), .PCplus1orWB(PCplus1orWB), .Branch(Branch), .Jump(Jump),
        .PSW_NZC(OutPSW_NZC[2:0]), .InsM(InsM[15:8]), .InsL(InsL[1:0]),
        .OutM(OutMEM[15:0]), .OutNextPC(OutNextPC[15:0]), .OutPC(OutPC[15:0]),
        .OutR(OutReg[15:0])
    );
endmodule
