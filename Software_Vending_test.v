`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.09.2022 20:02:16
// Design Name: 
// Module Name: Software_Vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Software_Vending_test;

//inputs
reg clk;
reg[1:0] in;
reg rst;
reg[1:0] prod_name;

//output
wire[1:0] out;
wire[4:0] change;
wire[1:0] prod_count1;
wire[1:0] prod_count2;

module_3_mini uut(
.clk(clk),
.rst(rst),
.prod_name(prod_name),
.in(in),
.out(out),
.change(change),
.prod_count1(prod_count1),
.prod_count2(prod_count2)
);

initial begin
//initialise inputs
$dumpfile("module_3_mini.vcd");
$dumpvars(0,module_3_mini_test);
rst = 1;
clk = 1; 
#5//
rst = 0;
prod_name=1;
in = 2;
#5 //
in = 2;
#5 // 
prod_name=2;
in = 1;
#5 //
in = 2;
#5 //
in = 2;
#5 // 
in = 2;
#5 //
in = 2;
#5 // 
prod_name=1;
in = 1;
#5 //
in = 2;
#5 // 
in = 1;
#5 //
in = 2;
#5 // 
prod_name=2;
in = 2;
#5 //
in = 2;
#5 //
in=0; //end of transaction
#5
$finish; 
//Product 1 = 10+10
//Product 2 = 5+10+10
//	   = 10+10
//Product 1= 5+10
//	  = 5+10
//Product 2= 10+10

end
always #5 clk = ~clk;
endmodule
