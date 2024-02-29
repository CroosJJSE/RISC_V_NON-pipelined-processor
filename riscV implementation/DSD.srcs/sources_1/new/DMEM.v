module DMEM(
    input  [31:0] addr,
    input  [31:0] data_W,
    output [31:0] data_R,
    input   memwrite,
    input   clk
);

reg [31:0] mem [1023:0];
reg [31:0] data_R_reg;
initial begin
    mem[0] = 32'd1011;
    mem[1] = 32'd111;
    mem[2] = 32'd222;
    mem[3] = 32'd333;
    mem[4] = 32'd444;
    mem[10] = 32'd555;
    mem[11] = 32'd11111;
    mem[12] = 32'd1212;
    mem[13] = 32'd1313;
end

always @* begin // Equivalent to always_comb
    data_R_reg = mem[addr];
end

always @(posedge clk) begin // Equivalent to always_ff
    if (memwrite) begin
        mem[addr] <= data_W;
    end
end
assign data_R = data_R_reg;
endmodule
