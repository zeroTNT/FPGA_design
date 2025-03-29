// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/ZeroExtended5x16.sch - Fri Mar 28 13:19:47 2025

`timescale 1ns / 1ps

module ZeroExtended5x16_ZeroExtended5x16_sch_tb();

// Inputs
   reg [4:0] ConLSB;

// Output
   wire [15:0] Extended;

// Bidirs
   integer i;
// Instantiate the UUT
   ZeroExtended5x16 UUT (
		.ConLSB(ConLSB), 
		.Extended(Extended)
   );
// Initialize Inputs
   initial begin
      ConLSB = 8'h00;
      // random test pattern
      for (i = 0; i <= 10; i = i+1) begin
         #20 ConLSB = $random();
      end
      #50 $finish;
	end
endmodule
