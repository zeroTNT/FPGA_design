// File: PATTERN_Decoder3x8.v
// Generated with: v1.0.0
// Last update: 2025-02-20 21:09
//###########################################################################
// Design unit: PATTERN_Decoder3x8
//###########################################################################
// Purpose: This module is a 3x8 decoder that generates a pattern based on the input address.
//###########################################################################
`define CYCLE_TIME 20.0
`define INPUT_PATTERN_PATH ""
`define OUTPUT_PATTERN_PATH ""

module PATTERN_Decoder3x8 (
    Outpattern,
    address
);
//===========================================================================
//                             Declarations
//===========================================================================
// Signals declaration
output reg [2:0] address;
input [7:0] Outpattern;
// Parameter & Intergers declaration
integer PATNUM = 8;
integer patcount;
integer input_file, output_file;
integer i, j;
// wire & registers declaration
reg [2:0] golden_address;
reg [7:0] golden_Outpattern;

//===========================================================================
//                             Clock
//===========================================================================

reg clk;
real CYCLE = `CYCLE_TIME;
always #(CYCLE/2) clk = ~clk;
initial clk = 0;


//===========================================================================
//                             initial block
//===========================================================================
initial begin
    input_file = $fopen(`INPUT_PATTERN_PATH, "r");
    output_file = $fopen(`OUTPUT_PATTERN_PATH, "r");

    address = 'bx;
    repeat(5) @(negedge clk);
    i = $fscanf(input_file, "%d", PATNUM);
    for (patcount = 0; patcount < PATNUM; patcount = patcount + 1) begin
        input_task;
        repeat(1) @(negedge clk);
        check_ans;
        repeat($urandom_range(3, 5)) @(negedge clk);
    end
    display_pass;
    repeat(3) @(negedge clk);
    $finish;
end

//===========================================================================
//                             Task
//===========================================================================
task input_task; begin
    for ( i = 0; i < 1; i=i+1) begin
        j = $fscanf(input_file, "%d", golden_address[i]);
    end
    address = {golden_address};
end
endtask

task check_ans; begin
    for( i=0; i<8; i=i+1) begin
        j = $fscanf(output_file,"%b", golden_Outpattern[i]);
    end
    if(Outpattern !== golden_Outpattern) begin
        $display ("-------------------------------------------------------------------");
		$display ("*                            PATTERN NO.%4d 	                      ", patcount);
        $display ("Output should be : %b%b%b%b%b%b%b%b , your answer is : %b%b%b%b%b%b%b%b",
                    golden_Outpattern[0], golden_Outpattern[1], golden_Outpattern[2], golden_Outpattern[3],
                    golden_Outpattern[4], golden_Outpattern[5], golden_Outpattern[6], golden_Outpattern[7],
                    Outpattern[0], Outpattern[1], Outpattern[2], Outpattern[3],
                    Outpattern[4], Outpattern[5], Outpattern[6], Outpattern[7]);
        $display ("-------------------------------------------------------------------");
        #(100);
        $finish ;
    end
    else $display ("             \033[0;32mPass Pattern NO. %d\033[m         ", patcount);
end endtask
task display_pass; begin
    $display ("-------------------------------------------------------------------");
    $display ("*                         All Patterns Passed                     *");
    $display ("-------------------------------------------------------------------");
end endtask
endmodule