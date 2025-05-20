`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Datapath
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
//
// Revision: 
// Revision 0.2 - not finished, some signals in MEM circuit are not connected
// Additional Comments: 
//////////////////////////////////////////////////////////////////////////////////
module Datapath(
	// external signals
	input clk,
	input Rst,
	input TBorNot,
    input [7:0] Tb_MEMAddr,
    input [15:0] Tb_MEMData,
    input Tb_MEMWE,

	// PCcircuitry control
    input [1:0] Jump,
	input Branch,
	input Buff_PC,

	// RFplusALU control
	input WBresource,
	input PCplus1orWB,
	input RBresource,
	input WE_RF,
	input LI,
	input oprandB,
    input Flag,
	input ALUop,
    input Buff_PSW,

	// Memory control
	input MEMresource,
	input LIorMOV,
	input ALUorNot,
    input Buff_MEMIns,
	input WE_MEM,
    
    output [1:0] InsL,
    output [15:8] InsM,
    output [15:0] OutM,
    output [15:0] OutNextPC,
    output [15:0] OutPC,
    output [15:0] OutR,
    output [2:0] PSW_NZC
	);

	//=========== Internal signal ============//
	wire [15:0] nextPC;
	wire [15:0] Ins;
	wire [15:0] Rm, Rd;
	wire [15:0] PCplus1_mul;

	wire [15:0] DatafromMEM;
	
	//========================================//

	//============= PC circuit ===============//
	PCcircuitry PCcircuit(
		.Branch(Branch),
		.Jump(Jump),
		.PC(OutPC),
		.Ins(Ins[10:0]),
		.Rm(Rm),
		.Rd(Rd),
		.PCplus1_mul(PCplus1_mul),
		.nextPC(nextPC)
	);

	Reg16bClkEnRp PCbuffer(
		.clk(clk),
		.rst(Rst),
		.clk_en(Buff_PC),
		.D(nextPC),
		.Q(OutPC)
	);
	//========================================//

	//============= MEM circuit ==============//
	Mul8b2x1 PCorWB(
		.addr(MEMresource),
		.D0(PC[7:0]),
		.D1(ALU_MEM[7:0]),
		.Out(MEMaddr)
	);
	Memory256x16 InsMEM(
		.clk_n(clk),
		
		.Tbornot(TBorNot),
		.Addr_tb(Tb_MEMAddr),
		.Data_tb(Tb_MEMData),
		.WE_tb(Tb_MEMWE),

		.Addr_pc(MEMaddr),
		.Data_pc(WDR),
		.WE_pc(WE_MEM),

		.MemOut(DatafromMEM)
	);
	Reg16bClkEnp Insbuffer(
		.clk(clk),
		.clk_en(Buff_MEMIns),
		.D(DatafromMEM),
		.Q(Ins)
	);
	Reg16bClkEnp MEMDatabuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(DatafromMEM),
		.Q(MEMData)
	);
	Reg16bClkEnp MEMWBbuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(ALUorNot_Out),
		.Q(WBData1)
	);
	//========================================//
endmodule
