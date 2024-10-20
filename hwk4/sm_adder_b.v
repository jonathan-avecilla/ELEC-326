module sm_adder_b(a,b,SUM,OVFLW);
   parameter n = 8;
   input wire [n:0]  a, b;   // (n+1)-bit input signals in sign-magnitude representation 
   output reg [n:0]  SUM;    // (n+1)-bit sum in sign-magnitude representation
   output reg 	    OVFLW;   // 1-bit overflow flag if result has overflown
   
   
	always @(*)
	  begin
		 OVFLW = 1'b0;
		 if (a[n] == b[n])   // Signs are the same
		   begin
			{OVFLW, SUM[n-1:0]} = a[n-1:0] + b[n-1:0];
			SUM[n] = a[n];
		  end
		 else if (a[n-1:0] >= b[n-1:0])  // Signs differ and magnitude of a >= magnitude of b    
		   begin                  
			SUM[n-1:0] = a[n-1:0] - b[n-1:0];  // Magnitude of sum
			SUM[n] = a[n];  // Sign of the sum
		  end
		 else
		   begin                        // Magnitude of b > Magnitude of a
			SUM[n-1:0] = b[n-1:0] - a[n-1:0];   // Magnitude of sum
			SUM[n] = b[n];   // Sign of the sum
		   end

		 if (SUM[n-1:0] == 0 )  // If  magnitude of SUM is 0, set sign to positive 
		   SUM[n] = 1'b0;  
	  end // always @ (*)

endmodule // sm_adder_b






//***************************************************************************************/ 
module sm_adder_testbench;                   // Testbench program will exercise your design with input test vectors

   reg [4:0] p, q;                     
   wire [4:0] S; 
   wire	      OV;
   
   sm_adder_b  #4 mySmAdder(p, q, S, OV);   

   
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
		$display("%3d\t%s%d   %s%d\t\t%s%d   %b", $time, (p[4]) ? "-" : "+", p[3:0], (q[4]) ? "-":"+", q[3:0], (S[4])? "-":"+", S[3:0], OV);	
		{p, q} = {p, q} + 1;  // Cycle through the assigments
	     end
	end
      $finish;
   end
endmodule // sm_adder_testbench

