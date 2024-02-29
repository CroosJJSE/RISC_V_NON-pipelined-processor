module im_gen(
    input wire [31:0] data_in,
    input wire [2:0] imm_sel,
    output reg [31:0] out
);

always @* begin : IMM_selector
    case (imm_sel)
        3'b000: out = 32'b0; // R type
        3'b001: out = { {21{data_in[31]}}, data_in[30:20] }; // I type
        3'b010: out = { {21{data_in[31]}}, data_in[30:25], data_in[11:7] }; // S type
        3'b100: out = { {21{data_in[31]}}, data_in[7], data_in[30:25], data_in[11:8] }; // SB type
        default: out = 32'b0; // Default case
    endcase
end

endmodule
