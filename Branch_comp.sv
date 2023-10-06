`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2023 03:31:45 PM
// Design Name: 
// Module Name: Branch_comp
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


module Branch_comp(
    input logic [31:0] A,
    input logic [31:0] B,
    output logic BrEq,
    output logic BrLT
    );
    always_comb begin : Bran_comp
        BrEq = (A == B);
        BrLT = (A < B);
        
    end
endmodule
