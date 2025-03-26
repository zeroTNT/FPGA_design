// Verilog test fixture created from schematic /home/ise/VMShare/mul16b8x1/mul16b8x1.sch - Mon Mar 24 17:21:14 2025
// maximum delay = 10.000ns
`timescale 1ns / 1ps

module Mul16b8x1_Mul16b8x1_sch_tb();

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
  reg [15:0] D [0:7];
  always @(*) begin
    {D7, D6, D5, D4, D3, D2, D1, D0} = {D[7], D[6], D[5], D[4], D[3], D[2], D[1], D[0]};
  end
// Instantiate the UUT
   Mul16b8x1 UUT (
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
    initial begin
		addr = 3'bxxx;
		D[0] = 16'ha1b2; D[1] = 16'ha3b4; D[2] = 16'hc3d4; D[3] = 16'hc5d6;
		D[4] = 16'he5f6; D[5] = 16'he7f8; D[6] = 16'h0718; D[7] = 16'h0910;
		#20 addr = 3'b000;
		#20 addr = 3'b001;
		#20 addr = 3'b011;
		#20 addr = 3'b010;
		#20 addr = 3'b110;
		#20 addr = 3'b111;
		#20 addr = 3'b101;
		#20 addr = 3'b100;
		#50 $finish;
	end
endmodule
