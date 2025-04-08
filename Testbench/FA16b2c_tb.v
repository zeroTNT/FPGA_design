// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/FA16b2c.sch - Wed Mar 26 08:07:16 2025
// maximum delay = 15ns
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
   wire Z;
   wire N;

// Bidirs
   integer i;

   reg [2:0] tmp;
   always @(*) {Flag, PSW_C, ALUop} = tmp;
// Instantiate the UUT
   FA16b2c UUT (
		.B(B), 
		.A(A), 
		.PSW_C(PSW_C), 
		.Cout(Cout), 
		.Sum(Sum), 
		.ALUop(ALUop), 
		.Flag(Flag),
      .Z(Z),
      .N(N)
   );
// Initialize Inputs
   initial begin
      A = 16'h0000; B = 16'h0000; tmp = 3'b000;
      // random test pattern
      for (i = 0; i <= 10; i = i+1) begin
         #20 A = $random(); B = $random(); tmp = $random();
      end
      // boundary test pattern
      // A - B = -1 + 2 = 1
      #20 A = 16'hffff; B = 16'h0002; tmp = 3'b000;
      // A - B = (-32,767) - 3 = -32,764
      #20 A = 16'h8001; B = 16'h0003; tmp = 3'b001;
      // A - B = 4 - 4 = 0
      #20 A = 16'h0004; B = 16'h0004; tmp = 3'b011;
      #50 $finish;
	end
endmodule
