// Verilog test fixture created from schematic /home/ise/VMShare/RF16bClkEn/RF16bClkEn.sch - Mon Mar 24 19:17:41 2025
// maximum delay = 6.00ns
`timescale 1ns / 1ps
`define CYCLE_TIME 20.0
module RF16bClkEn_RF16bClkEn_sch_tb();

// Inputs
   reg clk_n;
   reg [15:0] D;

// Output
   wire [15:0] Q;

// Clock period
   real CYCLE = `CYCLE_TIME;
   initial clk_n = 1'b1;
   always #(CYCLE/2) clk_n = ~clk_n;
// Instantiate the UUT
   RF16bClkEn UUT (
		.Q(Q), 
		.clk_n(clk_n), 
		.D(D)
   );
// Initialize Inputs
   initial begin
      D = 16'hxxxx;
      repeat(3) @(posedge clk_n);
      #20 D = 16'h0000;
      #20 D = 16'h1111;
      #20 D = 16'h2222;
      #20 D = 16'h4444;
      #20 D = 16'h8888;
      #20 D = 16'hcccc;
      #20 D = 16'hffff;
      #100 $finish;
   end
endmodule
