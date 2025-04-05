// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/TimingGenerator.sch - Thu Apr  3 19:23:25 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module TimingGenerator_TimingGenerator_sch_tb();

// Inputs
   reg clk;
   reg LastStage;
   reg Rst;

// Output
   wire [2:0] Cnt;
   // @(posedge clk) #3 if (LastStage == 1'b1) Cnt = 3'b000;
   // if (Cnt == 3'b000) Stage1 enable, Stage2... disable;
   // ...
   // if (Cnt == "LastStagefromControll") Buff_PC enable; LastStage = 1'b1;
   

// Bidirs
// Net, Variable

// Clock
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;
// Instantiate the UUT
   TimingGenerator UUT (
		.clk(clk), 
		.LastStage(LastStage), 
      .Rst(Rst), 
		.Cnt(Cnt)
   );
// Initialize Inputs
   initial begin
      // Initialize Inputs
      LastStage = 1'b0;
      Rst = 1'b0;
      // Wait 100 ns for global reset to finish
      Rst = 1'b1;
      #150;
      // For the operations that needs taking 3 stages for finishing
      @(posedge clk) #3 Rst = 1'b0; // Cnt = 0; Stage IF
      @(posedge clk) #3 //Stage ID
      @(posedge clk) #3 LastStage = 1'b1; //Stage EXE
      
      // For the operations that needs taking 5 stages for finishing
      @(posedge clk) #3 LastStage = 1'b0; //Stage IF
      @(posedge clk) #3; //Stage ID
      @(posedge clk) #3; //Stage EXE
      @(posedge clk) #3; //Stage MEM
      @(posedge clk) #3 LastStage = 1'b1; //Stage WB

      // For the operations that needs taking 2 stages for finishing
      @(posedge clk) #3 LastStage = 1'b0; //Stage IF
      @(posedge clk) #3 LastStage = 1'b1;//Stage EXE

      // For the operations that needs taking 4 stages for finishing
      @(posedge clk) #3 LastStage = 1'b0; //Stage IF
      @(posedge clk) #3; //Stage ID
      @(posedge clk) #3; //Stage EXE
      @(posedge clk) #3 LastStage = 1'b1; //Stage MEM
      
      @(posedge clk) $finish;
   end
endmodule
