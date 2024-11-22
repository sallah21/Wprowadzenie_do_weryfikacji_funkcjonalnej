`timescale 1ns/1ps

module FIFO_tb();
    // Signal declarations
    reg clk = 0;
    wire [7:0] data_out_r;
    reg [7:0] data_in = 8'h00;
    
    reg FIFO_clr_n = 1;
    reg FIFO_reset_n = 1;
    reg push = 0;
    reg pop = 0;
    

    // Instantiate the FIFO
    FIFO DUT (
        .clk(clk),
        .FIFO_reset_n(FIFO_reset_n),
        .FIFO_clr_n(FIFO_clr_n),
        .data_in(data_in),
        .data_out(data_out_r),
        .push(push),
        .pop(pop)
    );

    // Clock generation
    initial begin
        // VCD logging
        $dumpfile("fifo_sim.vcd");
        $dumpvars(0, FIFO_tb);
        
        repeat(5) begin
            clk = 1; #10;
            clk = 0; #10;
        end
    end

    // Commented out test sequence (equivalent to classic_tb2)
    /*
    initial begin
        push = 1; pop = 0; data_in = 8'h01; #10;
        push = 0; pop = 1; #10;
        push = 1; pop = 0; data_in = 8'h02; #10;
        push = 0; pop = 1; #10;
        push = 1; pop = 0; data_in = 8'h03; #10;
        push = 0; pop = 1; #10;
        push = 1; pop = 0; data_in = 8'h04; #10;
    end
    */

endmodule