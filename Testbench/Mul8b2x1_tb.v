// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Mul8b2x1.sch - Thu Mar 27 08:36:08 2025

`timescale 1ns / 1ps

module Mul8b2x1_Mul8b2x1_sch_tb();

// Inputs
   reg [7:0] D0;
   reg [7:0] D1;
   reg addr;

// Output
   wire [7:0] F;

// Bidirs
   integer i;
// Instantiate the UUT
   Mul8b2x1 UUT (
		.D0(D0), 
		.D1(D1), 
		.addr(addr), 
		.F(F)
   );
// Initialize Inputs
   addr = 1'bx; D0 = 8'hxx; D1 = 8'hxx;
   for (i = 0; i<50; i=i+1) begin
      #20 addr = $random(); D1 = $random(); D0 = $random();
   end
	#20 D0 = 8'h55; D1 = 8'haa;
	#20 addr = 1'b0;
   #20 addr = 1'b1;
   #20 D1 = 8'hff;
   #20 addr = 1'b0;
   #20 D0 = 8'h00;

	#50 $finish;
endmodule
