`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2023 02:27:59 PM
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input  logic  [31:0] addr,
    input  logic  [31:0] data_W,
    output logic   [31:0] data_R,
    input  logic   memwrite,
    input  logic   clk
    );


logic [31:0] mem[1023:0];
assign mem[0] = 32'd100;
assign mem[1] = 32'd200;
assign mem[2] = 32'd300;
assign mem[3] = 32'd400;
assign mem[4] = 32'd500;
assign mem[11] = 32'd4000;
assign mem[12] = 32'd5090;
//assign mem[15] = 32'd600;
always_comb begin : Reading
    data_R = mem[addr];
end

always_ff @(posedge clk) begin : Writing
    if (memwrite) begin
        mem[addr] <= data_W;
    end
end

endmodule
