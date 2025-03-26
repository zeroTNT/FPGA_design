// Verilog test fixture created from schematic /home/ise/VMShare/Decoder3x8/Decoder3x8.sch - Mon Mar 24 12:14:58 2025

`timescale 1ns / 1ps

module Decoder3x8_Decoder3x8_sch_tb();

// Inputs
   reg [2:0] I;
   reg Enable;

// Output
   wire [7:0] O;

// Bidirs

// Instantiate the UUT
   Decoder3x8 UUT (
		.I(I), 
		.Enable(Enable), 
		.O(O)
   );
// Initialize Inputs
   initial begin
	 Enable = 0;
	 I = 3'b000;
	 #10 I = 3'b001;
	 #10 I = 3'b011;
	 #10 I = 3'b010;
	 #10 I = 3'b110;
	 #10 I = 3'b111;
	 #10 I = 3'b101;
	 #10 I = 3'b100;
	 #10 Enable = 1'b1;
	 #10 I = 3'b101;
	 #10 I = 3'b111;
	 #10 I = 3'b110;
	 #10 I = 3'b010;
	 #10 I = 3'b011;
	 #10 I = 3'b001;
	 #10 I = 3'b000;
	end
endmodule
