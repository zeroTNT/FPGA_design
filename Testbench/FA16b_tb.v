// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/FA16b.sch - Wed Mar 26 05:56:58 2025
// maximum delay = 15ns
`timescale 1ns / 1ps

module FA16b_FA16b_sch_tb();

// Inputs
   reg Cin;
   reg [15:0] A;
   reg [15:0] B;

// Output
   wire Cout;
   wire [15:0] Sum;

// Bidirs
   integer i;
   reg [16:0] golden_result;
// Instantiate the UUT
   FA16b UUT (
		.Cin(Cin), 
		.Cout(Cout), 
		.A(A), 
		.B(B), 
		.Sum(Sum)
   );
// Initialize Inputs
   initial begin
      Cin = 1'b0; A = 16'h0000; B = 16'h0000;
      // random test pattern
      for (i = 0; i <= 50; i = i+1) begin
         #10 A = $random(); B = $random(); Cin = $random(); golden_result = A + B + Cin;
         #10
         if (golden_result != {Cout, Sum}) begin
            $display("Error at %d pattern: A=%h, B=%h, Cin=%b, Sum=%h, Cout=%b, golden_result={%b, %h}", i, A, B, Cin, Sum, Cout, golden_result[16], golden_result[15:0]);
            $finish;
         end
      end

      // boundary test pattern
      #10 A = 16'hffff; B = 16'h0002; Cin = 1'b0; golden_result = A + B + Cin;
      #15
      if (golden_result != {Cout, Sum}) begin
         $display("Error at boundary pattern: A=%h, B=%h, Cin=%b, Sum=%h, Cout=%b, golden_result={%b, %h}", A, B, Cin, Sum, Cout, golden_result[16], golden_result[15:0]);
         $finish;
      end
      #10 A = 16'h0000; B = 16'hffff; Cin = 1'b1; golden_result = A + B + Cin;
      #15
      if (golden_result != {Cout, Sum}) begin
         $display("Error at boundary pattern: A=%h, B=%h, Cin=%b, Sum=%h, Cout=%b, golden_result={%b, %h}", A, B, Cin, Sum, Cout, golden_result[16], golden_result[15:0]);
         $finish;
      end
      $display("Congratulation! Module is passed random & some boundary test.");
      #10 $finish;
	end
endmodule
