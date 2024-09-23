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
	wire [2:0] t;

	fa fa_0 (x[0], y[0], cin,  SUM[0], t[0]);
	fa fa_1 (x[1], y[1], t[0], SUM[1], t[1]);
	fa fa_2 (x[2], y[2], t[1], SUM[2], t[2]);
	fa fa_3 (x[3], y[3], t[2], SUM[3], C);


 endmodule // rca

/* ******************************************************************* */

 module rc3(input wire [3:0] x, y, z, output wire [5:0] SUM);

/*
  Module to add 3 4-bit operands x, y, z using ripple-carry addition.
  Use only 2 4-bit Ripple Carry Adder (rca)  modules and 1 Half Adder module (ha).
  Do not use any arithmetic or logical operators.
*/
	wire [3:0] t;
	wire ov1;
	wire ov2;

	rca rca_1 (x, y, 1'b0, t, ov1);
	rca rca_2 (t, z, 1'b0, SUM[3:0], ov2);
	ha ha_0 (ov1, ov2, SUM[4], SUM[5]);

endmodule // rc3

/* ******************************************************************* */
