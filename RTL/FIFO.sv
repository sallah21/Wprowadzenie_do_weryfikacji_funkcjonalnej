module FIFO #(
    parameter FIFO_depth = 16,
    parameter FIFO_width = 8,
    parameter FIFO_pntr_w = 4,
    parameter FIFO_cntr_w = 4
) (
    input clk,
    input FIFO_reset_n,
    input FIFO_clr_n,
    input [FIFO_width-1:0] data_in,
    output [FIFO_width-1:0] data_out,
    input push,
    input pop
);


integer i=0;

reg [FIFO_width-1:0] FIFO [FIFO_depth-1:0];

reg [FIFO_pntr_w-1:0] top ;
reg [FIFO_pntr_w-1:0] btm ;
reg [FIFO_cntr_w-1:0] cnt ;

always @(posedge clk or negedge FIFO_clr_n) begin
    if (! FIFO_clr_n) begin
        top <= 0;
        btm <= 0;
        cnt <= 0;
        for (i=0; i < FIFO_depth; i= i+1) begin
            FIFO [i] <= 0;
        end 
    end
    else if (!FIFO_reset_n) begin
        top <= 0;
        btm <= 0;
        cnt <= 0;
    end
    else begin
            case ({push,pop})
            2'b10: begin
                FIFO [top] <= data_in;
                top <= top +1;
                cnt <= cnt +1;
            end 
            2'b01: begin
                btm <= btm +1;
                cnt <= cnt -1;
            end 
            2'b11: begin
                FIFO[top] <= data_in;
                btm <= btm +1;
                top <= top +1;
            end 
            endcase
        end 
end

assign data_out = FIFO[btm];
endmodule