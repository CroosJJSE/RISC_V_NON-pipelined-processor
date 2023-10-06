module RegFile (
    input logic [4:0] read_regA, read_regB, write_reg,
    input logic write_enable, clk, reset,
    input logic [31:0] write_data,
    output logic [31:0] read_dataA, read_dataB
);

    // memory
    logic [31:0] register_File [31:0];

    integer  i;
    always_ff @(posedge clk) begin : write
        if (reset) begin
            for (i =1 ; i<32 ;i=i+1 ) begin
                register_File[i] <= 32'h0;
            end
             // Reset all registers to 0
        end
        else if (write_enable) begin
            register_File[write_reg] <= write_data; // Assign write_data to the specified register
        end
    end
    assign register_File[0] = 32'h0; 
    assign register_File[1] = 32'd150;
    assign register_File[2] = 32'd999;
    assign register_File[3] = 32'd2;
    assign register_File[4] = 32'd10;
    assign register_File[5] = 32'd11;
    assign register_File[11] = 32'd109;
    assign register_File[15] = 32'd100;
    assign read_dataA = register_File[read_regA];
    assign read_dataB = register_File[read_regB];

endmodule
