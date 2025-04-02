// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Datapath.sch - Wed Apr  2 12:25:57 2025

`timescale 1ns / 1ps
`CYCLE_TIME = 50
module Datapath_Datapath_sch_tb();

// Inputs
   reg clk;
   reg Rst;
	reg Buff_PC;
	reg Buff_MEMIns;
	reg Buff_PSW;

	reg WE_MEM;
	reg MEMresource;
   
	reg RBresource;
	reg WE_RF;
   reg WBresource;
	reg PCplus1orWB;
   reg oprandB;
	reg LI;

	reg ALUop;
   reg Flag;
   
   reg LIorMOV;
   reg ALUorNot;
   
	reg Branch;
   reg [1:0] Jump;

   reg TBorNot;
	reg MEM_WE_tb;
	reg [7:0] MEMAddr_tb;
	reg [15:0] MEMData_tb;


// Output
   wire [15:0] OutR;
   wire [2:0] PSW_NZC;
   wire [4:0] opcode;
   wire [1:0] ALUopcode;

// Clock
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Reg, Net
	reg [5:0] MEM_control;
	reg [6:0] RF_control;
	reg [3:0] ALU_control;
	reg [2:0] PC_control;
	always @(*) begin
		{ALUorNot, LIorMOV, MEMresource, WE_MEM, Buff_MEMIns} = MEM_control;
		{WBresource, RBresource, oprandB, LI, PCplus1orWB, WE_RF} = RF_control;
		{Flag, ALUop, Buff_PSW} = ALU_control;
		{Jump[1:0], Branch} = PC_control;
	end
// Instantiate the UUT
   Datapath UUT (
		.OutR(OutR), 
		.Buff_PSW(Buff_PSW), 
		.clk(clk), 
		.Buff_PC(Buff_PC), 
		.MEMresource(MEMresource), 
		.ALUop(ALUop), 
		.Flag(Flag), 
		.RBresource(RBresource), 
		.WBresource(WBresource), 
		.oprandB(oprandB), 
		.LI(LI), 
		.Branch(Branch), 
		.Jump(Jump), 
		.LIorMOV(LIorMOV), 
		.ALUorNot(ALUorNot), 
		.WE_RF(WE_RF), 
		.WE_MEM(WE_MEM), 
		.PSW_NZC(PSW_NZC), 
		.MEM_WE_tb(MEM_WE_tb), 
		.MEMAddr_tb(MEMAddr_tb), 
		.MEMData_tb(MEMData_tb), 
		.TBorNot(TBorNot), 
		.Buff_MEMIns(Buff_MEMIns), 
		.PCplus1orWB(PCplus1orWB), 
		.opcode(opcode), 
		.ALUopcode(ALUopcode)
   );
// Initialize Inputs

// operation
	task Writemem;
		input [15:0] addr, data;
		@(posedge clk) #3 begin
		TBorNot = 1'b1;
		MEM_WE_tb = 1'b1; MEMAddr_tb = addr;
		MEMData_tb = data;
		end
	endtask
	task Start_Process;
		Rst = 1'b0;
		repeat (3) @(posedge clk) #3 begin
			Rst = 1'b1;
			WE_MEM = 1'b0; WE_RF = 1'b0;
			Buff_PC = 1'b0; Buff_MEMIns = 1'b0; Buff_PSW = 1'b0;
		end
		Rst = 1'b0;
		Buff_PC = 1'b1; Buff_MEMIns = 1'b1; Buff_PSW = 1'b0;
	endtask
	task Op_LHI;
		@(posedge clk) #3 MEM_control = 5'bxx001; Buff_PC = 1'b0;
		@(posedge clk) #3 RF_control = 6'bx1x1x0; PC_control = 3'b000;
		@(posedge clk) #3 ALU_control = 3'bxx0;
		@(posedge clk) #3 MEM_control = 5'b10x00;
		@(posedge clk) #3 RF_control = 6'b0xxx11; Buff_PC = 1'b1;
	endtask
	task Op_HLT;
		@(posedge clk) #3 MEM_control = 5'bxx0011; Buff_PC = 1'b0;
		@(posedge clk) #3 RF_control = 6'bxxxxx00; PC_control = 3'b000;
		@(posedge clk) #3; $display("Operation HLT accepted, PC stop counting.")
	endtask
endmodule
