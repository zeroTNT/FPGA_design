// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Memory256x16.sch - Wed Mar 26 18:16:46 2025

`timescale 1ns / 1ps

module Memory256x16_Memory256x16_sch_tb();

// Inputs
   reg clk;
   reg [15:0] Data;
   reg [15:0] addr;
   reg WE;

// Output
   wire [15:0] MemOut;

   reg clk;
   integer i;
// Bidirs
   initial begin
      clk = 1'b0;
   end
   always #5 clk = ~clk;

// Instantiate the UUT
   Memory256x16 UUT (
		.MemOut(MemOut), 
		.clk(clk), 
		.Data(Data), 
		.addr(addr), 
		.WE(WE)
   );
// Initialize Inputs
   initial begin
      addr = 16'bx; Data = 16'h0000; WE = 1'b0;
      for (i = 0; i <= 20; i = i+1) begin
         #50 addr = $random(); Data = $random(); WE = $random();
         #50 Data = $random(); WE = 1'b1;
      end

		#50 $finish;
   end
endmodule
