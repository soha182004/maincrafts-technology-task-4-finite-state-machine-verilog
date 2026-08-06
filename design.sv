module sequence_detector(
    input clk,
    input reset,
    input in,
    output reg detected
);
reg [2:0] state;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        detected <= 0;
    end
    else begin
        detected <= 0;

        case(state)

            // S0
            0: begin
                state <= (in) ? 1 : 0;
            end

            // S1
            1: begin
                state <= (in) ? 1 : 2;
            end

            // S2
            2: begin
                state <= (in) ? 3 : 0;
            end

            // S3
            3: begin
                if(in) begin
                    detected <= 1;
                    state <= 1;
                end
                else begin
                    state <= 2;
                end
            end

            default: begin
                state <= 0;
                detected <= 0;
            end

        endcase
    end
end

endmodule