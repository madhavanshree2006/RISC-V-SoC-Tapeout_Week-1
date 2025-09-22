module good_mux (
    input  wire i0,
    input  wire i1,
    input  wire sel,
    output reg  y
);
    always @(*) begin
        if (sel)
            y <= i1;
        else
            y <= i0;
    end
endmodule

