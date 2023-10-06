`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 12:54:34 AM
// Design Name: 
// Module Name: PC
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


module PC (
    input logic [31:0] imm_off,  // Current PC value
    input logic reset,clk,PCSel,  // Reset signal
    output logic [31:0] pc_out,  // Next PC value
    output logic [31:0] pc_next_out
);

    logic [31:0] pc_register;  // Register to store the PC value


    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_register <= 32'h0;  // Reset the PC to 0
        end else begin
                   unique case (PCSel)
                    1'b0: pc_register=pc_register+32'd1;
                    1'b1: pc_register= pc_register+ imm_off; 
                    endcase  // Update the PC value
        end

    end

    assign pc_out = pc_register;  // Output the next PC value
    assign pc_next_out = pc_register+32'd1;
endmodule
