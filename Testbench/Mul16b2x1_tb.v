// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Mul16b2x1.sch - Thu Mar 27 13:24:39 2025
// maximum input delay = 6.5ns
`timescale 1ns / 1ps

module Mul16b2x1_Mul16b2x1_sch_tb();

// Inputs
   reg [15:0] D0;
   reg [15:0] D1;
   reg addr;

// Output
   wire [15:0] F;

// Bidirs
   integer i;
// Instantiate the UUT
   Mul16b2x1 UUT (
		.D0(D0), 
		.D1(D1), 
		.F(F), 
		.addr(addr)
   );
// Initialize Inputs
   initial begin
      addr = 1'bx; D0 = 16'hxx; D1 = 16'hxx;
      for (i = 0; i<20; i=i+1) begin
         #20 addr = $random(); D1 = $random(); D0 = $random();
      end
   	#20 D0 = 16'h5555; D1 = 16'haaaa;
   	#20 addr = 1'b0;
      #20 addr = 1'b1;
      #20 D1 = 16'hffff;
      #20 addr = 1'b0;
      #20 D0 = 16'h0000;
   
   	#50 $finish;
   end
endmodule
