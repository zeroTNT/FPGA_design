// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/RFplusALU.sch - Sun Mar 30 08:29:19 2025

`timescale 1ns / 1ps

module RFplusALU_RFplusALU_sch_tb();

// Inputs
	reg clk;
	reg Reset;
	// RFplusALU data
	reg [15:0] Ins;
   	reg [15:0] WBData;
	// ID control signals
	reg WBRF;
   	reg WBresource;
	reg RBresource;
   	reg OprandB;
   	reg LI;
   	reg Buff_IDEXE;
	// EXE control signals
   	reg ALUop;
   	reg PSW_C;
	reg Flag;

// Output
	// ID output data
	wire [7:0] Rm;
   	wire [7:0] Rd;
	// EXE output data
   	wire [15:0] IL_EXE;
	wire [15:0] OutR;
   	wire [15:0] Sum;
   	wire C;
   	wire Z;
   	wire N;

// Bidirs

// clock
	integer i;
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Instantiate the UUT
	RFplusALU UUT (
		.clk(clk), 
		.Reset(Reset), 
		.Ins(Ins), 
		.WBData(WBData), 
		.OutR(OutR), 
		// RFplusALU ID stage output data
		.Rm(Rm), 
		.Rd(Rd),
		// RFplusALU EXE stage output data
		.IL_EXE(IL_EXE), 
		.Sum(Sum), 
		.C(C), 
		.Z(Z), 
		.N(N),
		// control signals
		.WBRF(WBRF), 
		.RBresource(RBresource), 
		.WBresource(WBresource), 
		.OprandB(OprandB), 
		.LI(LI), 
		.Buff_IDEXE(Buff_IDEXE), 
		.PSW_C(PSW_C),
		.ALUop(ALUop), 
		.Flag(Flag), 
   );

// Initialize Inputs
	initial begin
		// reset control signals
		Reset = 1'b1;
		Ins = 16'hxxxx; WBData = 16'hxxxx; WBRF = 1'bx; RBresource = 1'bx; WBresource = 1'bx; OprandB = 1'bx; LI = 1'bx; Buff_IDEXE = 1'bx; ALUop = 1'bx; Flag = 1'bx; PSW_C = 1'bx;
		#150;
		@(negedge clk) #3 Reset = 1'b0;

		// initial Register file data
		Ins = 16'h0000; WBData = 16'h0000;
		for (i = 0; i < 8; i = i+1) begin
			@(posedge clk) Buff_IDEXE = 1'b0, WBRF = 1'b1; WBresource = 1'b1; WBData = $random();
		end
		
		// only verify possible control signals pattern with fixed input data
		Ins = $random();	WBData = $random();

		// LHI in ID stage: DataB = RF[ins[10:8]], LI_EXE = {ins[7:0], DataB}
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x1x01;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// LHI in WB stage: RF[ins[10:8]] = LI_EXE
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// LLI in ID stage: LI_EXE = {8'b0, ins[7:0]}
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxx11;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// LLI in WB stage: RF[ins[10:8]] = LI_EXE
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// LDR_RI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// LDR_RI in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		// LDR_RI in WB stage: RF[ins[10:8]] = MEM[Sum]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b10xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// LDR_RR in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// LDR_RR in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		// LDR_RR in WB stage: RF[ins[10:8]] = MEM[Sum]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b10xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// STR_RI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// STR_RI in EXE stage: Sum = ALUinA + ALUinB, DataB = RF[ins[10:8]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x1xx0;
		{PSW_C, ALUop, Flag} = 3'b100;

		// STR_RR in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// ADD in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx0x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// ADD in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		// ADD in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// ADC in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// ADC in EXE stage: Sum = ALUinA + ALUinB + PSW_C
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b101;
		// ADC in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// SUB in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// SUB in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;
		// SUB in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// SBB in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// SBB in EXE stage: Sum = ALUinA - ALUinB - PSW_C
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b011;
		// SBB in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// CMP in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// CMP in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;

		// ADDI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// ADDI in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		// ADDI in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// SUBI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// SUBI in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;
		// SUBI in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// MOV in ID stage: ALUinA = RF[ins[7:5]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// MOV in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		// JAL_Rlabel in ID stage: RF[ins[10:8]] = PC
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		// JAL_RR in ID stage: ALUinA = PC, ALUinB = RF[ins[4:2]]
		// JR in ID stage: ALUinA = PC, ALUinB = RF[ins[7:5]]
		// OutR in ID stage: ALUinA = RF[ins[7:5]]
		#50 $finish;
	end
endmodule
