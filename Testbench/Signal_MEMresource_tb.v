// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/Signal_MEMresource.sch - Sat Apr  5 11:30:56 2025

`timescale 1ns / 1ps
`define CYCLE_TIME 50.0
module Signal_MEMresource_Signal_MEMresource_sch_tb();

// Inputs
   reg [15:11] InsM;
   reg [1:0] InsL;
   reg [2:0] Cnt;
   reg Rst;

// Output
   wire MEMresource;

// Parameters
   parameter [5:0]   LHI = 6'h01, LLI = 6'h02, LDRri = 6'h03, LDRrr = 6'h04, STRri = 6'h05, STRrr = 6'h06,
                     ADD = 6'h07, ADC = 6'h08, SUB = 6'h09, SBB = 6'h0A, CMP = 6'h0B,
                     ADDI = 6'h0C, SUBI = 6'h0D, MOV = 6'h0E,
                     BCC = 6'h0F, BCS = 6'h10, BEQ = 6'h11, BNE = 6'h12, BAL = 6'h13,
                     JMP = 6'h14, JALrl = 6'h15, JALrr = 6'h16, JR = 6'h17,
                     OutR = 6'h18, HLT = 6'h19;
   
// Clock
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
   always @(posedge clk) begin
      #3
      if(Cnt == 3'b0) begin
         InsM = OPM[15:11];
         InsL = OPL[1:0];
      end
      else begin
         InsM = InsM;
         InsL = InsL;
      end
   end
   initial Cnt = 3'b000;
   always @(posedge clk) begin
      #3 
      if(Buff_PC == 1'b1) Cnt = 3'b000;
      else Cnt = Cnt + 1;
   end

// Instantiate the UUT
   Signal_MEMresource UUT (
      .Rst(Rst),
		.InsM(InsM), 
		.Cnt(Cnt), 
		.InsL(InsL), 
		.MEMresource(MEMresource)
   );
   Signal_Buff_PC PCSignal (
      .Rst(Rst), 
		.Cnt(Cnt), 
		.InsM(InsM), 
		.InsL(InsL), 
		.Buff_PC(Buff_PC)
   );
// Initialize Inputs
   initial begin
      #150
      Ins = 6'b000000;
      OPM = 8'b00000000;
      OPL = 2'b00;
      Rst = 1'b1;
      repeat(2) @(posedge clk) #3;
      InsConvert(Ins, OPM, OPL);
      repeat(1) @(posedge clk) #3;
      Rst = 1'b0;
      for (i = 1; i < 6'h1D; i = i + 1) begin
         Ins = i;
         InsConvert(Ins, OPM, OPL);
         // Controller recieve Ins when Cnt == 3'b001
         @(posedge clk) #3;
         InsM = OPM[15:11];
         InsL = OPL[1:0];
         while (Buff_PC == 1'b0) begin
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
