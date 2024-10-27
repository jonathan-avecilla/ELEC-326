`timescale 1ns/1ns

module branch (
    input        branch_eq_pi,
    input        branch_ge_pi,
    input        branch_le_pi,
    input        branch_carry_pi,
    input [15:0] reg1_data_pi,
    input [15:0] reg2_data_pi,
    input        alu_carry_bit_pi,
    
    output reg   is_branch_taken_po
);

initial begin
branch_eq_pi = 0;
        branch_ge_pi = 0;
        branch_le_pi = 0;
        branch_carry_pi = 0;
        reg1_data_pi = 16'h0000;  
        reg2_data_pi = 16'h0000;  
        alu_carry_bit_pi = 0;

end        // Test branch_eq
always @(*) begin
    is_branch_taken_po = 1'b0; // Default to not taken
    
    // Check conditions based on the control signals
    if (branch_eq_pi) begin
        is_branch_taken_po = (reg1_data_pi == reg2_data_pi);
    end
    else if (branch_ge_pi) begin
        is_branch_taken_po = (reg1_data_pi >= reg2_data_pi);
    end
    else if (branch_le_pi) begin
        is_branch_taken_po = (reg1_data_pi <= reg2_data_pi);
    end
    else if (branch_carry_pi) begin
        is_branch_taken_po = alu_carry_bit_pi;
    end
end

endmodule