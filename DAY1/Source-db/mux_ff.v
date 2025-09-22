module mux_ff (
    input  wire A,
    input  wire B,
    input  wire sel,
    input  wire clock,
    input  wire reset,
    output reg  Q
);
    wire int;
    assign int = sel ? A : B;

    always @(posedge clock or posedge reset) begin
        if (reset)
            Q <= 1'b0;
        else
            Q <= int;
    end
endmodule

