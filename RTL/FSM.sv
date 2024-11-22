module fsm #(
    parameter STATE_WIDTH = 3 // Width of state encoding (log2 of the number of states)
) (
    input logic clk,          // Clock signal
    input logic rstn,         // Asynchronous reset (active low)
    input logic [3:0] in,     // Example input
    output logic [3:0] out    // Example output
);

    // State Encoding
    typedef enum logic [STATE_WIDTH-1:0] {
        IDLE      = 3'b000,   // State 0: Idle
        STATE_1   = 3'b001,   // State 1
        STATE_2   = 3'b010,   // State 2
        STATE_3   = 3'b011    // State 3
        // Add more states as needed
    } state_t;

    state_t current_state, next_state;

    // Sequential Logic: State Transition
    always_ff @(posedge clk or negedge rstn) begin
        if (!rstn)
            current_state <= IDLE;  // Reset state
        else
            current_state <= next_state;
    end

    // Combinational Logic: Next-State Logic and Output Logic
    always_comb begin
        // Default values
        next_state = current_state;
        out = 4'b0000;

        case (current_state)
            IDLE: begin
                if (in[0]) 
                    next_state = STATE_1;
                else if (in[1]) 
                    next_state = STATE_2;
            end

            STATE_1: begin
                out = 4'b0001;  // Example output
                if (in[2]) 
                    next_state = STATE_2;
                else 
                    next_state = IDLE;
            end

            STATE_2: begin
                out = 4'b0010;  // Example output
                if (in[3]) 
                    next_state = STATE_3;
                else 
                    next_state = IDLE;
            end

            STATE_3: begin
                out = 4'b0100;  // Example output
                next_state = IDLE; // Go back to IDLE
            end

            default: begin
                next_state = IDLE; // Default transition
            end
        endcase
    end

endmodule