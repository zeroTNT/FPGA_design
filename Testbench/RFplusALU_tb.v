// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/RFplusALU.sch - Sun Mar 30 08:29:19 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 80
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
   	wire [15:0] LI_EXE;
	wire [15:0] OutR;
   	wire [15:0] Sum;
   	wire C;
   	wire Z;
   	wire N;

	wire [15:0] ConcatedLHI;
	wire [15:0] MulLI;

// Bidirs

// clock
	integer i;
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Instantiate the UUT
	RFplusALU UUT (
		.ConcatedLHI(ConcatedLHI),
		.MulLI(MulLI),

		.clk(clk), 
		.Reset(Reset), 
		.Ins(Ins), 
		.WBData(WBData), 
		// RFplusALU ID stage output data
		.Rm(Rm), 
		.Rd(Rd),
		// RFplusALU EXE stage output data
		.OutR(OutR), 
		.LI_EXE(LI_EXE), 
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
		.Flag(Flag)
   );

// Initialize Inputs
	initial begin
		// initial Register file data
		#150;
		Ins = 16'h0000; WBData = 16'h0000;
		for (i = 0; i < 8; i = i+1) begin
			@(posedge clk) Buff_IDEXE = 1'b0; WBRF = 1'b1; WBresource = 1'b1; WBData = i; Ins[10:8] = i;
		end

		// reset control signals
		@(negedge clk) Reset = 1'b1;
		repeat(3) @(negedge clk) begin
		Ins = 16'hxxxx; WBData = 16'hxxxx; WBRF = 1'b0; Buff_IDEXE = 1'b0;
		end
		Reset = 1'b0;
		// only verify possible control signals pattern with fixed input data
		//1 LHI in ID stage: DataB = RF[ins[10:8]], LI_EXE = {ins[7:0], DataB}
		@(posedge clk)
		Ins = $random();	WBData = $random();
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x1x11;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//2 LHI in WB stage: RF[ins[10:8]] = LI_EXE
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//3 LLI in ID stage: LI_EXE = {8'b0, ins[7:0]}
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxx01;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//4 LLI in WB stage: RF[ins[10:8]] = LI_EXE
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//5 LDR_RI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//6 LDR_RI in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		//7 LDR_RI in WB stage: RF[ins[10:8]] = MEM[Sum]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b10xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//8 LDR_RR in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//9 LDR_RR in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		//10 LDR_RR in WB stage: RF[ins[10:8]] = MEM[Sum]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b10xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//11 STR_RI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//12 STR_RI in EXE stage: Sum = ALUinA + ALUinB, DataB = RF[ins[10:8]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x1xx0;
		{PSW_C, ALUop, Flag} = 3'b100;

		//13 STR_RR in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//14 ADD in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx0x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//15 ADD in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		//16 ADD in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//17 ADC in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//18 ADC in EXE stage: Sum = ALUinA + ALUinB + PSW_C
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b101;
		//19 ADC in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//20 SUB in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//21 SUB in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;
		//22 SUB in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//23 SBB in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//24 SBB in EXE stage: Sum = ALUinA - ALUinB - PSW_C
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b011;
		//25 SBB in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//26 CMP in ID stage: ALUinA = RF[ins[7:5]], ALUinB = RF[ins[4:2]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0x00x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//27 CMP in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;

		//28 ADDI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//29 ADDI in EXE stage: Sum = ALUinA + ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b100;
		//30 ADDI in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//31 SUBI in ID stage: ALUinA = RF[ins[7:5]], ALUinB = ins[4:0]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xx1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//32 SUBI in EXE stage: Sum = ALUinA - ALUinB
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx0;
		{PSW_C, ALUop, Flag} = 3'b010;
		//33 SUBI in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//34 MOV in ID stage: ALUinA = RF[ins[7:5]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//35 MOV in WB stage: RF[ins[10:8]] = Sum
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;

		//36 JAL_Rlabel in ID stage: RF[ins[10:8]] = PC+1
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//37 JAL_RR in ID stage: RF[ins[10:8]] = PC+1, PC = RF[ins[7:5]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b11xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//38 JR in ID stage: PC = RF[ins[10:8]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b111xx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		//39 OutR in ID stage: ALUinA = RF[ins[7:5]]
		@(posedge clk)
		{WBRF, WBresource, RBresource, OprandB, LI, Buff_IDEXE} = 6'b0xxxx1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		#50 $finish;
	end
endmodule
