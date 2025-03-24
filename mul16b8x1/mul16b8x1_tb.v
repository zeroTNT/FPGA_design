// Verilog test fixture created from schematic /home/ise/VMShare/mul16b8x1/mul16b8x1.sch - Mon Mar 24 17:21:14 2025

`timescale 1ns / 1ps

module mul16b8x1_mul16b8x1_sch_tb();

// Inputs
   reg [2:0] addr;
   reg [15:0] D0;
   reg [15:0] D1;
   reg [15:0] D2;
   reg [15:0] D3;
   reg [15:0] D4;
   reg [15:0] D5;
   reg [15:0] D6;
   reg [15:0] D7;

// Output
   wire [15:0] OutData;

// Bidirs
  reg [7:0] D;
  always @(*) begin
    {D7, D6, D5, D4, D3, D2, D1, D0} = D;
  end
// Instantiate the UUT
   mul16b8x1 UUT (
		.addr(addr), 
		.D0(D0), 
		.D1(D1), 
		.D2(D2), 
		.D3(D3), 
		.D4(D4), 
		.D5(D5), 
		.D6(D6), 
		.D7(D7), 
		.OutData(OutData)
   );
// Initialize Inputs
   `ifdef auto_init
       initial begin
		addr = 0;
		D0 = 0;
		D1 = 0;
		D2 = 0;
		D3 = 0;
		D4 = 0;
		D5 = 0;
		D6 = 0;
		D7 = 0;
   `endif
endmodule
