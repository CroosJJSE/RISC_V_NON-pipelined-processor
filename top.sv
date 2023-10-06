
module top(
     input logic clk,reset,
     output logic [31:0] sum,PC,para2,para3
);

//wires
logic [31:0]wire_pc,
            wire_instruction,
            wire_ALU_A,
            wire_ALU_B,
            wire_IMM_mux_out_B,
            wire_A_mux_out_A,
            wire_im_gen,
            wire_ALU_result,
            wire_ALU_control,
            wire_data_R,
            wire_para,
            wire_pc_next_out,
            wire_Data_DMEM,
            wire_DMEM_out;
logic zero,
      overflow,
      negative,
      wire_PCSel,
      wire_BSel,
      wire_ASel,
      wire_WBsel,
      wire_RegWEn,
      wire_BrEq,
      wire_BrLT,
      wire_PC_INST,
      wire_MemRW;

logic [2:0] wire_ImmSel;

 //intantiate PC
    PC pc(
       // .pc_increment(4),
        .reset(reset),
        .clk(clk),
        .pc_out(wire_pc),
        .PCSel(wire_PCSel),
        .imm_off(wire_im_gen),
        .pc_next_out(wire_pc_next_out)
    );
//intantiate instruction memory
    InstructionMemory instruction_memory(
        .pc_in(wire_pc),
        .clk(clk),
        .reset(reset),
        .instruction(wire_instruction)
    );
    //intantiate controller
    controller controller(
        .inst(wire_instruction),
        .ALU_control(wire_ALU_control),
        .PCSel(wire_PCSel),
        .ImmSel(wire_ImmSel),
        .BSel(wire_BSel),
        .MemRW(wire_MemRW),
        .WBSel(wire_WBsel),
        .BrEq(wire_BrEq),
        .BrLT(wire_BrLT),
        .RegWEn(wire_RegWEn),
        .PC_INST(wire_PC_INST)
    
    );

// intantiate regFile
    RegFile regFile(
        .read_regA(wire_instruction[19:15]),
        .read_regB(wire_instruction[24:20]),
        .write_reg(wire_instruction[11:7]),
        .write_enable(wire_RegWEn),
        .clk(clk),
        .reset(reset),
        .write_data(wire_Data_DMEM),
        .read_dataA(wire_ALU_A),
        .read_dataB(wire_ALU_B)
    );

// intantiate main_ALU
    main_ALU main_ALU(
        .A(wire_ALU_A),
        .B(wire_IMM_mux_out_B),
        .ALU_control(wire_ALU_control),
        .ALU_result(wire_ALU_result),
        .zero(zero),
        .overflow(overflow),
        .negative(negative)
    );  
//iMM_gen
im_gen im_gen(
    .data_in(wire_instruction),
    .imm_sel(wire_ImmSel),
    .out(wire_im_gen)
);
// intantiate IMM_mux
    mux IMM_mux(
        .sel(wire_BSel),
        .in0(wire_ALU_B),
        .in1(wire_im_gen),
        .out(wire_IMM_mux_out_B)
        
    );
//intantiate DMEM
    DMEM DMEM(
        .clk(clk),
        .memwrite(wire_MemRW),
        .addr(wire_ALU_result),
        .data_W(wire_ALU_B),
        .data_R(wire_data_R)
    );

//intantiate DMEM mux
    mux DMEM_mux(
        .sel(wire_WBsel),
        .in0(wire_data_R),
        .in1(wire_ALU_result),
        .out(wire_DMEM_out)
    );

// intantiate Branch_comp
    Branch_comp Branch_comp(
        .A(wire_ALU_A),
        .B(wire_ALU_B),
        .BrEq(wire_BrEq),
        .BrLT(wire_BrLT)
    );

//PC Inst Mux
    mux PC_inst_mux(
        .sel(wire_PC_INST),
        .in0(wire_DMEM_out),
        .in1(wire_pc_next_out),
        .out(wire_Data_DMEM)
    );


assign sum =wire_im_gen;
assign PC=wire_pc;
assign para2=wire_BrEq;
assign para3=wire_PCSel;
endmodule