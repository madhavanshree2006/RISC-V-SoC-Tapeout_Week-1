module sample_code (
    input  wire clk,
    input  wire rst,
    output reg  result,
    output reg  done
);
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            // reset condition
            result <= 1'b0;
            done   <= 1'b0;
        end else begin
            // functional behavior
        end
    end
endmodule
