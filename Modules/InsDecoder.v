`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    InsDecoder
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// 16-bit ripple carry adder
// Dependencies: 
//
// Revision:
// Revision 1.1 - not verified
//////////////////////////////////////////////////////////////////////////////////
module InsDecoder(
    input Rst,
    input [15:8] InsM,
    input [1:0] InsL,
    input [2:0] Cnt,
    input [1:0] PSW_NZC,

    output reg Branch,
    output reg [1:0] Jump,
    output reg Buff_PC,
    output reg MEMresource,
    output reg ALUorNot,
    output reg LIorMOV,
    output reg WE_MEM,
    output reg Buff_MEMIns,
    output reg OprandB,
    output reg RBresource,
    output reg WBresource,
    output reg LI,
    output reg PCplus1orWB,
    output reg WE_RF,
    output reg Flag,
    output reg ALUop,
    output reg Buff_PSW,
    output reg Done
    );
    //=============== Internal signal =============//
    reg branch_condition;
    reg sub_condition;
    reg PCplus1orWB_condition;
    reg OprandB_condition;
    reg RBresource_condition1, RBresource_condition2;
    reg WE_RF_condition1, WE_RF_condition2;
    reg Buff_PC_condition1, Buff_PC_condition2, Buff_PC_condition3, Buff_PC_condition4;
    //=============================================//

    // Jump
    always @(*) begin
        if( (Rst == 0) && (InsM[15:12]==4'b1001) ) Jump[1] = 1'b1;
        else Jump[1] = 1'b0;
    end
    always @(*) begin
        if( (Rst == 0) && ((InsM[15:11]==5'b10011)||(InsM[15:11]==5'b10000)) ) Jump[0] = 1'b1;
        else Jump[0] = 1'b0;
    end

    //Branch
    always @(*) begin
        branch_condition = InsM[11] | (InsM[8] ^ ( (PSW_NZC[1] & (~InsM[9])) | (PSW_NZC[0] & InsM[9]) ));
        if(Rst == 0) Branch = 1'b0;
        else begin
            Branch = ( {InsM[15:12], branch_condition} == 5'b11001 ) || (InsM[15:11] == 5'b10001);
        end
    end

    //ALUop
    always @(*) begin
        // SUBI || CMP || (SUB || SBB)
        sub_condition = ({InsM[15:14], InsM[11]} == 3'b010) || ({InsM[15:11], InsL[1:0]} == 7'b0011001) || ({InsM[15:11], InsL[1]} == 6'b000001);
        if ({Rst, Cnt[2:0], sub_condition}==5'b00101) ALUop = 1'b1;
        else ALUop = 1'b0;
    end

    //Flag
    always @(*) begin
        if({Rst, Cnt[2:0], InsM[15:11], InsL[0]} == 15'b0010_00000_1) Flag = 1'b1;
        else Flag = 1'b0;
    end

    //PCplus1orWB
    always @(*) begin
        PCplus1orWB_condition = ~(InsM[15:11] == 5'b11100);
        if({Rst, Cnt[2:0], PCplus1orWB_condition} == 5'b01001) PCplus1orWB = 1'b1;
        else PCplus1orWB = 1'b0;
    end

    //LI
    always @(*) begin
        if({Rst, Cnt[2:0], InsM[15:11]} == 9'b0001_00001) LI = 1'b1;
        else LI = 1'b0;
    end

    //OprandB
    always @(*) begin
        OprandB_condition = (InsM[15:11] == 5'b01000) || ({InsM[15:14], InsM[12:11]} == 4'b0011) || ({InsM[15:13], InsM[11]} == 4'b0011);
        if({Rst, Cnt[2:0], OprandB_condition} == 5'b0001_1) OprandB = 1'b1;
        else OprandB = 1'b0;
    end

    //RBresource
    always @(*) begin
        RBresource_condition1 = (InsM[15:11] == 5'b00001) || (InsM[15:11] == 5'b 10011);
        RBresource_condition2 = (InsM[15:11] == 5'b00101) || ({InsM[15:11], InsL[1:0]} == 7'b00110_00);
        case (Cnt)
            3'b001: RBresource = (Rst? 1'b0 : RBresource_condition1);
            3'b010: RBresource = (Rst? 1'b0 : RBresource_condition2);
            default: RBresource = 1'b0;
        endcase
    end

    //WE_RF
    always @(*) begin
        WE_RF_condition1 = (~(InsM[15:11] == 5'b11100)) && (Cnt[2:0] == 3'b100);
        WE_RF_condition2 = ( (InsM[15:11] == 5'b10010) || (InsM[15:11] == 5'b10001) ) && (Cnt[2:0] == 3'b001);
        if (Rst) WE_RF = 1'b0;
        else WE_RF = WE_RF_condition1 || WE_RF_condition2;
    end

    //WBresource
    always @(*) begin
        if( ({Rst, Cnt[2:0]} == 4'b0100) && ( (InsM[15:11] == 5'b00011) || (InsM[15:11] == 5'b00100) ) )WBresource = 1'b1;
        else WBresource = 1'b0;
    end

    //Buff_PC
    always @(*) begin
        Buff_PC_condition1 = ({InsM[15:11], InsL[0]} == 6'b111000) || ({InsM[15], InsM[13]} == 2'b 10);
        Buff_PC_condition2 = ({InsM[15:11], InsL[1:0]} == 7'b00110_01);
        Buff_PC_condition3 = ({InsM[15:11], InsL[1:0]} == 7'b00110_00) || (InsM[15:11] == 5'b00101);
        Buff_PC_condition4 = (InsM[15:13] == 3'b000) || (InsM[15:11] == 5'b00100) || (InsM[15:13] == 3'b010) || (InsM[15:13] == 3'b111);
        if(Rst) Buff_PC = 1'b0;
        else begin
            case (Cnt)
                3'b001: Buff_PC = Buff_PC_condition1;
                3'b010: Buff_PC = Buff_PC_condition2;
                3'b011: Buff_PC = Buff_PC_condition3;
                3'b100: Buff_PC = Buff_PC_condition4;
                default: Buff_PC = 1'b0;
            endcase
        end
    end

    //Buff_PSW
    always @(*) begin
        if ({Rst, Cnt[2:0]} == 4'b0010) begin
            case(InsM[15:11])
                5'b00000: Buff_PSW = 1'b1;
                5'b00111: Buff_PSW = 1'b1;
                5'b01000: Buff_PSW = 1'b1;
                5'b00110: Buff_PSW = InsL[0] & (~InsL[1]);
                default: Buff_PSW = 1'b0;
            endcase
        end else begin
            Buff_PSW = 1'b0;
        end
    end

    //Buff_MEMIns
    always @(*) begin
        Buff_MEMIns = Rst || (Cnt[2:0] == 3'b000);
    end

    //WE_MEM
    always @(*) begin
        if({Rst, Cnt[2:0]} == 4'b0011) begin
            case (InsM[15:11])
                5'b00101: WE_MEM = 1'b1;
                5'b00110: WE_MEM = ~|(InsL);
                default: WE_MEM = 1'b0;
            endcase
        end
        else WE_MEM = 1'b0;
    end

    //LIorMOV
    always @(*) begin
        LIorMOV = (InsM[15:11] == 5'b01011) && (Cnt[2:0] == 3'b100) && (Rst == 1'b0);
    end

    //ALUorNot
    always @(*) begin
        if({Rst, Cnt[2:0]} == 4'b0011) begin
            case (InsM[15:11])
                5'b00001: ALUorNot = 1'b1;
                5'b00010: ALUorNot = 1'b1;
                5'b01011: ALUorNot = 1'b1;
                default: ALUorNot = 1'b0;
            endcase
        end else ALUorNot = 1'b0;
    end

    //MEMresource
    always @(*) begin
        if({Rst, Cnt[2:0]} == 4'b0011) begin
            case (InsM[15:11])
                5'b00011: MEMresource = 1'b1;
                5'b00100: MEMresource = 1'b1;
                5'b00101: MEMresource = 1'b1;
                5'b00110: MEMresource = &(InsL);
                default: MEMresource = 1'b0;
            endcase
        end else MEMresource = 1'b0;
    end

    //Done
    always @(*) begin
        Done = (Rst == 1'b0) && (Cnt[2:1] == 2'b01) && (InsM[15:11] == 5'b11100) && (InsL[1:0] == 2'b01);
    end
endmodule
