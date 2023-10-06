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
            for (i =3 ; i<32 ;i=i+1 ) begin
                register_File[i] <= 32'h0;
            end
             // Reset all registers to 0
        end
        else if (write_enable) begin
            register_File[write_reg] <= write_data; // Assign write_data to the specified register
        end
    end
    assign register_File[0] = 32'h0; // Register 0 is always 0
    assign register_File[1] = 32'h11; // Register 1 is always 0
    assign register_File[2] = 32'h02; // Register 2 is always 0 
    assign read_dataA = register_File[read_regA];
    assign read_dataB = register_File[read_regB];

endmodule
