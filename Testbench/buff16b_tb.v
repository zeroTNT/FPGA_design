// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/buff16b.sch - Fri Mar 28 14:39:59 2025

`timescale 1ns / 1ps

module buff16b_buff16b_sch_tb();

// Inputs
   reg [15:0] bufin;

// Output
   wire [15:0] bufout;

// Bidirs
   integer i;
// Instantiate the UUT
   buff16b UUT (
		.bufout(bufout), 
		.bufin(bufin)
   );
// Initialize Inputs
   initial begin
      bufin = 8'h00;
      // random test pattern
      for (i = 0; i <= 10; i = i+1) begin
         #20 bufin = $random();
      end
      #50 $finish;
	end
endmodule
