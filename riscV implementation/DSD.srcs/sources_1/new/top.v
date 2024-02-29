module top (
    input clk, reset
);

// Wires
wire [31:0] wire_pc;
wire [31:0] wire_instruction;
wire [31:0] wire_regOut_A;
wire [31:0] wire_regOut_B;
wire [31:0] wire_IMM_mux_out_B;
wire [31:0] wire_A_mux_out_A;
wire [31:0] wire_im_gen;
wire [31:0] wire_ALU_result;
wire [6:0] wire_ALU_control;
wire [31:0] wire_data_R;
wire [31:0] wire_para;
wire [31:0] wire_pc_next_out;
wire [31:0] wire_Data_DMEM;
wire [31:0] wire_pc4;
wire [31:0] wire_pc_incremented;
wire [31:0] wire_pc_mux_out;
wire [31:0] wire_DMEM_out;
wire zero;
wire overflow;
wire negative;
wire wire_PCSel;
wire wire_BSel;
wire wire_ASel;
wire wire_RegWEn;
wire wire_BrUn;
wire wire_BrEq;
wire wire_BrLT;
wire wire_PC_INST;
wire wire_MemRW;
wire [1:0] wire_WBsel;
wire [2:0] wire_ImmSel;

// Instantiate instruction memory
InstructionMemory instruction_memory (
    .pc_in(wire_pc),
    .instruction(wire_instruction)
);

// Instantiate controller
Controller_mem controller (
    .inst(wire_instruction),
    .ALU_control(wire_ALU_control),
    .PCSel(wire_PCSel),
    .ImmSel(wire_ImmSel),
    .BSel(wire_BSel),
    .MemRW(wire_MemRW),
    .WBSel(wire_WBsel),
    .BrEq(wire_BrEq),
    .BrLT(wire_BrLT),
    .RegWEn(wire_RegWEn)
);

// Instantiate register file
RegFile regFile (
    .read_regA(wire_instruction[19:15]),
    .read_regB(wire_instruction[24:20]),
    .write_reg(wire_instruction[11:7]),
    .write_enable(wire_RegWEn),
    .clk(clk),
    .reset(reset),
    .write_data(wire_Data_DMEM),
    .read_dataA(wire_regOut_A),
    .read_dataB(wire_regOut_B)
);

// Instantiate main ALU
main_ALU main_ALU (
    .A(wire_A_mux_out_A),
    .B(wire_IMM_mux_out_B),
    .ALU_control(wire_ALU_control),
    .ALU_result(wire_ALU_result),
    .zero(zero),
    .overflow(overflow),
    .negative(negative)
);

// Instantiate immediate generator
im_gen imm_gen (
    .data_in(wire_instruction),
    .imm_sel(wire_ImmSel),
    .out(wire_im_gen)
);

// Instantiate IMM mux
mux IMM_mux (
    .sel(wire_BSel),
    .in0(wire_regOut_B),
    .in1(wire_im_gen),
    .out(wire_IMM_mux_out_B)
);

// Instantiate data memory
DMEM DMEM (
    .clk(clk),
    .memwrite(wire_MemRW),
    .addr(wire_ALU_result),
    .data_W(wire_regOut_B),
    .data_R(wire_data_R)
);

// Instantiate data memory mux
mux4_1 DMEM_mux (
    .sel(wire_WBsel),
    .in0(wire_data_R),
    .in1(wire_ALU_result),
    .in2(wire_pc4),
    .in3(wire_pc_incremented),
    .out(wire_Data_DMEM)
);

// Instantiate branch comparator
Branch_comp Branch_comp (
    .A(wire_regOut_A),
    .B(wire_regOut_B),
    .BrUn(wire_BrUn),
    .BrEq(wire_BrEq),
    .BrLT(wire_BrLT)
);

// Instantiate PC final
PC_final pc (
    .clk(clk),
    .reset(reset),
    .pc_in(wire_pc_mux_out),
    .pc_out(wire_pc)
);

// Instantiate PC mux
mux pc_mux (
    .sel(wire_PCSel),
    .in0(wire_pc4),
    .in1(wire_ALU_result),
    .out(wire_pc_mux_out)
);

// Instantiate PC incrementer
adder pc_incrementer (
    .val_in(wire_pc),
    .val_in2(32'd1),
    .val_out(wire_pc4)
);


mux pcBrancingMux (
    .sel(wire_ASel),
    .in0(wire_regOut_A),
    .in1(wire_pc),
    .out(wire_A_mux_out_A)
);

endmodule
