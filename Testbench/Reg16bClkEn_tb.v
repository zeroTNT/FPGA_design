// Verilog test fixture created from schematic /home/ise/VMShare/RF16bClkEn/RF16bClkEn.sch - Mon Mar 24 19:17:41 2025
// maximum delay = 6.097ns
`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module Reg16bClkEn_Reg16bClkEn_sch_tb();

// Inputs
   reg clk_n;
	reg clk_en;
   reg [15:0] D;

// Output
   wire [15:0] Q;

// Clock period
   real CYCLE = `CYCLE_TIME;
   initial clk_n = 1'b1;
   always #(CYCLE/2) clk_n = ~clk_n;
// Instantiate the UUT
   Reg16bClkEn UUT (
		.Q(Q), 
		.clk_en(clk_en),
		.clk_n(clk_n), 
		.D(D)
   );
// Initialize Inputs
   initial begin
      D = 16'hxxxx;
		clk_en = 'b0;
      repeat(3) @(posedge clk_n);
      @(negedge clk_n)  D = 16'hdddd;
		#10 clk_en = 'b1;
      @(negedge clk_n)  D = 16'h1111;
      @(negedge clk_n)  D = 16'h2222; 
		#2 clk_en='b0;
      @(negedge clk_n)  D = 16'h4444;
      @(negedge clk_n)  D = 16'h8888;
      @(negedge clk_n)  D = 16'hcccc;
      @(negedge clk_n)  D = 16'hffff;
      #100 $finish;
   end
endmodule
