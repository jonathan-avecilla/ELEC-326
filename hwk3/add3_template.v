//  1-bit Half Adder
 module ha(input wire a, b, output wire S, Cout); 
   assign S = a ^ b;
   assign Cout = a & b;
endmodule


// 1_bit Full Adder
 module fa(input wire a, b, c, output wire S, Cout); 
   assign S = a ^ b ^ c;
   assign Cout = a&b | b&c | c&a;
endmodule // fa

/* ******************************************************************* */

module rca(input wire [3:0] x, y, input wire cin, output wire [3:0] SUM, output wire C);
/*  
   4-bit unsigned Ripple-Carry Adder: SUM = (x+y)mod 16 and carry C = (x+y)/16. 
   Instantiate 4 Full Adder (fa) modules and wire them together.
   Do not use any arithmetic or logical operators.
*/

 endmodule // rca

/* ******************************************************************* */

 module rc3(input wire [3:0] x, y,  z, output wire [5:0] SUM);

/*
  Module to add 3 4-bit operands x, y, z using ripple-carry addition.
  Use only 2 4-bit Ripple Carry Adder (rca)  modules and 1 Half Adder module (ha).
  Do not use any arithmetic or logical operators.
*/

endmodule // rc3

/* ******************************************************************* */
