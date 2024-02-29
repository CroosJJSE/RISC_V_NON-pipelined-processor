`timescale 1ns / 1ps
module micro_inst_memo (
    input [5:0] addr,
    output reg [15:0] control
);

    reg [15:0] C_memory [0:255];
    
    // Initialize microinstructions
    initial begin
        // R-Type Instructions
        C_memory[0]  = 16'b01_x_0_1_000_0_0011100;  // ADD
        C_memory[1]  = 16'b01_x_0_1_000_0_0011101;  // SUB
        C_memory[2]  = 16'b01_x_0_1_000_0_0011110;  // SLL
        C_memory[3]  = 16'b01_x_0_1_000_0_0011111;  // SLT
        C_memory[4]  = 16'b01_x_0_1_000_0_0100000;  // SLTU
        C_memory[5]  = 16'b01_x_0_1_000_0_0100001;  // XOR
        C_memory[6]  = 16'b01_x_0_1_000_0_0100010;  // SRL
        C_memory[7]  = 16'b01_x_0_1_000_0_0100011;  // SRA
        C_memory[8]  = 16'b01_x_0_1_000_0_0100100;  // OR
        C_memory[9]  = 16'b01_x_0_1_000_0_0100101;  // AND
        
        // I-Type Instructions
        C_memory[10] = 16'b01_x_1_1_001_0_0011100;  // ADDI
        C_memory[11] = 16'b01_x_1_1_001_0_1111111;  // SLTI
        C_memory[12] = 16'b01_x_1_1_001_0_1111111;  // SLTIU
        C_memory[13] = 16'b01_x_1_1_001_0_0100001;  // XORI
        C_memory[14] = 16'b01_x_1_1_001_0_0100100;  // ORI
        C_memory[15] = 16'b01_x_1_1_001_0_0100101;  // ANDI
        C_memory[16] = 16'b01_x_1_1_001_0_0011110;  // SLLI
        C_memory[17] = 16'b01_x_1_1_001_0_0100010;  // SRLI
        C_memory[18] = 16'b01_x_1_1_001_0_0100011;  // SRAI
        
        // L-Type Instructions
        C_memory[19] = 16'b00_x_1_1_001_0_0011100;  // LW
        
        // S-Type Instructions
        C_memory[20] = 16'b00_1_1_0_010_0_0011100;  // SW
        
        // B-Type Instructions
        C_memory[21] = 16'bxx_x_1_x_100_1_1111111;  // BEQ
        C_memory[22] = 16'bxx_x_1_x_100_0_1111111;  // BEQ
        
        C_memory[23] = 16'bxx_x_1_x_100_1_1111111;  // BLT
        C_memory[24] = 16'bxx_x_1_x_100_0_1111111;  // BLT
        
        C_memory[25] = 16'bxx_x_1_x_100_1_1111111;  // BNE
        C_memory[26] = 16'bxx_x_1_x_100_0_1111111;  // BNE
        
        C_memory[27] = 16'bxx_x_1_x_100_1_1111111;  // BGE
        C_memory[28] = 16'bxx_x_1_x_100_0_1111111;  // BGE
        
        // U-Type Instructions
        C_memory[30] = 16'bxx_x_0_x_000_0_1111000;  // MUL
    end
    
    // Assign control output
    always @* begin
        control = C_memory[addr];
     end

endmodule
