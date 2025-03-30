// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/RFplusALU.sch - Sun Mar 30 01:28:21 2025

`timescale 1ns / 1ps

module RFplusALU_RFplusALU_sch_tb();

// Inputs
   reg [15:0] WBData;
   reg WBRF;
   reg [15:0] Ins;
   reg clk;
   reg RBresource;
   reg WBresource;
   reg OprandB;
   reg LI;
   reg Buff_IDEXE;
   reg Reset;
   reg ALUop;
   reg Flag;
   reg PSW_C;

// Output
   wire [15:0] OutR;
   wire [15:0] IL_EXE;
   wire [15:0] Sum;
   wire C;
   wire Z;
   wire [7:0] Rm;
   wire [7:0] Rd;

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
		.OutR(OutR), 
		.IL_EXE(IL_EXE), 
		.ALUop(ALUop), 
		.Flag(Flag), 
		.PSW_C(PSW_C), 
		.Sum(Sum), 
		.C(C), 
		.Z(Z), 
		.Rm(Rm), 
		.Rd(Rd)
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
