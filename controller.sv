`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/20/2023 09:56:25 AM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controller(
    input logic [31:0] inst,
    input logic BrLT,
    input logic BrEq,
    output logic [16:0] ALU_control,
    output logic PCSel,
    output logic [2:0]ImmSel,
    output logic RegWEn,
    output logic BSel,
    output logic ASel,
    output logic MemRW,
    output logic WBSel,
    output logic PC_INST
    );
    logic [6:0] ALU_control_temp;
    logic [16:0] control_signal;
    logic PC_temp;
    assign control_signal = {inst[31:25], inst[14:12], inst[6:0]};


    always_comb begin : control_INSTRUCTION
                
    unique case (control_signal[6:0])
        7'b0110011: begin   
                BSel=1'b0;//alu r-type
                ImmSel=3'b000;
                PC_temp = 1'b0;
                PC_INST=1'b0;

            unique case (control_signal[16:7])
            17'b0000000_000: ALU_control_temp =7'b0011100; //add
            17'b0100000_000: ALU_control_temp =7'b0011101; //sub
            17'b0000000_001: ALU_control_temp =7'b0011110; //sll
            17'b0000000_010: ALU_control_temp =7'b0011111; //slt
            17'b0000000_011: ALU_control_temp =7'b0100000; //sltu
            17'b0000000_100: ALU_control_temp =7'b0100001; //xor
            17'b0000000_101: ALU_control_temp =7'b0100010; //srl
            17'b0100000_101: ALU_control_temp =7'b0100011; //sra
            17'b0000000_110: ALU_control_temp =7'b0100100; //or
            17'b0000000_111: ALU_control_temp =7'b0100101; //and
            default: ALU_control_temp =7'b1111111;
            endcase end //00101000



        7'b0010011: begin // immediate
                    ImmSel=  3'b001;
                    BSel=1'b1;
                    PC_temp = 1'b0;
                    PC_INST=1'b0;

            unique case (control_signal[14:12])
                3'b000:  ALU_control_temp =7'b0011100; //ADDI
                3'b010:  ALU_control_temp =7'b1111111; //SLTI  //ALU out is zero but negative flag will be 1.
                3'b011:  ALU_control_temp =7'b1111111; //SLTIU //ALU out is zero but negative flag will be 1.
                3'b100:  ALU_control_temp =7'b0100001; //XORI
                3'b110:  ALU_control_temp =7'b0100100; //ORI
                3'b111:  ALU_control_temp =7'b0100101; //ANDI
                3'b001:  ALU_control_temp =7'b0011110; //SLLI
                3'b101:  begin //SRLI or SRAI
                    if(control_signal[30]==1'b0) ALU_control_temp =7'b0100010; //SRLI
                    else ALU_control_temp =7'b0100011; //SRAI
                end


                

                
            endcase
        end


        7'b0000011: begin //load
                    ImmSel=  3'b001;
                    BSel=1'b1;
                    ALU_control_temp =7'b0011100;
                    WBSel=1'b0;
                    RegWEn=1'b1;
                    PC_temp = 1'b0;
                    PC_INST=1'b0;
            // unique case (control_signal[14:12])
            //     3'b000:   //LB
            //     3'b001:  //LH
            //     3'b010:  //LW
            //     3'b100:  //LBU
            //     3'b101:  //LHU
            // endcase
        end
        7'b0100011: begin            //store
                    ImmSel= 3'b010;
                    BSel=1'b1;
                    ALU_control_temp =7'b0011100;
                    MemRW=1'b1;
                    WBSel=1'b0;
                    RegWEn=1'b0;
                    PC_temp = 1'b0;
                    PC_INST=1'b0;
            // unique case (control_signal[14:12])
            //     3'b000:   //SB
            //     3'b001:  //SH
            //     3'b010:  //SW
            // endcase
        end

        7'b1100011: begin //branch
                    //PC_temp = 1'b0;
                    ImmSel= 3'b100;
                    BSel=1'b1;
                    ALU_control_temp =7'b1111111;
                    PC_INST=1'b0;
                    
            unique case (control_signal[9:7])
                3'b000:  begin
                    if (BrEq==1'b1) 
                        PC_temp=1'b1;
                    else if (BrEq==1'b0)
                        PC_temp=1'b0;
                end
               // 3'b001:  BrUn=1'b0; //BNE
                3'b100:   begin
                    if (BrLT==1'b1) 
                        PC_temp=1'b1;
                    else if (BrLT==1'b0)    
                        PC_temp=1'b0;
                end //BLT
              
            endcase
        end

        7'b1100111: begin       //JALR
            ImmSel=  3'b001;
            PC_temp=1'b1;
            RegWEn=1'b1;
            WBSel=1'b1;
            PC_INST=1'b1;  
        end
    

    
    endcase
    end

    // always_comb begin : branch
    //     if (BrLT | BrEq) begin
    //         PC_temp=1'b1;
    //     end
    // end
    assign PCSel= PC_temp;
    assign ALU_control=ALU_control_temp;
 
   
endmodule
