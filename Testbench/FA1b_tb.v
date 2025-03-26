// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/FA1b.sch - Wed Mar 26 05:30:34 2025

`timescale 1ns / 1ps

module FA1b_FA1b_sch_tb();

// Inputs
   reg A;
   reg B;
   reg Cin;

// Output
   wire Sum;
   wire Cout;

// Bidirs

// Instantiate the UUT
   FA1b UUT (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.Sum(Sum), 
		.Cout(Cout)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		A = 0;
		B = 0;
		Cin = 0;
   `endif
endmodule
