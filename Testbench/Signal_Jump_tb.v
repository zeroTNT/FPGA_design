// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Signal_Jump.sch - Sat Apr  5 09:56:10 2025

`timescale 1ns / 1ps

module Signal_Jump_Signal_Jump_sch_tb();

// Inputs
   reg [15:11] Ins;

// Output
   wire [1:0] Jump;

// Bidirs

// Instantiate the UUT
   Signal_Jump UUT (
		.Ins(Ins), 
		.Jump(Jump)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		Ins = 0;
   `endif
endmodule
