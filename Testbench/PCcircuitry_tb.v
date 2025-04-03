// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/PCcircuitry.sch - Thu Mar 27 11:26:05 2025
// maximum input delay = 6ns
`timescale 1ns / 1ps
`define CYCLE_TIME  50.0
module PCcircuitry_PCcircuitry_sch_tb();

// Inputs
   reg [15:0] Rm;
   reg [15:0] PC;
   reg [15:0] Rd;
   reg Branch;
   reg [10:0] Ins;
   reg [1:0] Jump;

// Output
   wire [15:0] nextPC;
	wire [15:0] PCplus1_mul;
// Net, Variable
	
// Clock
	reg clk;
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Instantiate the UUT
   PCcircuitry UUT (
		.Jump(Jump),
		.Branch(Branch),
		.PC(PC),
		.Ins(Ins),
		.Rm(Rm),
		.Rd(Rd),
		.nextPC(nextPC),
		.PCplus1_mul(PCplus1_mul)
   );
// Initialize Inputs
	initial begin
		Jump = 2'bxx; Branch = 1'bx; PC = 16'hx; Ins = 10'hx; Rm = 16'hx; Rd = 16'hx;
		// PC + 1
		@(posedge clk) #3 PC = $random(); Ins = 10'h0; Branch = 1'b0; Jump = 2'b0;
		repeat(5) @(posedge clk) #3 PC = PCplus1_mul;
		// Branch
		@(posedge clk) #3 Ins = 10'h0003; Branch = 1'b1; Jump = 2'b0;

		// jal label
		// control signals are same as branch
		@(posedge clk) #3 Branch = 1'b1; Jump = 2'b00;
		PC = 16'haaaa; Ins = 10'h155;
		// jmp
		@(posedge clk) #3 Branch = 1'bx; Jump = 2'b01;
		// jal Rm
		@(posedge clk) #3 Rm = 16'h0055; Branch = 1'bx; Jump = 2'b10;
		// jal Rd
		@(posedge clk) #3 Rd = 16'h0022; Branch = 1'bx; Jump = 2'b11;
		#50 $finish;
	end
endmodule
