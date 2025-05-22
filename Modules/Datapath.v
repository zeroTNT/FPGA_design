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
// This module is the datapath of the processor.
// It contains the PC circuit module, RF & ALU circuit module, MEM circuit module,
// and other buffers/multiplexers.
// Dependencies: 
// PCcircuitry.v, Mul16b2x1.v, Mul8b2x1.v, Memory256x16.v, RFplusALU.v
// Reg16bClkEnp.v, Reg16bClkEnRp.v
//
// Revision: 
// Revision 2.2 - verified & revise the comment
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
	input Buff_OutR,

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
	wire [15:0] PCplus1_mul;
	
	wire [15:0] LIorMOV_Data;
	wire [15:0] ALUorNot_Out;
	wire [7:0] Addr_pc;
	wire [15:0] Ins;
	wire [15:0] MEMData;
	wire [15:0] WBData1;

	wire [15:0] WBDataMux;
	wire [15:0] Rm, Rd;
	wire N, Z, C;
	wire [15:0] Sum;
	wire [15:0] LI_EXE;
	wire [15:0] OutR_EXE;
	reg [2:0] PSW_NZC;
	wire [15:0] LI_MEM;
	wire [15:0] OutR_MEM;
	wire [15:0] WDR;

	wire [15:0] ALU_MEM;
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
		.nextPC(OutNextPC)
	);

	Reg16bClkEnRp PCbuffer(
		.clk(clk),
		.rst(Rst),
		.clk_en(Buff_PC),
		.D(OutNextPC),
		.Q(OutPC)
	);
	//========================================//

	//============= MEM circuit ==============//
	Mul16b2x1 Mux_LIorMOV(
		.addr(LIorMOV),
		.D0(LI_MEM),
		.D1(OutR_MEM),
		.F(LIorMOV_Data)
	);
	Mul16b2x1 Mux_ALUorNot(
		.addr(ALUorNot),
		.D0(ALU_MEM),
		.D1(LIorMOV_Data),
		.F(ALUorNot_Out)
	);
	Mul8b2x1 PCorWB(
		.addr(MEMresource),
		.D0(OutPC[7:0]),
		.D1(ALU_MEM[7:0]),
		.F(Addr_pc)
	);
	Memory256x16 MEM(
		.clk_n(clk),
		
		.Tbornot(TBorNot),
		.Addr_tb(Tb_MEMAddr),
		.Data_tb(Tb_MEMData),
		.WE_tb(Tb_MEMWE),

		.Addr_pc(Addr_pc),
		.Data_pc(WDR),
		.WE_pc(WE_MEM),

		.MemOut(OutM)
	);
	Reg16bClkEnp Insbuffer(
		.clk(clk),
		.clk_en(Buff_MEMIns),
		.D(OutM),
		.Q(Ins)
	);
	assign InsL = Ins[1:0];
	assign InsM = Ins[15:8];
	Reg16bClkEnp MEMDatabuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(OutM),
		.Q(MEMData)
	);
	Reg16bClkEnp MEMWBbuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(ALUorNot_Out),
		.Q(WBData1)
	);
	//========================================//
	//========== RF & ALU circuit ============//
	Mul16b2x1 Mux_WBData(
		.addr(PCplus1orWB),
		.D0(PCplus1_mul),
		.D1(WBData1),
		.F(WBDataMux)
	);
	RFplusALU RFplusALU_module(
		.clk(clk),
		.Reset(Rst),

		.WBRF(WE_RF),
		.WBData(WBDataMux),
		.MEMData(MEMData),
		.Ins(Ins[10:0]),

		.LI(LI),
		.Buff_OutR(Buff_OutR),
		.OprandB(oprandB),
		.WBresource(WBresource),
		.RBresource(RBresource),
		.PSW_C(PSW_NZC[0]),
		.Flag(Flag),
		.ALUop(ALUop),
		.Rm(Rm),
		.Rd(Rd),
		.Sum(Sum),
		.LI_EXE(LI_EXE),
		.N(N),
		.Z(Z),
		.C(C),
		.OutR_EXE(OutR_EXE),
		.OutR(OutR)
	);
	always @(posedge clk, posedge Rst) begin
		if(Rst) PSW_NZC <= 3'b000;
		else if(Buff_PSW) begin
			PSW_NZC[2:0] <= {N, Z, C};
		end
	end
	Reg16bClkEnp ALUbuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(Sum),
		.Q(ALU_MEM)
	);
	Reg16bClkEnp LIbuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(LI_EXE),
		.Q(LI_MEM)
	);
	Reg16bClkEnp OutRBuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(OutR_EXE),
		.Q(OutR_MEM)
	);
	Reg16bClkEnp WDRBuffer(
		.clk(clk),
		.clk_en(1'b1),
		.D(Rd),
		.Q(WDR)
	);
	//========================================//
endmodule
