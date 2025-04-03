// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/TimingGenerator.sch - Thu Apr  3 19:23:25 2025

`timescale 1ns / 1ps

module TimingGenerator_TimingGenerator_sch_tb();

// Inputs
   reg clk;
   reg LastStage;

// Output
   wire [2:0] Cnt;

// Bidirs

// Instantiate the UUT
   TimingGenerator UUT (
		.clk(clk), 
		.LastStage(LastStage), 
		.Cnt(Cnt)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		clk = 0;
		LastStage = 0;
   `endif
endmodule
