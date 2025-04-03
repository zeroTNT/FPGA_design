// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Datapath.sch - Wed Apr  2 12:25:57 2025

`timescale 1ns / 1ps
`define CYCLE_TIME  50.0
module Datapath_Datapath_sch_tb();

// Inputs
	reg Rst;
   reg clk;
	reg Buff_PC;

	reg ALUorNot;
	reg LIorMOV;
	reg MEMresource;
	reg WE_MEM;
	reg Buff_MEMIns;

	reg WBresource;
	reg RBresource;
   reg oprandB;
	reg LI;
	reg PCplus1orWB;
	reg WE_RF;

	reg Branch;
   reg [1:0] Jump;

	reg ALUop;
   reg Flag;
	reg Buff_PSW;

   reg TBorNot;
	reg Tb_MEMWE;
	reg [7:0] Tb_MEMAddr;
	reg [15:0] Tb_MEMData;

// Output
   wire [15:0] OutR;
   wire [2:0] PSW_NZC;
   wire [4:0] opcode;
   wire [1:0] ALUopcode;
	
	wire [15:0] OutM; // test out
	wire [15:0] OutNextPC; // test out
	wire [15:0] OutPC; // test out

// Clock
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Reg, Net, Variable
	integer i;
	reg done;
	reg [5:0] MEM_control;
	reg [6:0] RF_control;
	reg [3:0] ALU_control;
	reg [3:0] PC_control;
	always @(*) begin
		{ALUorNot, LIorMOV, MEMresource, WE_MEM, Buff_MEMIns} = MEM_control;
		{WBresource, RBresource, oprandB, LI, PCplus1orWB, WE_RF} = RF_control;
		{Flag, ALUop, Buff_PSW} = ALU_control;
		{Branch, Jump[1:0], Buff_PC} = PC_control;
	end
// Instantiate the UUT
   Datapath UUT (
		.OutR(OutR), 
		.Buff_PSW(Buff_PSW), 
		.clk(clk),
		.Rst(Rst), 
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
		.Tb_MEMWE(Tb_MEMWE), 
		.Tb_MEMAddr(Tb_MEMAddr), 
		.Tb_MEMData(Tb_MEMData), 
		.TBorNot(TBorNot), 
		.Buff_MEMIns(Buff_MEMIns), 
		.PCplus1orWB(PCplus1orWB), 
		.opcode(opcode), 
		.ALUopcode(ALUopcode),

		.OutM(OutM),
		.OutPC(OutPC),
		.OutNextPC(OutNextPC)
   );
// Initialize Inputs
	initial begin
		done = 1'b0; // simulate controller signal "done"
		// Reset specific Reg value & Restart PC
		ResetProcess;
		// Store some data & operation in memory manually
		// The opcode is meanless in this testbench, but Reg/Imm is need.
		// ins
		TBorNot = 1'b1; Buff_PC = 1'b1;
		WriteMEM(16'h0000, {5'b0, 3'd0, 8'h0A}); //R0 = A = 10
		WriteMEM(16'h0001, {5'b0, 3'd1, 8'h05}); //R1 = 5
		WriteMEM(16'h0002, {5'b0, 3'd0, 3'd0, 3'd0, 2'b0}); //OutR R0
		WriteMEM(16'h0003, {5'b0, 3'd0, 3'd1, 3'd0, 2'b0}); //OutR R1
		WriteMEM(16'h0004, {5'b0, 3'd0, 3'd1, 3'd0, 2'b0}); //CMP R1, R0
		WriteMEM(16'h0005, {5'b0, 3'd0, 3'd1, 3'd0, 2'b0}); //OutR R1
		WriteMEM(16'h0006, {5'b0, 9'b0, 2'b01}); //HLT
		// 0126354
		// data
		WriteMEM(16'h00F0, 16'h007C);
		// Ensure data wrote into memory successully
		for (i = 0; i < 16; i = i+1) begin
			@(posedge clk) #3 begin
				Tb_MEMWE = 1'b0; Tb_MEMAddr = i;
			end
		end
		TBorNot = 1'b0; Buff_PC = 1'b0;
		ResetProcess; 
		// Simulate control signals send from Controller
		// Task is ordered according to operation in reality
		Op_LLI;
		Op_LLI;
		Op_OutR;
		Op_OutR;
		Op_CMP;
		Op_OutR;
		Op_HLT;
		wait(done);
		$finish;
	end
	initial #10000 $finish;
// operation
	task WriteMEM;
		input [15:0] addr, data;
		begin
			@(posedge clk) #3 begin
				Tb_MEMWE = 1'b1; Tb_MEMAddr = addr; Tb_MEMData = data;
			end
		end
	endtask
	task ResetProcess;
		begin
			Rst = 1'b0;
			WE_MEM = 1'b0; WE_RF = 1'b0;
			Buff_PC = 1'b0; Branch = 1'b0; Jump = 2'b0;
			MEMresource = 1'b0; Buff_MEMIns = 1'b0;
			Buff_PSW = 1'b0;
			repeat (3) @(posedge clk) #3 begin
				Rst = 1'b1;
			end
			Rst = 1'b0;
		end
	endtask
	task Op_LHI;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx1x1x0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b10x00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_LLI;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxx0x0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b10x00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_LDRri;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxx1xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b000; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxx100; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b1xxxx1;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_LDRrr;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b000; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxx100; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b1xxxx1;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_STRri;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxx1xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx1xxx0;  ALU_control = 3'b000; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxx110; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_STRrr;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx1xxx0;  ALU_control = 3'b000; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxx110; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_ADD;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b001; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_ADC;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b101; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_SUB;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b011; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_SBB;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b111; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_CMP;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx00xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b011; PC_control = 4'b0001;
		end
	endtask
	task Op_ADDI;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxx1xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b001; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_SUBI;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxx1xx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'b011; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b0xx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_MOV;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'b11x00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx11;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_BCC;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {(~PSW_NZC[0]), 2'b0, 1'b1};
		end
	endtask
	task Op_BCS;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {(PSW_NZC[0]), 2'b0, 1'b1};
		end
	endtask
	task Op_BNE;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {(~PSW_NZC[1]), 2'b0, 1'b1};
		end
	endtask
	task Op_BEQ;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {(PSW_NZC[1]), 2'b0, 1'b1};
		end
	endtask
	task Op_BAL;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {1'b1, 2'b0, 1'b1};
		end
	endtask
	task Op_JMP;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = {1'bx, 2'b01, 1'b1};
		end
	endtask
	task Op_JALrl;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx01;  ALU_control = 3'bxx0; PC_control = {1'b1, 2'b0, 1'b1};
		end
	endtask
	task Op_JALrr;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'b0xxx01;  ALU_control = 3'bxx0; PC_control = {1'bx, 2'b10, 1'b1};
		end
	endtask
	task Op_JR;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bx1xxx0;  ALU_control = 3'bxx0; PC_control = {1'bx, 2'b11, 1'b1};
		end
	endtask
	task Op_OutR;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0001;
		end
	endtask
	task Op_HLT;
		begin
			@(posedge clk) #3 MEM_control = 5'bxx001; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0000;
			@(posedge clk) #3 MEM_control = 5'bxxx00; RF_control = 6'bxxxxx0;  ALU_control = 3'bxx0; PC_control = 4'b0001;
			// simulate controller signal "done"
			@(posedge clk) #3 $display("######  Operation HLT accepted, PC stop counting.  ######");
			done = 1'b1;
		end
	endtask
endmodule
