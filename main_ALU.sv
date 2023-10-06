`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:20:19 AM
// Design Name: 
// Module Name: main_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module main_ALU (
    input logic [31:0] A, B,    // Inputs A and B
    input logic [6:0] ALU_control,    // ALU control signals
    output logic [31:0] ALU_result,  // Output result
    output logic zero,              // Zero flag
    output logic overflow,          // Overflow flag
    output logic negative           // Negative flag
);

// ALU computation
always_comb begin : ALU
    unique case (ALU_control)
        7'b0011100: begin   // ADD 
            ALU_result = A + B;
            overflow = (A[31] == B[31]) && (ALU_result[31] != A[31]);
        end
        7'b0011101: ALU_result = A - B; // SUB 
        7'b0011110: ALU_result = A << B; // SLL Shift left logical
        7'b0011111: ALU_result = (A < B) ? 1 : 0; // SLT Set Less Than
        7'b0100000: ALU_result = (A < B) ? 1 : 0; // SLTU Set Less Than unsigned
        7'b0100001: ALU_result = A ^ B; // XOR 
        7'b0100010: ALU_result = A >> B; // SRL Shift Right Logical
        7'b0100011: ALU_result = A >>> B; // SRA Shift Right arithmetic
        7'b0100100: ALU_result = A | B; // OR 
        7'b0100101: ALU_result = A & B; // AND 
        default: ALU_result = 0; // Default: Set result to 0
    endcase
end

// Flags computation
always_comb begin : flags
    zero = (A == B) ? 1'b1 : 1'b0; // Zero flag  
    negative = (A < B) ? 1'b1 : 1'b0; // Negative flag 
end

endmodule
