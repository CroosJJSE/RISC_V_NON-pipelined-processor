module top_tb ();
    logic clk,reset,write_enable;
    logic [31:0] sum,PC,para2,para3;
    top top1(.*);
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    //test
    initial begin
        reset = 1;
        write_enable=1;
        #1;
        reset = 0;
        repeat(10) begin   
        $display("1.wire_pc: %d",top1.wire_pc);
        $display("2.wire_BSel : %d",top1.wire_BSel);
        
        $display("2.wire_IMM_mux_out_B: %d",top1.wire_IMM_mux_out_B);    
       $display("3.wire_ALU_B: %d",top1.wire_ALU_B);
       $display("4.wire_BrEq: %d",top1.wire_BrEq);
        //$display("5.wire_im_gen: %d",top1.wire_im_gen);
       
        #20; 
         
        end
          $finish(); 
    end
    
endmodule