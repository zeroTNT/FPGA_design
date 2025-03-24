// Verilog test fixture created from schematic /home/ise/VMShare/RF16bClkEn/RF16bClkEn.sch - Mon Mar 24 19:17:41 2025
// maximum delay = 6.097ns
`timescale 1ns / 1ps
`define CYCLE_TIME 20.0
module RegisterFile_RegisterFile_sch_tb();

// Inputs
   reg clk_n;
   reg [2:0] Waddr;
   reg [15:0] WData;
   reg WE;
   reg [2:0] Aaddr;
   reg [2:0] Baddr;

// Output
   wire [15:0] AData;
   wire [15:0] BData;

// Clock period
   real CYCLE = `CYCLE_TIME;
   initial clk_n = 1'b1;
   always #(CYCLE/2) clk_n = ~clk_n;
// Instantiate the UUT
   RegisterFile UUT (
		.clk_n(clk_n),
      .Waddr(Waddr),
      .WData(WData),
      .WE(WE),
      .Aaddr(Aaddr),
      .Baddr(Baddr),
      .AData(AData),
      .BData(BData)
   );
// Initialize Inputs
   initial begin
      WData = 16'hxxxx; Waddr = 3'bxxx;
      Aaddr = 3'bxxx; Baddr = 3'bxxx;
		WE = 'b0;
      repeat(3) @(posedge clk_n);
      #20 WData = 16'h1111; Waddr = 3'b000; WE = 1'b1;
      #20 WData = 16'h2222; Waddr = 3'b001; WE = 1'b1;   Aaddr = 3'b000;
      #20 WData = 16'h4444; Waddr = 3'b010; WE = 1'b1;   Baddr = 3'b001;
      #20 WData = 16'h8888; Waddr = 3'b011; WE = 1'b1;   Aaddr = 3'b010;
      #20 WData = 16'h9999; Waddr = 3'b100; WE = 1'b1;   Baddr = 3'b011;
      #20 WData = 16'haaaa; Waddr = 3'b101; WE = 1'b1;   Aaddr = 3'b100;
      #20 WData = 16'hcccc; Waddr = 3'b110; WE = 1'b1;   Baddr = 3'b101;
      #20 WData = 16'hdddd; Waddr = 3'b111; WE = 1'b1;   Aaddr = 3'b110;
      #20 Baddr = 3'b111;

      #20 WData = 16'h0000; Waddr = 3'b000; WE = 1'b0;
      #20 WData = 16'heeee; Waddr = 3'b000; WE = 1'b1;
      #20 WData = 16'hffff; Waddr = 3'b001; WE = 1'b1;
      #20 Aaddr = 3'b000; Baddr = 3'b001;
      #100 $finish;
   end
endmodule
