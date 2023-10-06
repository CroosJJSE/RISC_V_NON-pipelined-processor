`timescale 1ns / 1ps


module InstructionMemory (
    input logic [31:0] pc_in,  // Program counter (input)
    input logic clk,reset,  // Clock (input)
    //input logic [31:0] reset_address,  // Reset address (input)
    output logic [31:0] instruction  // Output instruction
);

    // Define the instruction memory as an array of 32-bit instructions
    logic [31:0] memory [0:255];  // Example: 256 instructions (adjust the size as needed)

    // Initialize the instruction memory with your program instructions
    initial begin
        
         memory[0] = 32'b0000000_00010_00001_000_00011_0110011;  // ADD
         memory[1] = 32'b0000000_00011_00001_000_00011_0010011; // ADDI
         memory[2] = 32'b0000000_00010_00100_010_00101_0000011; // LW
         memory[3] = 32'b0000000_00011_00101_000_00011_0010011; //check LW
         memory[4] = 32'b0000000_00010_00100_010_00101_0100011; // SW
         //00101 part of immediate 
         //000000000101 immediate =5 
         //00100 target base adderess = 4
         //00010 data at register 2
         //will store at register 15 in DMEM
         memory[5] = 32'b0000000_00000_00001_010_00101_0000011; // LW
         memory[6] = 32'b0000000_00011_00101_000_00011_0010011; //check LW
         memory[7] = 32'b0100001_00011_00011_000_01011_1100011; // Branch
         memory[8] = 32'b0100001_00011_00011_000_01011_1100011; // Branch
         memory[9] = 32'b0000000_00010_00001_000_00011_0110011;



//        memory[0] = 32'b0000000_00010_00001_000_01001_0010011;  //  
//        memory[1] = 32'b0000000_00001_00011_000_00100_1100111; //JALR
//        memory[2] = 32'b0000000_00010_00001_000_00011_0110011; // ADD
//        memory[3] = 32'b0000000_00011_00001_000_00011_0010011; // ADDI
//        memory[4] = 32'b0000000_00010_00001_000_00011_0110011; // ADD
//        memory[5] = 32'b0000000_00011_00001_000_00011_0010011; // ADDI
        

    // in rd current pc +4
    // in rs1 the base instruction adderss the immediate is offset
    
    end 

    always_comb begin//@(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset to the specified reset address
            instruction = memory[0];
        end else begin
            // Read the instruction from the memory based on the pc_in
            instruction = memory[pc_in];
        end
    end

endmodule

