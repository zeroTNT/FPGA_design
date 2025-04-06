// Verilog test fixture created from schematic /home/ise/VMShare/MulticycleRISC/CompleteComputer.sch - Sun Apr  6 08:20:33 2025

`timescale 1ns / 1ps
`define CYCLE_TIME  50.0
module CompleteComputer_CompleteComputer_sch_tb();

// Inputs
   reg clk;
   reg Rst;
   reg [15:0] Tb_MEMData;
   reg [7:0] Tb_MEMAddr;
   reg Tb_MEMWE;
   reg TBorNot;

// Output
   wire Done;
   wire [15:0] OutNextPC;
   wire [15:0] OutReg;
   wire [15:0] OutPC;
   wire [15:0] OutMEM;
   wire [2:0] OutPSW_NZC;

// Net, Variable

// Clock
	real CYCLE = `CYCLE_TIME;
	initial clk = 1'b0;
	always #(CYCLE/2) clk = ~clk;

// Instantiate the UUT
   CompleteComputer UUT (
      .Done(Done),
		.OutNextPC(OutNextPC), 
		.OutReg(OutReg), 
		.OutPC(OutPC), 
		.OutMEM(OutMEM), 
		.clk(clk), 
		.Rst(Rst), 
		.Tb_MEMData(Tb_MEMData), 
		.Tb_MEMAddr(Tb_MEMAddr), 
		.Tb_MEMWE(Tb_MEMWE), 
		.TBorNot(TBorNot), 
		.OutPSW_NZC(OutPSW_NZC)
   );

// Initialize Inputs
   initial begin
      ResetProcess;
      // Initialize data in memory
      WriteMEM(8'h80, 16'h0001); // MEM[h80] = h1  = d1
      WriteMEM(8'h81, 16'h0021); // MEM[h81] = h21 = d33
      WriteMEM(8'h82, 16'h00A0); // MEM[h82] = hA0 = d160
      WriteMEM(8'h83, 16'h000D); // MEM[h83] = hD  = d13
      WriteMEM(8'h84, 16'h0700); // MEM[h84] = h700= d1792
      // Assembly code
      LLI(8'h00, 3'd1, 8'h80); // R1 = h80
      LLI(8'h01, 3'd2, 8'h01); // R2 = h01
      LDRri(8'h02, 3'd3, 3'd1, 5'b00000); // R3 = MEM[R1 + 0] = MEM[h80] = h1
      LDRrr(8'h03, 3'd4, 3'd1, 3'd2); // R4 = MEM[R1 + R2] = MEM[h80 + h01] = MEM[h81] = h21
      SUB(8'h04, 3'd5, 3'd3, 3'd4); // R5 = R4 - R3 = h1 - h21 = hFFE0; N = 1;
      OutR(8'h05, 3'd3); // OutR = R3 = h1
      OutR(8'h06, 3'd4); // OutR = R4 = h21
      OutR(8'h07, 3'd5); // OutR = R5 = hFFE0
      HLT(8'h08); // HLT
      // Wait for computer done
      wait(Done);
      #100;
      $display("Test Complete");
      $display("OutR = %h", OutR);
      #10;
      $finish;
   end
   initial #10000 $finish;
// Task
   task ResetProcess;
		begin
			Rst = 1'b0;
         Tb_MEMAddr = 0;
         Tb_MEMData = 0;
         Tb_MEMWE = 1'b0;
         TBorNot = 1'b0;
         @(posedge clk) #3 Rst = 1'b1;
			repeat (3) @(posedge clk) #3;
         Rst = 1'b0;
		end
	endtask
   task WriteMEM; // WriteMEM addr8, data16
      input [7:0] Writeaddr;
      input [15:0] Writedata;
      begin
         Tb_MEMAddr = Writeaddr;
         Tb_MEMData = Writedata;
         Tb_MEMWE = 1'b1;
         @(posedge clk) #3;
         Tb_MEMWE = 1'b0;
      end
   endtask
   task ReadMEM; // ReadMEM addr8
      input [7:0] Readaddr;
      begin
         Tb_MEMAddr = Readaddr;
         Tb_MEMWE = 1'b0;
         @(posedge clk) #3;
      end
   endtask
	task LHI; // LHI Rd, imm8
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {5'b00001, Rd, imm8});
   endtask
   task LLI; // LLI Rd, imm8
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {5'b00010, Rd, imm8});
   endtask
   task LDRri; // LDR Rd, Rm, imm5
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [4:0] imm5;
      WriteMEM(MEMaddr, {5'b00011, Rd, Rm, imm5});
   endtask
   task LDRrr; // LDR Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00100, Rd, Rm, Rn, 2'b00});
   endtask
   task STRri; // STR Rd, Rm, imm5
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [4:0] imm5;
      WriteMEM(MEMaddr, {5'b00101, Rd, Rm, imm5});
   endtask
   task STRrr; // STR Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00110, Rd, Rm, Rn, 2'b00});
   endtask
   task ADD; // ADD Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00000, Rd, Rm, Rn, 2'b00});
   endtask
   task ADC; // ADC Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00000, Rd, Rm, Rn, 2'b01});
   endtask
   task SUB; // SUB Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00000, Rd, Rm, Rn, 2'b10});
   endtask
   task SBB; // SUB Rd, Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00000, Rd, Rm, Rn, 2'b11});
   endtask
   task CMP; // CMP Rm, Rn
      input [7:0] MEMaddr;
      input [2:0] Rm;
      input [2:0] Rn;
      WriteMEM(MEMaddr, {5'b00110, 3'b0, Rm, Rn, 2'b01});
   endtask
   task ADDI; // ADDI Rd, Rm, imm5
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [4:0] imm5;
      WriteMEM(MEMaddr, {5'b00111, Rd, Rm, imm5});
   endtask
   task SUBI; // SUBI Rd, Rm, imm5
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      input [4:0] imm5;
      WriteMEM(MEMaddr, {5'b01000, Rd, Rm, imm5});
   endtask
   task MOV; // MOV Rd, Rm
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      WriteMEM(MEMaddr, {5'b01011, Rd, Rm, 5'b0});
   endtask
   task BCC; // BCC label8
      input [7:0] MEMaddr;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {8'b1100_0011, imm8});
   endtask
   task BCS; // BCS label8
      input [7:0] MEMaddr;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {8'b1100_0010, imm8});
   endtask
   task BNE; // BNE label8
      input [7:0] MEMaddr;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {8'b1100_0001, imm8});
   endtask
   task BEQ; // BEQ label8
      input [7:0] MEMaddr;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {8'b1100_0000, imm8});
   endtask
   task BAL; // BAL label8
      input [7:0] MEMaddr;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {8'b1100_1110, imm8});
   endtask
   task JMP; // JMP label11
      input [7:0] MEMaddr;
      input [10:0] imm10;
      WriteMEM(MEMaddr, {5'b10000, imm10});
   endtask
   task JALrl; // JAL Rd, label8
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [7:0] imm8;
      WriteMEM(MEMaddr, {5'b10001, Rd, imm8});
   endtask
   task JALrr; // JAL Rd, Rm
      input [7:0] MEMaddr;
      input [2:0] Rd;
      input [2:0] Rm;
      WriteMEM(MEMaddr, {5'b10010, Rd, Rm, 5'b0});
   endtask
   task JR; // JR Rd
      input [7:0] MEMaddr;
      input [2:0] Rd;
      WriteMEM(MEMaddr, {5'b10011, Rd, 8'b0});
   endtask
   task OutR; // OutR Rm
      input [7:0] MEMaddr;
      input [2:0] Rm;
      WriteMEM(MEMaddr, {5'b11100, 3'b0, Rm, 3'b0, 2'b00});
   endtask
   task HLT; // HLT
      input [7:0] MEMaddr;
      WriteMEM(MEMaddr, {5'b11100, 9'b0, 2'b01});
   endtask
endmodule
