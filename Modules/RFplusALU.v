`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    RFplusALU
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// Connection between RegisterFile.v and FA16b2c.v
// Dependencies: 
// RegisterFile.v, FA16b2c.v, Mul16b2x1.v, Reg16bClkEn.v, Reg16bClkEnR.v
// Revision: 
// Revision 2.1 - verified, Add Buff_OutR
// Additional Comments: 
// 
//////////////////////////////////////////////////////////////////////////////////
module RFplusALU(
    input clk,
    input Reset,
    input WBRF,
    input WBresource,
    input RBresource,
    input OprandB,
    input LI,
    input Buff_OutR,
    input ALUop,
    input Flag,
    input PSW_C,
    input [10:0] Ins,
    input [15:0] WBData,
    input [15:0] MEMData,

    output [15:0] Rm,
    output [15:0] Rd,
    output [15:0] Sum,
    output [15:0] OutR_EXE,
    output C,
    output Z,
    output N,
    output [15:0] LI_EXE,
    output [15:0] OutR);

    wire clk_n = ~clk;

    wire [2:0] RB_addr;
    Mul3b2x1 M1(
        .addr(RBresource),
        .D0(Ins[4:2]),
        .D1(Ins[10:8]),
        .F(RB_addr)
    );
    
    wire [15:0] Data_Write;
    Mul16b2x1 M2(
        .addr(WBresource),
        .D0(WBData),
        .D1(MEMData),
        .F(Data_Write)
    );

    wire [15:0] AData;
    wire [15:0] BData;
    RegisterFile RF(
        .clk_n(clk),
        .WE(WBRF),
        .Waddr(Ins[10:8]),
        .Wdata(Data_Write),
        .Aaddr(Ins[7:5]),
        .Baddr(RB_addr),
        .Adata(AData),
        .Bdata(BData)
    );
	assign Rm = AData;
    assign Rd = BData;

    wire [15:0] ALUinB;
    Mul16b2x1 M3(
        .addr(OprandB),
        .D0(BData),
        .D1({10'b0, Ins[4:0]}),
        .F(ALUinB)
    );

    wire [15:0] LI_EXEbuffer;
    Mul16b2x1 M4(
        .addr(LI),
        .D0({8'b0, Ins[7:0]}),
        .D1({Ins[7:0], BData[7:0]}),
        .F(LI_EXEbuffer)
    );

    //============= ID/EXE Reg ===============//
    wire [15:0] oprandA_EXE;

    Reg16bClkEnR R1(
        .clk_n(clk_n),
        .clk_en(Buff_OutR),
        .rst(Reset),
        .D(AData),
        .Q(OutR)
    );
    Reg16bClkEn R1_2(
        .clk_n(clk_n),
        .clk_en(1'b1),
        .D(AData),
        .Q(oprandA_EXE)
    );
    assign OutR_EXE = oprandA_EXE;
    wire [15:0] oprandB_EXE;
    Reg16bClkEn R2(
        .clk_n(clk_n),
        .clk_en(1'b1),
        .D(ALUinB),
        .Q(oprandB_EXE)
    );
    Reg16bClkEn R3(
        .clk_n(clk_n),
        .clk_en(1'b1),
        .D(LI_EXEbuffer),
        .Q(LI_EXE)
    );
    //========================================//
    FA16b2c FA(
        .A(oprandA_EXE),
        .B(oprandB_EXE),
        .Flag(Flag),
        .PSW_C(PSW_C),
        .ALUop(ALUop),
        .Sum(Sum),
        .Cout(C),
        .Z(Z),
        .N(N)
    );
endmodule
