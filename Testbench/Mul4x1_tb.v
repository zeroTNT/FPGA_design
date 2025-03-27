// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Mul4x1.sch - Thu Mar 27 07:46:53 2025

`timescale 1ns / 1ps

module Mul4x1_Mul4x1_sch_tb();

// Inputs
   reg [1:0] addr;
   reg D0;
   reg D1;
   reg D2;
   reg D3;

// Output
   wire F;

// Bidirs
   integer i;
// Instantiate the UUT
   Mul4x1 UUT (
		.addr(addr), 
		.D0(D0), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.F(F)
   );
// Initialize Inputs
   initial begin
      addr = 2'b00; D0 = 1'b0; D1 = 1'b0; D2 = 1'b0; D3 = 1'b0;
      #20 D0 = 1'b1;
      #20 D0 = 1'b0;
      #20 addr = 2'b01;
      #20 D1 = 1'b1;
      #20 D1 = 1'b0;
      #20 addr = 2'b11;
      #20 D3 = 1'b1;
      #20 D3 = 1'b0;
      #20 addr = 2'b10;
      #20 D2 = 1'b1;
      #20 D2 = 1'b0;
      #50 $finish;
   end
endmodule
