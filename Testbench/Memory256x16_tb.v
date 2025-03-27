// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Memory256x16.sch - Thu Mar 27 13:51:35 2025

`timescale 1ns / 1ps

module Memory256x16_Memory256x16_sch_tb();

// Inputs
   reg clk;
   reg Tbornot;
   reg [7:0] Addr_tb;
   reg [7:0] Addr_pc;
   reg [15:0] Data_tb;
   reg [15:0] Data_pc;
   reg WE_tb;
   reg WE_pc;
   

// Output
   wire [15:0] MemOut;

// Bidirs
	reg [24:0] pc;
	reg [24:0] tb;
	always @(*) begin
		{WE_tb, Addr_tb, Data_tb} = tb;
		{WE_pc, Addr_pc, Data_pc} = pc;
	end
// Instantiate the UUT
   Memory256x16 UUT (
		.clk(clk), 
		.Tbornot(Tbornot), 
		.Addr_tb(Addr_tb), 
		.Addr_pc(Addr_pc),
		.Data_tb(Data_tb), 
		.Data_pc(Data_pc),
		.WE_tb(WE_tb), 
		.WE_pc(WE_pc), 
		.MemOut(MemOut)
   );
// Initialize Inputs
   initial begin
      Tbornot = 1'bx; tb = 25'hxxxxxxx;, pc = 25'hxxxxxxx;
	  for (i = 0; i <= 20; i = i+1) begin
		 #20 Tbornot = $random(); tb = $random(); pc = $random();
	  end
	  #50 $finish;
   end
endmodule
