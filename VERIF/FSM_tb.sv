`timescale 1ns/1ps

`define CW3

module FSM_tb();
    reg clk;
    // FSM logic 
    reg run_r;
    reg mode_r;
    wire vector_w;
    // Instantiate the FSM as data generator 
    FSM FSM_DUT (
        .clk(clk),          
        .run(run_r),
        .mode(mode_r),
        .vector(vector_w)
    );

    initial begin 
        clk = 0; 
        forever #5 clk = ~clk; 
    end  // 10ns period (100MHz clock) 

    initial begin
        // VCD logging
        $dumpfile("fifo_sim.vcd");
        $dumpvars(0, FSM_tb);
        run_r = 0;
        mode_r =0;
        repeat (5) @(posedge clk);
        run_r = 1;
        repeat (10) @(posedge clk);
        mode_r = 1;
        repeat (10) @(posedge clk);
    end 
endmodule