// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Concate8x8.sch - Fri Mar 28 12:54:13 2025

`timescale 1ns / 1ps

module Concate8x8_Concate8x8_sch_tb();

// Inputs
   reg [7:0] ConLSB;
   reg [7:0] ConMSB;

// Output
   wire [15:0] Concated;

// Bidirs

   integer i;
// Instantiate the UUT
   Concate8x8 UUT (
		.ConLSB(ConLSB), 
		.ConMSB(ConMSB), 
		.Concated(Concated)
   );
// Initialize Inputs
   initial begin
      ConLSB = 8'h00; ConMSB = 8'h00;
      // random test pattern
      for (i = 0; i <= 10; i = i+1) begin
         #20 ConLSB = $random(); ConMSB = $random();
      end
      #50 $finish;
	end
endmodule
