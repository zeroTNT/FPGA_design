// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/PCcircuitry.sch - Thu Mar 27 11:26:05 2025
// maximum input delay = 6ns
`timescale 1ns / 1ps

module PCcircuitry_PCcircuitry_sch_tb();

// Inputs
   reg [7:0] Rm;
   reg [7:0] PC;
   reg [7:0] Rd;
   reg InsB;
   reg [7:0] Ins;
   reg [1:0] InsJ;

// Output
   wire [7:0] nextPC;

// Bidirs

// Instantiate the UUT
   PCcircuitry UUT (
		.InsJ(InsJ),
		.InsB(InsB),
		.PC(PC),
		.Ins(Ins),
		.Rm(Rm),
		.Rd(Rd),
		.nextPC(nextPC)
   );
// Initialize Inputs
	initial begin
		InsJ = 2'bxx; InsB = 1'bx; PC = 8'hxx; Ins = 8'hxx; Rm = 8'hxx; Rd = 8'hxx;
		// PC + 1
		#20 PC = $random(); Ins = 8'h0; InsB = 1'b0; InsJ = 2'b0;
		// Branch
		#20 Ins = 8'h3; InsB = 1'b1; InsJ = 2'b0;

		// jal label
		// control signals are same as branch
		#20 InsB = 1'b1; InsJ = 2'b00;

		// jmp
		#20 InsB = 1'bx; InsJ = 2'b01;
		// jal Rm
		#20 Rm = 8'h55; InsB = 1'bx; InsJ = 2'b10;
		// jal Rd
		#20 Rd = 8'h22; InsB = 1'bx; InsJ = 2'b11;
		#50 $finish;
	end
endmodule
