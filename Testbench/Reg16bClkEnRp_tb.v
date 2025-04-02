// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Reg16bClkEnRp.sch - Tue Apr  1 13:21:13 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module Reg16bClkEnRp_Reg16bClkEnRp_sch_tb();

// Inputs
   reg clk;
   reg clk_en;
   reg CLR;
   reg [15:0] D;

// Output
   wire [15:0] Q;

// Bidirs
   real CYCLE = `CYCLE_TIME;
   initial clk = 1'b0;
   always #(CYCLE/2) clk = ~clk;
// Instantiate the UUT
   Reg16bClkEnRp UUT (
		.Q(Q), 
		.clk(clk), 
		.clk_en(clk_en), 
		.CLR(CLR), 
		.D(D)
   );
// Initialize Inputs
   initial begin
      D = 16'hxxxx;
		clk_en = 'b0;
      repeat(3) @(posedge clk);
      CLR = 1'b1;
      repeat(2) @(posedge clk) #3 CLR = 1'b0;
      @(posedge clk) #3 D = 16'hdddd;
		@(posedge clk) #3 clk_en = 'b1;
      @(posedge clk) #3 D = 16'h1111;
      @(posedge clk) #3 D = 16'h2222;
      @(posedge clk) #3 D = 16'h4444;
      @(posedge clk) #3 D = 16'h8888;
      @(posedge clk) #3 D = 16'hcccc;
      @(posedge clk) #3 D = 16'hffff;
      #100 $finish;
   end
endmodule
