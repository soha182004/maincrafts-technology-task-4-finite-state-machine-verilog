module password_lock(
    input clk,
    input reset,
    input key,
    output reg unlock
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] state;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= S0;
        unlock <= 0;
    end
    else
    begin
        unlock <= 0;

        case(state)

            // First correct key
            S0:
            begin
                if(key)
                    state <= S1;
            end

            // Second correct key
            S1:
            begin
                if(key)
                    state <= S2;
                else
                    state <= S0;
            end

            // Third correct key
            S2:
            begin
                if(key)
                begin
                    state <= S3;
                    unlock <= 1;
                end
                else
                    state <= S0;
            end

            // Door unlocked
            S3:
            begin
                state <= S0;
                unlock <= 0;
            end

            default:
            begin
                state <= S0;
                unlock <= 0;
            end

        endcase
    end
end

endmodule