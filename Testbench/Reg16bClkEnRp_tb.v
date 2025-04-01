// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Reg16bClkEnRp.sch - Tue Apr  1 13:21:13 2025

`timescale 1ns / 1ps

module Reg16bClkEnRp_Reg16bClkEnRp_sch_tb();

// Inputs
   reg clk;
   reg clk_en;
   reg CLR;
   reg [15:0] D;

// Output
   wire [15:0] Q;

// Bidirs

// Instantiate the UUT
   Reg16bClkEnRp UUT (
		.Q(Q), 
		.clk(clk), 
		.clk_en(clk_en), 
		.CLR(CLR), 
		.D(D)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		clk = 0;
		clk_en = 0;
		CLR = 0;
		D = 0;
   `endif
endmodule
