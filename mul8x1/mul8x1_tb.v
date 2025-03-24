// Verilog test fixture created from schematic /home/ise/VMShare/mul8x1/mul8x1.sch - Mon Mar 24 15:52:50 2025

`timescale 1ns / 1ps

module mul8x1_mul8x1_sch_tb();

// Inputs
  reg D0;
  reg D1;
  reg D2;
  reg D3;
  reg D4;
  reg D5;
  reg D6;
  reg D7;
  reg [2:0] addr;

// Output
  wire F;

// Bidirs
  reg [7:0] D;
  always @(*) begin
    {D7, D6, D5, D4, D3, D2, D1, D0} = D;
  end
// Instantiate the UUT
  mul8x1 UUT (
    .D0(D0), 
    .D1(D1), 
    .D2(D2), 
    .D3(D3), 
    .D4(D4), 
    .D5(D5), 
    .D6(D6), 
    .D7(D7), 
    .F(F), 
    .addr(addr)
  );
// Initialize Inputs
  initial begin
    D = 8'h00;
    addr = 3'b000;
    #10 D[0] = 1'b1;
    #10 D[0] = 1'b0;
    #10 addr = 3'b001;
    #10 D[1] = 1'b1;
    #10 D[1] = 1'b0;
    #10 addr = 3'b011;
    #10 D[3] = 1'b1;
    #10 D[3] = 1'b0;
    #10 addr = 3'b010;
    #10 D[2] = 1'b1;
    #10 D[2] = 1'b0;
    #10 addr = 3'b110;
    #10 D[6] = 1'b1;
    #10 D[6] = 1'b0;
    #10 addr = 3'b111;
    #10 D[7] = 1'b1;
    #10 D[7] = 1'b0;
    #10 addr = 3'b101;
    #10 D[5] = 1'b1;
    #10 D[5] = 1'b0;
    #10 addr = 3'b100;
    #10 D[4] = 1'b1;
    #10 D[4] = 1'b0;
    #100 $finish;
  end
endmodule
