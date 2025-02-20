// File: TESTBED.v
// Generated with: v1.0.0
// Last update: 2025-02-20 21:09
//###########################################################################
// Design unit: TESTBED
//###########################################################################
// Purpose: This module is a test bench for the PATTERN_Decoder3x8 module.
//###########################################################################
`include "PATTERN_Decoder3x8.v"
`include "Decoder3x8.v"
module TESTBED ();
    
// Declare signals
wire [2:0] address;
wire [7:0] pattern;

// Instantiate the unit under test
PATTERN_Decoder3x8 stimulus (
    .Outpattern(pattern),
    .address(address)
);

// Instantiate the stimulus generator
Decoder3x8 DUT (
    .address(address),
    .Outpattern(pattern)
);

// waveforms
initial begin
    $fsdbDumpfile("TESTBED.fsdb");
    $fsdbDumpvars(0, "+mda");
    $fsdbDumpvars();
    #1000 $finish;
end
endmodule