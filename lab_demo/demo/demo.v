/*
 * Module: demo
 * Description: Introduction to Vivado demo
 */
module demo(
	input [7:0] SW,
	output [15:0] LED
);
   assign LED[7:0] =  SW[7:0];
   assign LED[15:8] =  ~SW[7:0];
endmodule // demo

