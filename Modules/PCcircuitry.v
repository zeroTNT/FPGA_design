`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    PCcircuitry
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This module is used to calculate the next PC address.
// Dependencies: 
// PCFA2c.v, Mul16b2x1.v, Mul16b4x1.v
// Revision:
// Revision 2.0 - verified
//////////////////////////////////////////////////////////////////////////////////
module PCcircuitry(
	input [15:0] PC,
    input [10:0] Ins,
    input Branch,
    input [1:0] Jump,
    input [15:0] Rm,
    input [15:0] Rd,
    output [15:0] PCplus1_mul,
    output [15:0] nextPC
    );
    //=========== Internal signal ============//
	wire [15:0] PCBranch;	// PC branch

    wire [15:0] PCFA;       // PC full adder
	//========================================//
    
    //=============== PC + 1 =================//
    PCFA2c PCFA2c_0(
        .A(16'h0001),
        .B(PC),
        .Cin(1'b0),
        .Sum(PCplus1_mul)
    );
    //========================================//

    //============== PC Branch ===============//
    PCFA2c PCFA2c_1(
        .A(PC),
        .B({{8{Ins[7]}}, Ins[7:0]}), // sign extend
        .Cin(1'b0),
        .Sum(PCBranch)
    );
    //========================================//

    //============ Branch or not =============//
    Mul16b2x1 BranchOrNot(
        .addr(Branch),	        // address
        .D0(PCplus1_mul),		// data input 0
        .D1(PCBranch),			// data input 1
        .F(PCFA));			    // output data
    //========================================//

    //=========== Next PC choose =============//
    Mul16b4x1 NextPCchoose(
        .addr(Jump),			// address
        .D0(PCFA),				// data input 0
        .D1({PC[15:11], Ins}),	// data input 1
        .D2(Rm),				// data input 2
        .D3(Rd),				// data input 3
        .F(nextPC));			// output data
    //========================================//
endmodule
