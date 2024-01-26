module convert_2d_to_1d_array
// Layout of 'out' port from right to left:
// column 0, column 1, column 2, ...
#(
    parameter BIT_WIDTH = 4,
    parameter COLS = 8
) (
    input [BIT_WIDTH-1:0] in[COLS-1:0],
    output [COLS*BIT_WIDTH-1:0] out
);

    genvar i;
    generate
        for (i = 0; i < COLS; i = i + 1) begin
            assign out[BIT_WIDTH+(i*BIT_WIDTH)-1-:BIT_WIDTH] = in[i];
        end
    endgenerate
endmodule
