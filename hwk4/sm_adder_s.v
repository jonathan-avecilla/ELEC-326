module unsigned_adder(x,y,cin, Sum,Cout);  // Parameterized Unsigned Adder
   parameter n = 8;
   input wire [n-1:0] x, y;
   input wire 	       cin;
   output wire [n-1:0] Sum;
   output  wire       Cout;
   assign {Cout, Sum} = x + y + cin;
endmodule // unsigned_adder

module comparator(x,y, EQ,GT);  // Parametrized Comparator
   parameter n = 8;
   input wire [n-1:0] x, y;     // input n-bit unsigned binary integers
   output wire EQ, GT;   
   assign EQ = (x == y) ? 1'b1: 1'b0;
   assign GT = (x > y) ? 1'b1: 1'b0;
endmodule // comparator

module mux2(c,a,b, X); // Parameterized 2:1 MUX
   parameter n = 1;
   input wire c;
   input wire [n-1:0] a, b;
   output wire [n-1:0] X;
   assign X = c ? a : b;
endmodule // mux2

   
module sm_adder(a,b, SUM,OVFLW);
   input wire [4:0]  a, b;   // 5-bit input signals in sign-magnitude representation 
   output wire [4:0]  SUM;    // 5-bit sum in sign-magnitude representation
   output wire 	    OVFLW;   //1-bit overflow flag if result has overflows

   // Instantiate the modules defined above as required by your schematic.
   // Dont forget to set the parameter during instantiation
   // Glue the outputs and inputs of modules together using simple assign statements to implement gate logic.
 
   wire EQ, GT;
   wire sign;
   wire [7:0] OUT_GT;
   wire [7:0] OUT_ADDER;
   wire cout;
   wire previous;
   wire zero;
	
   // These three lines of codes set up the sign
   comparator	  # (4)	COM1(a[3:0],b[3:0],EQ,GT);
   assign sign = a[4]^b[4];
   assign previous = ((~EQ&((~a[4]&b[4]&~GT)|(a[4]&~b[4]&GT)))|(a[4]&b[4]));
   
   // Now, we can focus on the addition and substraction
   mux2 # (8) MUX_GT(GT, {a[3:0],~(b[3:0])}, {~(a[3:0]),b[3:0]},OUT_GT);
   mux2 # (8) MUX_SIGN(sign, OUT_GT, {a[3:0],b[3:0]}, OUT_ADDER);

   unsigned_adder # (4) SUM1(OUT_ADDER[7:4],OUT_ADDER[3:0],sign,SUM[3:0],cout);
   assign zero = SUM[3]|SUM[2]|SUM[1]|SUM[0];
   assign OVFLW = cout&(((~a[4])&~(b[4]))|(a[4]&b[4]));
   assign SUM[4] = zero&previous;

endmodule // sm_adder


//***************************************************************************************/ 
module sm_adder_testbench;                   // Testbench program will exercise your design with input test vectors

   reg [4:0] p, q;                     
   wire [4:0] S; 
   wire	      OV;
   
   sm_adder  mySmAdder(p, q, S, OV);   

   
   initial begin
	   p = 5'b00000; 
	   q = 5'b00000;    
	   $display("*************************************"); 
	   $display("Time\tp   q\t\tS   OV\n");
   end
   
   integer i, j;  // Regular program variable used here for sequencing
	 
   always @(*) begin
		for (i=0; i < 32; i= i+1)
		  begin
			for (j=0; j < 32; j = j+1)
			  begin
				#1;   // Delay for 1 time unit
				$display("%3d\t%s%d   %s%d\t\t%s%d   %b", $time, p[4] ? "-" : "+", p[3:0], q[4] ? "-":"+", q[3:0], S[4] ? "-":"+", S[3:0], OV);
				{p, q} = {p, q} + 1;  // Cycle through the assigments
			end
		end
		$finish;
   end
endmodule // sm_adder_testbench






