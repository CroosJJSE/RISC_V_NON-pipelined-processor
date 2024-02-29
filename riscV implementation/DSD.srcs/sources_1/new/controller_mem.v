module Controller_mem(
    input [31:0] inst,
    input BrLT,
    input BrEq,
    output reg [6:0] ALU_control,
    output reg PCSel,
    output reg [2:0] ImmSel,
    output reg RegWEn,
    output reg BSel,
    output reg ASel,
    output reg MemRW,
    output reg [1:0] WBSel
);

reg [10:0] control_signal;
reg PC_temp;


always @* begin
    case (inst[6:0])
        7'b0110011: begin                               // R-type
            case (inst[10:7])
                4'b0000: ALU_control = 7'b0000000;     // ADD
                4'b1000: ALU_control = 7'b0100000;     // SUB
                4'b0001: ALU_control = 7'b0000001;     // SLL
                4'b0010: ALU_control = 7'b0000010;     // SLT
                4'b0011: ALU_control = 7'b0000011;     // SLTU
                4'b0100: ALU_control = 7'b0000100;     // XOR
                4'b0101: ALU_control = 7'b0000101;     // SRL
                4'b1101: ALU_control = 7'b0100101;     // SRA
                4'b0110: ALU_control = 7'b0000110;     // OR
                4'b0111: ALU_control = 7'b0000111;     // AND
                4'b1111: ALU_control = 7'b0001111;     // MUL
            endcase
            
        end
        7'b0010011: begin // immediate
            case (inst[9:7])
                3'b000:   ALU_control = 7'b0000000;     // ADDI
                3'b010:   ALU_control = 7'b0000010;     // SLTI
                3'b011:   ALU_control = 7'b0000011;     // SLTIU
                3'b100:   ALU_control = 7'b0000100;     // XORI
                3'b110:   ALU_control = 7'b0000110;     // ORI
                3'b111:   ALU_control = 7'b0000111;     // ANDI
                3'b001:   ALU_control = 7'b0000001;     // SLLI
                3'b101: begin                           // SRLI or SRAI
                    if (inst[10] == 1'b0)
                        ALU_control = 7'b0000010;       // SRLI
                    else
                        ALU_control = 7'b0100010;       // SRAI
                end
            endcase
        end
        7'b0000011: ALU_control = 7'b0000011;           // LOAD
        7'b0100011: ALU_control = 7'b0000000;           // STORE
        7'b1100011: begin // branch
            case (inst[9:7])
                3'b000: PCSel = (BrEq) ? 1'b1 : 1'b0;   // BEQ
                3'b100: PCSel = (BrLT) ? 1'b1 : 1'b0;   // BLT
                3'b001: PCSel = (BrEq) ? 1'b0 : 1'b1;   // BNE
                3'b101: PCSel = (BrLT) ? 1'b0 : 1'b1;   // BGE
            endcase
        end
        7'b1100111: begin       // JALR
            ImmSel = 3'b001;
            PC_temp = 1'b1;
            RegWEn = 1'b1;
            WBSel = 2'b01;
        end
    endcase
end

endmodule
