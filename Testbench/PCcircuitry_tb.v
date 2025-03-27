// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/PCcircuitry.sch - Thu Mar 27 11:26:05 2025

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
		.Rm(Rm), 
		.PC(PC), 
		.Rd(Rd), 
		.InsB(InsB), 
		.Ins(Ins), 
		.nextPC(nextPC), 
		.InsJ(InsJ)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		Rm = 0;
		PC = 0;
		Rd = 0;
		InsB = 0;
		Ins = 0;
		InsJ = 0;
   `endif
endmodule
