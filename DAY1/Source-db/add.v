module add (
    input  wire [3:0] num1,
    input  wire [3:0] num2,
    output wire [4:0] result
);
    assign result = num1 + num2;
endmodule
