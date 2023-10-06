`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 02:55:35 PM
// Design Name: 
// Module Name: im_gen
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


module im_gen(
    input logic [31:0] data_in,
    input logic [2:0]imm_sel,
    output logic [31:0] out
    );


   // assign dum_imm[11:0]=data_in[31:20];
   //assign out = (imm_sel) ? { {21{data_in[11]}}, data_in[10:0] }: 0;
   always_comb begin : IMM_selector
    unique case (imm_sel)
    3'b000: out = 0;                                    //R type
    3'b001: out = { {21{data_in[31]}}, data_in[30:20] };  // I type
    3'b010: out = { {21{data_in[31]}}, data_in[30:25],data_in[11:7] };  // S type
    3'b100: out = { {21{data_in[31]}}, data_in[7],data_in[30:25],data_in[11:8]};  // SB type
    
   endcase
   
   end

   
endmodule
