// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Controller.sch - Sun Apr  6 06:28:38 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module Controller_Controller_sch_tb();

// Inputs
   reg Rst;
   reg [1:0] PSW_NZC;
   reg [15:8] InsM;
   reg [1:0] InsL;
   reg clk;

// Output
   wire Buff_PC;
   wire Branch;
   wire [1:0] Jump;
   wire WE_MEM;
   wire Buff_MEMIns;
   wire ALUorNot;
   wire LIorMOV;
   wire MEMresource;
   wire WE_RF;
   wire WBresource;
   wire RBresource;
   wire OprandB;
   wire LI;
   wire PCplus1orWB;
   wire Buff_PSW;
   wire Flag;
   wire ALUop;
   wire Done;

// Parameters
   parameter [5:0]   LHI = 6'h01, LLI = 6'h02,
      LDRri = 6'h03, LDRrr = 6'h04, STRri = 6'h05, STRrr = 6'h06,
      ADD = 6'h07, ADC = 6'h08, SUB = 6'h09, SBB = 6'h0A,
      CMP = 6'h0B, ADDI = 6'h0C, SUBI = 6'h0D, MOV = 6'h0E,
      BCC = 6'h0F, BCS = 6'h10, BEQ = 6'h11, BNE = 6'h12,
      BAL = 6'h13,
      JMP = 6'h14, JALrl = 6'h15, JALrr = 6'h16, JR = 6'h17,
      OutR = 6'h18, HLT = 6'h19;

// Clock
   //reg clk;
   reg laststage;
   real CYCLE = `CYCLE_TIME;
   initial clk = 1'b0;
   always #(CYCLE/2) clk = ~clk;
   always @(posedge clk) begin
      if(Buff_PC == 1'b0) laststage = 1'b0;
      else laststage = 1'b1;
   end
// Net, Variable
   integer i;
   reg [5:0] Ins;
   reg [15:8] OPM;
   reg [1:0] OPL;

// Instantiate the UUT
   Controller UUT (
		.Rst(Rst), 
		.PSW_NZC(PSW_NZC), 
		.InsM(InsM), 
		.InsL(InsL), 
		.clk(clk), 
      .Buff_PC(Buff_PC),
		.Branch(Branch), 
		.Jump(Jump), 
		.WE_MEM(WE_MEM), 
		.Buff_MEMIns(Buff_MEMIns), 
		.ALUorNot(ALUorNot), 
		.LIorMOV(LIorMOV), 
		.MEMresource(MEMresource), 
		.WE_RF(WE_RF), 
		.WBresource(WBresource), 
		.RBresource(RBresource), 
		.OprandB(OprandB), 
		.LI(LI), 
		.PCplus1orWB(PCplus1orWB), 
		.Buff_PSW(Buff_PSW), 
		.Flag(Flag), 
		.ALUop(ALUop), 
		.Done(Done)
   );
// Initialize Inputs
   initial begin
      #150
      Ins = 6'h01;
      OPM = 8'b00000000;
      OPL = 2'b00;
      Rst = 1'b1;
      repeat(2) @(posedge clk) #3;
      InsConvert(Ins, OPM, OPL);
      repeat(1) @(posedge clk) #3;
      Rst = 1'b0;

      PSW_NZC = 2'b00;
      for (i = 1; i < 6'h1D; i = i + 1) begin
         Ins = i;
         InsConvert(Ins, OPM, OPL);
         // Controller recieve Ins when Cnt == 3'b001
         @(posedge clk) #3;
         InsM = OPM[15:8];
         InsL = OPL[1:0];
         while (laststage == 1'b0) begin
            @(posedge clk) #3;
         end
      end
      $finish;
   end
// task
   task InsConvert;
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
