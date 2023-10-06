`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2023 10:46:17 PM
// Design Name: 
// Module Name: N_mux
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


module mux (
    input logic  sel,
    input logic [31:0] in0,in1,
    output logic [31:0]out
);
   assign out=(!sel)? in0:in1;
endmodule
