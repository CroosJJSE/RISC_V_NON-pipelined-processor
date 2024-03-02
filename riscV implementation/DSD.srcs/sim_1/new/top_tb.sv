`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/29/2024 12:04:36 PM
// Design Name: 
// Module Name: top_tb
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


module top_tb ();
    reg clk,reset,led1,led2,led3,led4;
    
    risc risc1(.*);
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    //test
    initial begin
        reset = 1;

        #1;
        reset = 0;
        repeat(20) begin   


       
        #20; 
         
        end
          $finish(); 
    end
    
endmodule