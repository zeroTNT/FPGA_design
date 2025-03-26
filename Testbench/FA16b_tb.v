// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/FA16b.sch - Wed Mar 26 05:56:58 2025

`timescale 1ns / 1ps

module FA16b_FA16b_sch_tb();

// Inputs
   reg Cin;
   reg [15:0] A;
   reg [15:0] B;

// Output
   wire Cout;
   wire [15:0] Sum;

// Bidirs

// Instantiate the UUT
   FA16b UUT (
		.Cin(Cin), 
		.Cout(Cout), 
		.A(A), 
		.B(B), 
		.Sum(Sum)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		Cin = 0;
		A = 0;
		B = 0;
   `endif
endmodule
