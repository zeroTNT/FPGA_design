// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/PCcircuitry.sch - Thu Mar 27 11:26:05 2025
// maximum input delay = 6ns
`timescale 1ns / 1ps

module PCcircuitry_PCcircuitry_sch_tb();

// Inputs
   reg [7:0] Rm;
   reg [7:0] PC;
   reg [7:0] Rd;
   reg Branch;
   reg [7:0] Ins;
   reg [1:0] Jump;

// Output
   wire [7:0] nextPC;

// Bidirs

// Instantiate the UUT
   PCcircuitry UUT (
		.Jump(Jump),
		.Branch(Branch),
		.PC(PC),
		.Ins(Ins),
		.Rm(Rm),
		.Rd(Rd),
		.nextPC(nextPC)
   );
// Initialize Inputs
	initial begin
		Jump = 2'bxx; Branch = 1'bx; PC = 8'hxx; Ins = 8'hxx; Rm = 8'hxx; Rd = 8'hxx;
		// PC + 1
		#20 PC = $random(); Ins = 8'h0; Branch = 1'b0; Jump = 2'b0;
		// Branch
		#20 Ins = 8'h3; Branch = 1'b1; Jump = 2'b0;

		// jal label
		// control signals are same as branch
		#20 Branch = 1'b1; Jump = 2'b00;

		// jmp
		#20 Branch = 1'bx; Jump = 2'b01;
		// jal Rm
		#20 Rm = 8'h55; Branch = 1'bx; Jump = 2'b10;
		// jal Rd
		#20 Rd = 8'h22; Branch = 1'bx; Jump = 2'b11;
		#50 $finish;
	end
endmodule
