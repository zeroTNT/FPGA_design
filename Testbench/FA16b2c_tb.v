// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/FA16b2c.sch - Wed Mar 26 08:07:16 2025

`timescale 1ns / 1ps

module FA16b2c_FA16b2c_sch_tb();

// Inputs
   reg [15:0] B;
   reg [15:0] A;
   reg PSW_C;
   reg ALUop;
   reg Flag;

// Output
   wire Cout;
   wire [15:0] Sum;

// Bidirs

// Instantiate the UUT
   FA16b2c UUT (
		.B(B), 
		.A(A), 
		.PSW_C(PSW_C), 
		.Cout(Cout), 
		.Sum(Sum), 
		.ALUop(ALUop), 
		.Flag(Flag)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		B = 0;
		A = 0;
		PSW_C = 0;
		ALUop = 0;
		Flag = 0;
   `endif
endmodule
