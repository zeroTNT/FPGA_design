// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/RFplusALU.sch - Tue Apr  8 02:21:01 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50
module RFplusALU_RFplusALU_sch_tb();

// Inputs
	reg Reset;
	reg clk;
	reg [10:0] Ins;
	reg [15:0] WBData;
   reg [15:0] MEMData;
   reg WBRF;
   reg RBresource;
   reg WBresource;
   reg OprandB;
   reg LI;
	reg Flag;
   reg ALUop;
   reg PSW_C;

// Output
   wire [15:0] Rm;
   wire [15:0] Rd;
	wire [15:0] OutR;
	wire [15:0] LI_EXE;
	wire [15:0] Sum;
   wire N;
	wire Z;
	wire C;
 
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
		.MEMData(MEMData),
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
		.PSW_C(PSW_C),
		.ALUop(ALUop), 
		.Flag(Flag)
   );

// Initialize Inputs
	initial begin
		// reset control signals
		#150;
		@(negedge clk) Reset = 1'b1;
		repeat(3) @(negedge clk) NOP_IDEXE;
		Reset = 1'b0;

		// initial Register file data
		Ins = 11'h0000; WBData = 16'h0000; MEMData = 16'h0000;
		{WBRF, WBresource, RBresource, OprandB, LI} = 5'b0;
		{PSW_C, ALUop, Flag} = 3'b0;
		for (i = 0; i < 8; i = i+1) begin
			@(posedge clk) #3
			WBRF = 1'b1; WBresource = 1'b0; 						// Enable WB from WBdata
			RBresource = 1'b0; OprandB = 1'b0;	// Rn=Ins[4:2] is assigned to Oprand B
			{PSW_C, ALUop, Flag} = i[2:0];
			WBData = i+1; Ins[10:8] = i; Ins[7:5] = i; Ins[4:2] = i;
			@(posedge clk) #3
			{WBRF, WBresource, RBresource, OprandB, LI} = 5'b0;
			//i=000:	Rdaddr = 0, Rddata = 1, Rmaddr = 0, Rnaddr = 0, Sum = Rm + Rn			, PSW_C=0
			//i=001:	Rdaddr = 1, Rddata = 2, Rmaddr = 1, Rnaddr = 1, Sum = Rm + Rn + PSW_C,	, PSW_C=0
			//i=010:	Rdaddr = 2, Rddata = 3, Rmaddr = 2, Rnaddr = 2, Sum = Rm - Rn			, PSW_C=0
			//i=011:	Rdaddr = 3, Rddata = 4, Rmaddr = 3, Rnaddr = 3, Sum = Rm - Rn - ~PSW_C,	, PSW_C=0
			//i=100:	Rdaddr = 4, Rddata = 5, Rmaddr = 4, Rnaddr = 4, Sum = Rm + Rn			, PSW_C=1
			//i=101:	Rdaddr = 5, Rddata = 6, Rmaddr = 5, Rnaddr = 5, Sum = Rm + Rn + PSW_C,	, PSW_C=1
			//i=110:	Rdaddr = 6, Rddata = 7, Rmaddr = 6, Rnaddr = 6, Sum = Rm - Rn			, PSW_C=1
			//i=111:	Rdaddr = 7, Rddata = 8, Rmaddr = 7, Rnaddr = 7, Sum = Rm - Rn - ~PSW_C;	, PSW_C=1
		end

		//1 LHI: DataB = RF[ins[10:8]], LI_EXE = {ins[7:0], DataB}
		@(posedge clk) #3;
		Ins = {3'd1, 8'h55};	WBData = {16'h0404};
		{WBRF, WBresource, RBresource, OprandB, LI} = 5'b0x1x1;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		@(posedge clk) #3;
		//2 LLI: LI_EXE = {8'b0, ins[7:0]}
		@(posedge clk) #3;
		Ins = {3'd1, 8'h44};	WBData = {16'h0404};
		{WBRF, WBresource, RBresource, OprandB, LI} = 5'b0xxx0;
		{PSW_C, ALUop, Flag} = 3'bxxx;
		@(posedge clk) #3;
		//3 LDR: RF[Ins[10:8]] = MEMData, then read out RF[Ins[10:8]]
		Ins = {3'd1, 8'h44};	WBData = {16'h0404};	MEMData = {16'h1100};
		{WBRF, WBresource, RBresource, OprandB, LI} = 5'b111xx;
		{PSW_C, ALUop, Flag} = 3'bxxx;
      repeat(3) @(posedge clk);
		#50 $finish;
	end

	task NOP_IDEXE;
		begin
			@(posedge clk) #2;
			// equivalent to idle operation
			WBRF = 1'b0;
			Ins = 16'hxxxx; WBData = 16'hxxxx; MEMData = 16'hxxxx;
		end
	endtask
endmodule
