/* Calculator performing the following operations on 4-bit inputs "data1_pi" and "data2_pi":
           op_pi = 0000:  Return 8-bit the concatenation of data1_pi  and data2_pi  (data1_pi is more  significant)
           op_pi = 0001:  Unsigned addition "data1_pi + data2_pi"  returning a 4-bit sum and a 1-bit unsigned overflow  (carry)
           op_pi = 0010:  Unsigned subtraction "data1_pi - data2_pi" returning 4-bit difference and 1-bit unsigned overflow (borrow)
           op_pi = 0100:  Unsigned multiplication "data1_pi * data2_pi"  returning 8-bit product
           op_pi = 1000:  Two's-complement addition "data1_pi + data2_pi" returning 4-bit sum and 1-bit signed overflow

For any other value of "op_pi", return "result_po" as  the 8 LSBs of  input "counter_pi" and "ovflw_po" as 0
*/

module calc(
input wire [3:0] data1_pi, data2_pi,
input wire [3:0] op_pi,
input wire [15:0] counter_pi,
output wire [7:0] result_po,
output wire ovflw_po);

   // Hint: Simplest is to use a case statement within an "always" block to select the ˜operation based on "op_pi"
   // You can also do it using only continuous assignment statements and the conditional operator.
   // You can use any Verilog arithmetic (+,-, *)  or logic (&, |, ^) operators directly.


   wire [4:0] t;

   always @(op_pi) begin

	if (op_pi == 4'b0000) begin
            	
		assign result_po = {data1_pi, data2_pi};
        
    	end else if (op_pi == 4'b0001) begin
	    
		assign t = {1'b0, data1_pi} + {1'b0, data2_pi};
		assign result_po = {4'b0, t[3:0]};
		assign ovflw_po = t[4];
        
    	end else if (op_pi == 4'b0010) begin

		assign t = {1'b0, data1_pi} - {1'b0, data2_pi};
		assign result_po = {4'b0, t[3:0]};
		assign ovflw_po = (data1_pi >= data2_pi) ? 1'b0 : 1'b1;
        

	end else if (op_pi == 4'b0100) begin

		assign result_po = data1_pi * data2_pi;
			

	
	end else if (op_pi == 4'b1000) begin

		
        
    	end else begin
            assign result_po = counter_pi[7:0];
	    assign ovflw_po = 1'b0; // 
        
    	end


	end


   
endmodule // calc

