// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Signal_ALUorNot.sch - Sat Apr  5 12:15:45 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module Signal_ALUorNot_Signal_ALUorNot_sch_tb();

// Inputs
   reg [2:0] Cnt;
   reg [15:11] InsM;

// Output
   wire ALUorNot;

// Parameters
   parameter [5:0]   LHI = 6'h01, LLI = 6'h02, LDRri = 6'h03, LDRrr = 6'h04, STRri = 6'h05, STRrr = 6'h06,
                     ADD = 6'h07, ADC = 6'h08, SUB = 6'h09, SBB = 6'h0A, CMP = 6'h0B,
                     ADDI = 6'h0C, SUBI = 6'h0D, MOV = 6'h0E,
                     BCC = 6'h0F, BCS = 6'h10, BEQ = 6'h11, BNE = 6'h12, BAL = 6'h13,
                     JMP = 6'h14, JALrl = 6'h15, JALrr = 6'h16, JR = 6'h17,
                     OutR = 6'h18, HLT = 6'h19;
   
// Clock
   reg [1:0] InsL;
   reg clk;
   real CYCLE = `CYCLE_TIME;
   initial clk = 1'b0;
   always #(CYCLE/2) clk = ~clk;
// Net, Variable
   integer i;
   wire Buff_PC;
   reg [5:0] Ins;
   reg [15:8] OPM;
   reg [1:0] OPL;
   initial Cnt = 3'b000;
   always @(posedge clk) begin
      #3 
      if(Buff_PC == 1'b1) Cnt = 3'b000;
      else Cnt = Cnt + 1;
   end

// Instantiate the UUT
   Signal_ALUorNot UUT (
		.Cnt(Cnt), 
		.InsM(InsM), 
		.ALUorNot(ALUorNot)
   );
   Signal_Buff_PC PCSignal (
		.Cnt(Cnt), 
		.InsM(InsM), 
		.InsL(InsL), 
		.Buff_PC(Buff_PC)
   );
// Initialize Inputs
   initial begin
      Ins = 6'b000000;
      OPM = 8'b00000000;
      OPL = 2'b00;
      for (i = 1; i < 6'h1A; i = i + 1) begin
         Ins = i;
         @(posedge clk) #3;
         InsCovet(Ins, OPM, OPL);
         repeat(4) @(posedge clk) #3;
      end
      $finish;
   end
// task
   task InsCovet;
      input [5:0] Ins;
      output [15:8] OpM;
      output [1:0] OpL;
      begin
         case(Ins)
            LHI: begin
               OpM = 8'b00001xxx;
               OpL = 2'bxx;
            end
            LLI: begin
               OpM = 8'b00010xxx;
               OpL = 2'bxx;
            end
            LDRri: begin
               OpM = 8'b00011xxx;
               OpL = 2'bxx;
            end
            LDRrr: begin
               OpM = 8'b00100xxx;
               OpL = 2'b00;
            end
            STRri: begin
               OpM = 8'b00101xxx;
               OpL = 2'bxx;
            end
            STRrr: begin
               OpM = 8'b00110xxx;
               OpL = 2'b00;
            end
            ADD: begin
               OpM = 8'b00000xxx;
               OpL = 2'b00;
            end
            ADC: begin
               OpM = 8'b00000xxx;
               OpL = 2'b01;
            end
            SUB: begin
               OpM = 8'b00000xxx;
               OpL = 2'b10;
            end
            SBB: begin
               OpM = 8'b00000xxx;
               OpL = 2'b11;
            end
            CMP: begin
               OpM = 8'b00110xxx;
               OpL = 2'b01;
            end
            ADDI: begin
               OpM = 8'b00111xxx;
               OpL = 2'bxx;
            end
            SUBI: begin
               OpM = 8'b01000xxx;
               OpL = 2'bxx;
            end
            MOV: begin
               OpM = 8'b01011xxx;
               OpL = 2'bxx;
            end
            BCC: begin
               OpM = 8'b11000011;
               OpL = 2'bxx;
            end
            BCS: begin
               OpM = 8'b11000010;
               OpL = 2'bxx;
            end
            BEQ: begin
               OpM = 8'b11000001;
               OpL = 2'bxx;
            end
            BNE: begin
               OpM = 8'b11000000;
               OpL = 2'bxx;
            end
            BAL: begin
               OpM = 8'b11001110;
               OpL = 2'bxx;
            end
            JMP: begin
               OpM = 8'b10000xxx;
               OpL = 2'bxx;
            end
            JALrl: begin
               OpM = 8'b10001xxx;
               OpL = 2'bxx;
            end
            JALrr: begin
               OpM = 8'b10010xxx;
               OpL = 2'bxx;
            end
            JR: begin
               OpM = 8'b10011xxx;
               OpL = 2'bxx;
            end
            OutR: begin
               OpM = 8'b11100xxx;
               OpL = 2'b00;
            end
            HLT: begin
               OpM = 8'b11100xxx;
               OpL = 2'b01;
            end
            default: begin
               OpM = 8'bxxxx_xxxx;
               OpL = 2'bxx;
            end
         endcase
      end
   endtask
endmodule
