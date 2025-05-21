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
   reg [2:0] I;
// Instantiate the UUT
   FA1b UUT (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.Sum(Sum), 
		.Cout(Cout)
   );
// align the inputs and outputs
   always @(*) begin
     {A, B, Cin} = I;
   end
// Initialize Inputs
   initial begin
	 I = 3'b000;
	 #10 I = 3'b001;
	 #10 I = 3'b011;
	 #10 I = 3'b010;
	 #10 I = 3'b110;
	 #10 I = 3'b111;
	 #10 I = 3'b101;
	 #10 I = 3'b100;
	 #10 I = 3'b101;
	 #10 I = 3'b111;
	 #10 I = 3'b110;
	 #10 I = 3'b010;
	 #10 I = 3'b011;
	 #10 I = 3'b001;
	 #10 I = 3'b000;
	 #50 $finish;
	end
endmodule
