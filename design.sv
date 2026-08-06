module mealy_fsm(
    input clk,
    input reset,
    input in,
    output reg out
);
reg state;
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 0;
        out <= 0;
    end
    else begin
        case(state)
            0: begin
                if (in) begin
                    state <= 1;
                    out <= 0;
                end
                else begin
                    state <= 0;
                    out <= 0;
                end
            end
            1: begin
                if (in) begin
                    state <= 1;
                    out <= 1;
                end
                else begin
                    state <= 0;
                    out <= 0;
                end
            end
            default: begin
                state <= 0;
                out <= 0;
            end
        endcase
    end
end
endmodule