`timescale 1ns/1ps

`define CW3

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
  initial
  begin
    clk = 0;
    forever
      #5 clk = ~clk;
  end  // 10ns period (100MHz clock)

`ifdef CW3
  // FSM States
  typedef enum reg [1:0] {
            IDLE,
            PUSH,
            POP,
            FINISH
          } state_t;
  state_t state, next_state;

`endif // CW3

  initial
  begin
    // VCD logging
    $dumpfile("fifo_sim.vcd");
    $dumpvars(0, FIFO_tb);

`ifdef CW1
    ////////////////////////////////////////////////////////////////
    ////// CW1
    ////////////////////////////////////////////////////////////////
    repeat(5)
    begin
      clk = 1;
      #10;
      clk = 0;
      #10;
    end
`endif //CW1

`ifdef CW2
    ////////////////////////////////////////////////////////////////
    ////// CW2
    ////////////////////////////////////////////////////////////////
    FIFO_reset_n = 0;
    repeat(5) @ (posedge clk);
    FIFO_reset_n = 1;
    repeat(5) @ (posedge clk);
    push = 1;
    pop = 0;
    data_in = 8'h01;
    // #10;
    @ (posedge clk);
    push = 0;
    pop = 1;
    // #10;
    @ (posedge clk);
    push = 1;
    pop = 0;
    data_in = 8'h02;
    // #10;
    @ (posedge clk);
    push = 1;
    pop = 0;
    data_in = 8'h03;
    // #10;
    @ (posedge clk);
    push = 0;
    pop = 1;
    // #10;
    @ (posedge clk);
    push = 1;
    pop = 0;
    data_in = 8'h04;
    // #10;
    @ (posedge clk);
    push = 0;
    pop = 0;
    data_in = 8'hzz;
    #100; // Watch delay
`endif //CW2

`ifdef CW3
    ////////////////////////////////////////////////////////////////
    ////// CW3
    ////////////////////////////////////////////////////////////////
    // Initial values
    FIFO_reset_n = 0;
    FIFO_clr_n = 0;
    push = 0;
    pop = 0;
    data_in = 0;
    // FSM Initialization
    state = IDLE;
    next_state = IDLE;
     // Reset FIFO 
    #10 FIFO_reset_n = 1;
    FIFO_clr_n = 1; // Start FSM 
    #10 state = PUSH;


    #100; // Watch delay
`endif //CW3

`ifdef CW3_B

`endif // CW3_B

    $finish;
  end

   // FSM Logic
   always @(posedge clk or negedge FIFO_reset_n) begin 
    if (!FIFO_reset_n) 
    state <= IDLE; 
    else state <= next_state;
     end 
    always @(*) begin next_state = state; // Default state transition 
        case (state) IDLE: begin // Wait for reset 
            if (FIFO_reset_n && FIFO_clr_n) next_state = PUSH; end 
            PUSH: begin push = 1; data_in = $random; #10 push = 0; next_state = POP; end P
                OP: begin pop = 1; #10 pop = 0; next_state = FINISH;
                 end 
            FINISH: begin // Finish testbench 
                    $finish;
            end 
            endcase 
            end
endmodule
