`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Taiwan University of Science and Technology
// Engineer: Zong-Yu Wang
// Create Date:    11:53:10 04/22/2025 
// Design Name:    Simplified Multicycle 16-bit RISC-V Processor
// Module Name:    Memory256x16
// Project Name:   MulticycleRISC_verilog
// Target Devices: Xilix Virtex6 XC6VLX75T-FF484
// Tool versions:  ISE 14.7 Webpack
// Description: 
// This tool is annoying, not such convenience.
// Dependencies: 
// Mul8b2x1.v, Mul16b2x1.v, Mul2x1.v, Decoder3x8.v, Mul16b8x1.v
// Revision: 
// Revision 2.0 - verified
// Additional Comments: 
// The memory modules(RAM32X8S) are introduced from the Xilinx library.
//////////////////////////////////////////////////////////////////////////////////
module Memory256x16(
	input clk_n,				// clock
	input Tbornot,			// Test-mode or not
	input [7:0] Addr_tb,	// Test-mode address
	input [15:0] Data_tb,	// Test-mode data
	input WE_tb,			// Test-mode write enable
	input [7:0] Addr_pc,	// Normal-mode address
	input [15:0] Data_pc,	// Normal-mode data
	input WE_pc,			// Normal-mode write enable
	output [15:0] MemOut	// Memory output
	);
	//=========== Internal signal ============//
	wire [7:0] addr;		// address
	wire [15:0] Data;		// data
	wire WE;				// write enable

	wire [7:0] WEtarget;	// write enable target

	wire [15:0] Q [0:7];	// memory output
	wire clk;
	assign clk = ~clk_n;	// clock signal
	//========================================//

	//============= Mode Choose ==============//
	Mul8b2x1 Addr_choose(	// address choose
		.addr(Tbornot),			// address
		.D0(Addr_pc),			// data input 0
		.D1(Addr_tb),			// data input 1
		.F(addr));				// output data
	Mul16b2x1 Data_choose(	// data choose
		.addr(Tbornot),			// address
		.D0(Data_pc),			// data input 0
		.D1(Data_tb),			// data input 1
		.F(Data));				// output data
	Mul2x1 WE_choose(		// write enable choose
		.addr(Tbornot),			// address
		.I0(WE_pc),				// data input 0
		.I1(WE_tb),				// data input 1
		.O(WE));			// output data
	//========================================//

	//========= Write Enable Decoder==========//
	Decoder3x8 WE_decoder(	// write enable decoder
		.I(addr[7:5]),		// address
		.Enable(WE),			// enable
		.O(WEtarget));			// output data
	//========================================//

	//============= Memory body ==============//
	genvar i;
	generate
		for (i = 0; i < 8; i = i + 1) begin: genMem
			// memory module introduced from Xilinx library
			RAM32X8S #( .INIT_00(32'h00000000), .INIT_01(32'h00000000), .INIT_02(32'h00000000), .INIT_03(32'h00000000), 
				.INIT_04(32'h00000000), .INIT_05(32'h00000000), .INIT_06(32'h00000000), .INIT_07(32'h00000000)
				) MEM_Group_low(.A0(addr[0]), .A1(addr[1]), .A2(addr[2]), .A3(addr[3]), .A4(addr[4]), 
					.D(Data[7:0]), .WCLK(clk), .WE(WEtarget[i]), .O(Q[i][7:0]));
			RAM32X8S #( .INIT_00(32'h00000000), .INIT_01(32'h00000000), .INIT_02(32'h00000000), .INIT_03(32'h00000000), 
				.INIT_04(32'h00000000), .INIT_05(32'h00000000), .INIT_06(32'h00000000), .INIT_07(32'h00000000)
				) MEM_Group_high(.A0(addr[0]), .A1(addr[1]), .A2(addr[2]), .A3(addr[3]), .A4(addr[4]), 
					.D(Data[15:8]), .WCLK(clk), .WE(WEtarget[i]), .O(Q[i][15:8]));
		end
	endgenerate
	//========================================//

	//=========== Memory Output ==============//
	Mul16b8x1 MemOut_choose(	// memory output choose
		.addr(addr[7:5]),			// address
		.D0(Q[0]),					// data input 0
		.D1(Q[1]),					// data input 1
		.D2(Q[2]),					// data input 2
		.D3(Q[3]),					// data input 3
		.D4(Q[4]),					// data input 4
		.D5(Q[5]),					// data input 5
		.D6(Q[6]),					// data input 6
		.D7(Q[7]),					// data input 7
		.OutData(MemOut));				// output data
	//========================================//
endmodule
