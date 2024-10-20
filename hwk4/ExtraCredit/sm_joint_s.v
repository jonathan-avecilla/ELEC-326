module unsigned_adder(x, y, cin, Sum, Cout);  // Parameterized Ripple Carry Adder
   parameter n = 8;
   input wire [n-1:0] x, y;
   input wire 	    cin;
   output wire [n-1:0] Sum;
   output  wire      Cout;
   assign {Cout, Sum} = x + y + cin;
endmodule // unsigned_adder

module comparator(x, y, EQ, GT);  // Parametrized Comparator
   parameter n = 8;
   input wire [n-1:0] x, y;     // input n-bit unsigned binary integers
   output wire EQ, GT;   
   assign EQ = (x == y) ? 1'b1: 1'b0;
   assign GT = (x > y) ? 1'b1: 1'b0;
endmodule // comparator

module mux2(c, a,b, X); // Parameterized 2-input MUX
   parameter n = 1;
   input wire c;
   input wire [n-1:0] a, b;
   output wire [n-1:0] X;
   assign X = (c)? a : b;
endmodule // mux2

   
module sm_add_sub_s(a, b, op, SUM, OVFLW);
   parameter n = 8;
   input wire [n:0]  a, b;   // (n+1)-bit input signals in sign-magnitude representation 
   input wire          op;   // 1-bit control: 1 = ADD, 0 = SUB
   output wire [n:0]  SUM;   // (n+1)-bit sum in sign-magnitude representation
   output wire 	    OVFLW;   // 1-bit overflow flag if result has overflows 


   // Instantiate the modules defined above as required by your schematic.
   // Glue the outputs and inputs of modules together using simple assign statements to implement gate logic.


   

endmodule // sm_ad_sub_s


//***************************************************************************************/ 
module add_sub_testbench;                   // Testbench program will exercise your design with input test vectors

   reg [4:0] p, q;                     
   wire [4:0]  S; 
   wire	      OV;
   reg        op;
	
   sm_add_sub_s #(4)  mySmAdder(p, q, op, S, OV) ;   

   
	initial begin
	   p = 5'b00000;
	   q = 5'b00000;    
	   $display("*************************************"); 
	   $display("OP\tp   q\t\tS   OV\n");
	end
   
   integer i, j, k;  // Regular program variable used here for sequencing
	 
	always @(*) begin

		op = 1'b1;  // ADD:1  SUB: 0
		for (k=0; k < 2; k = k+1) begin
			for (i=0; i < 32; i= i+1) begin
				for (j=0; j < 32; j = j+1)  begin
					#1;   // Delay for 1 time unit
					$display("%s\t%s%d   %s%d\t\t%s%d   %b", op ? "ADD" : "SUB", (p[4]) ? "-" : "+", p[3:0], (q[4]) ? "-":"+", q[3:0], (S[4])? "-":"+", S[3:0], OV);
					{p, q} = {p, q} + 1;  // Cycle through the assigments
				end
			end
			op = 1'b0;
		end		
		$finish;
	end
endmodule // add_sub_testbench






