`timescale 1ns / 1ps
module Branch_comp (
    input [31:0] A,
    input [31:0] B,
    input BrUn,
    output reg BrEq,
    output reg BrLT
);

    always @* begin : Bran_comp
        BrEq = (A == B);
        BrLT = (BrUn) ? (A < B) : (A[31] < B[31]);
    end

endmodule
