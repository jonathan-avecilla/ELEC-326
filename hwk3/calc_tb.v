// Calculator Testbench
module calc_tb; 
   reg [3:0] op1, op2;
   reg [3:0] op;
   reg [15:0] counter;
   
   wire [7:0] result;
   wire        ov;
   
   
initial begin
  op1 = 4'b0;
  op2= 4'b0;
  op = 4'b0;
  counter = 16'hFEEF;
   $display("Time\t OP\tOP1\tOP2\t\tRESULT\tOV\n");
end

   // Instantiate a "calc"  module
calc test(
	  .data1_pi(op1),
	  .data2_pi(op2),
	  .op_pi(op),
	  .counter_pi(counter),
	  .result_po(result),
	  .ovflw_po(ov)
	  );
   

   
   always @(*) begin
      op1 = 4'd5;
      op2 = 4'd14;
      op = 4'b0000;

      #1;      $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);
      
      op = 4'b0001;
      #1;       $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);

      op = 4'b0010;
      #1;      $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);

       op = 4'b0100;
      #1;      $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);

       op = 4'b1000;
      #1;      $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);

      op = 4'b1100;
      #1;     $display("%3d\t%4b\t %x\t %x\t\t %x\t %b", $time, op, op1, op2, result, ov);
      $finish;
   end
   
endmodule // calc_tb
