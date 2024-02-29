module RegFile (
    input [4:0] read_regA, read_regB, write_reg,
    input write_enable, clk, reset,
    input [31:0] write_data,
    output [31:0] read_dataA, read_dataB
);

    // Memory
    reg [31:0] register_File [31:0];

    integer i;
    always @(posedge clk) begin
        if (reset) begin
            for (i = 1; i < 32; i = i + 1) begin
                register_File[i] <= 32'h0;
            end
        end
        else if (write_enable) begin
            register_File[write_reg] <= write_data;
        end
    end

    initial begin
        register_File[0] = 32'h0;
        register_File[1] = 32'd3;
        register_File[2] = 32'd2000;
        register_File[3] = 32'd20000;
        register_File[4] = 32'd10;
        register_File[5] = 32'd11;
        register_File[11] = 32'd109;
        register_File[15] = 32'd15;
        register_File[31] = 32'd100;
        register_File[20] = 32'd10;
        register_File[21] = 32'd1;
    end

    assign read_dataA = register_File[read_regA];
    assign read_dataB = register_File[read_regB];

endmodule

