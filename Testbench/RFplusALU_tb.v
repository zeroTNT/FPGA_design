// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/RFplusALU.sch - Sun Mar 30 08:29:19 2025

`timescale 1ns / 1ps

module RFplusALU_RFplusALU_sch_tb();

// Inputs
	reg clk;
	reg Reset;
   reg [15:0] WBData;
   reg WBRF;
   reg [15:0] Ins;
   reg RBresource;
   reg WBresource;
   reg OprandB;
   reg LI;
   reg Buff_IDEXE;
   reg ALUop;
   reg Flag;
   reg PSW_C;

// Output
   wire [15:0] IL_EXE;
   wire [15:0] Sum;
   wire C;
   wire Z;
   wire [7:0] Rm;
   wire [7:0] Rd;
   wire N;
   wire [15:0] OutR;

// Bidirs

// Instantiate the UUT
   RFplusALU UUT (
		.WBData(WBData), 
		.WBRF(WBRF), 
		.Ins(Ins), 
		.clk(clk), 
		.RBresource(RBresource), 
		.WBresource(WBresource), 
		.OprandB(OprandB), 
		.LI(LI), 
		.Buff_IDEXE(Buff_IDEXE), 
		.Reset(Reset), 
		.IL_EXE(IL_EXE), 
		.ALUop(ALUop), 
		.Flag(Flag), 
		.PSW_C(PSW_C), 
		.Sum(Sum), 
		.C(C), 
		.Z(Z), 
		.Rm(Rm), 
		.Rd(Rd), 
		.N(N), 
		.OutR(OutR)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		WBData = 0;
		WBRF = 0;
		Ins = 0;
		clk = 0;
		RBresource = 0;
		WBresource = 0;
		OprandB = 0;
		LI = 0;
		Buff_IDEXE = 0;
		Reset = 0;
		ALUop = 0;
		Flag = 0;
		PSW_C = 0;
   `endif
endmodule
