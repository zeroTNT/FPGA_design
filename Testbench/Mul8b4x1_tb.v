// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Mul8b4x1.sch - Thu Mar 27 10:52:10 2025

`timescale 1ns / 1ps

module Mul8b4x1_Mul8b4x1_sch_tb();

// Inputs
   reg [1:0] addr;
   reg [7:0] D0;
   reg [7:0] D1;
   reg [7:0] D2;
   reg [7:0] D3;

// Output
   wire [7:0] F;

// Bidirs
   integer i;
// Instantiate the UUT
   Mul8b4x1 UUT (
		.addr(addr), 
		.D0(D0), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.F(F)
   );
// Initialize Inputs
   initial begin
      addr = 2'b00; D0 = 8'h0; D1 = 8'h0; D2 = 8'h0; D3 = 8'h0;
      
      for (i = 0; i<20; i=i+1) begin
         #20 addr = $random(); D3 = $random(); D2 = $random(); D1 = $random(); D0 = $random();
      end

      #50 $finish;
   end
endmodule
