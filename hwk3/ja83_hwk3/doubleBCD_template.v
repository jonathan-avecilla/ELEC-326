// Conditional Add3 module

module cAdd3(input wire [3:0] x, output wire [3:0] Y);

// Input: 4-bit wire "x" (representing a BCD digit)
// Output: 4-bit wire "Y" 
   
//  Increment x by 3 if it is 5 or greater.
//  Use a single continuous assignment statement.
//  The Veriog comparison  operators are : ==, !=, >, <, >=, <=

	assign Y = (x == 4'b0101) ? 4'b1000 : 
		   (x == 4'b0110) ? 4'b1001 : 
                   (x == 4'b0111) ? 4'b1010 :
		   (x == 4'b1000) ? 4'b1011 :
	   	   (x == 4'b1001) ? 4'b1100 : x;

endmodule 

/* ********************************************************************* */

module doubleBCD(input wire [11:0] a, output wire [11:0] B);
  
// Input:  12-bit wire "a" representing BCD integer  between 0 and 499.
// Output: 12 bit wire "B" representing BCD integer  "2 x a". 
   
// Note: There is no overflow as long as the input is less than 500.
// METHOD: Instantiate 3 "cAdd3" modules. Wire up the modules using any glue logic needed.

	cAdd3 cadd3_0 (a[3:0], B[4:1]);
	cAdd3 cadd3_1 (a[7:4], B[8:5]);
	cAdd3 cadd3_2 (a[11:8], {B[0],B[11:9]});
   
endmodule 

/* ********************************************************************* */


