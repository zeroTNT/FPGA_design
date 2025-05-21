// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/PCFA2c.sch - Thu Mar 27 07:11:21 2025

`timescale 1ns / 1ps

module PCFA2c_PCFA2c_sch_tb();

// Inputs
   reg [7:0] B;
   reg [7:0] A;
   reg Cin;

// Output
   wire [7:0] Sum;

// Bidirs
	integer i;
// Instantiate the UUT
   PCFA2c UUT (
		.B(B), 
		.A(A), 
		.Cin(Cin), 
		.Sum(Sum)
   );
// Initialize Inputs
   initial begin
      A = 8'h0000; B = 8'h0000; Cin = 1'b0;
      // random test pattern
      for (i = 0; i <= 10; i = i+1) begin
         #20 A = $random(); B = $random();
      end
      // boundary test pattern
      // A - B = -1 + 2 = 1
      #20 A = 8'hff; B = 8'h02;
      // A - B = 1 + (-3) = -2
      #20 A = 8'h01; B = 8'hfc;
      // A - B = 4 - 4 = 0
      #20 A = 8'h04; B = 8'h04;
      #50 $finish;
	end
endmodule
