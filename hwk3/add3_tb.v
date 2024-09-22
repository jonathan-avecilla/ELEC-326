// Testbench
module add3_tb;

   reg [3:0] p, q, r; // Test values
   wire [5:0] RC_SUM;


   

   rc3 rca3(p, q, r, RC_SUM);



initial begin
   p = 4'b0;              // Initialize p to 0
   q = 4'b0;
   r = 4'b1010;
   
   $display("Time\tp\tq\tr\t\tRC_SUM\n");
end
   
   integer i, j;  // Regular program variable used here for sequencing

   
   
   always @(*) begin

      for (i=0; i < 16; i = i+1) 	begin
	   for (j=0; j < 16; j = j+1)   begin
	      #1;  $display("%3d\t%d\t%d\t%d\t\t   %d", $time, p, q, r, RC_SUM);
	           {p, q} = {p, q} + 1;  // Cycle through the assigments 
	   end
	end
      $finish;
   end
endmodule // add3_tb

