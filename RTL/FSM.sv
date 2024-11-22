module fsm #(
    parameter STATE_WIDTH = 3
) (
    input logic clk,          
    input run,
    input mode,
    output reg[3:0] vector
);

 
    typedef enum logic [STATE_WIDTH-1:0] {
        STATE_0   = 3'b000,   
        STATE_1   = 3'b001,  
        STATE_2   = 3'b010,  
        STATE_3   = 3'b011    
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk ) begin
        if (!run)
            current_state <= current_state;  
        else
            current_state <= next_state;
    end

    always_comb begin
        case (current_state)
            STATE_0: begin
                vector = 4'b0001;
                next_state = STATE_1;
            end

            STATE_1: begin
                vector = 4'b0010;
                if (mode) begin
                    next_state = STATE_2;
                end 
                else begin
                    next_state = STATE_3;
                end 
            end

            STATE_2: begin
                vector = 4'b0100;
                next_state = STATE_3;
            end

            STATE_3: begin
                vector = 4'b1000;
                next_state = STATE_0;
            end

            default: begin
                vector= 4'b0000;
            end
        endcase
    end

endmodule