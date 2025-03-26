// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Mul2x1.sch - Wed Mar 26 07:44:53 2025

`timescale 1ns / 1ps

module Mul2x1_Mul2x1_sch_tb();

// Inputs
   reg I1;
   reg I0;
   reg addr;

// Output
   wire O;

// Bidirs

// Instantiate the UUT
   Mul2x1 UUT (
		.I1(I1), 
		.I0(I0), 
		.addr(addr), 
		.O(O)
   );
// Initialize Inputs
   initial begin
      {I1, I0} = 2'b00;
      addr = 1'b0;
      #10 {I1, I0} = 2'b01;
      #10 addr = 1'b0;
      #10 {I1, I0} = 2'b10;
      #10 addr = 1'b1;
      #10 {I1, I0} = 2'b01;
      #100 $finish;
   end
endmodule
