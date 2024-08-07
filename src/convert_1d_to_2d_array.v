module convert_1d_to_2d_array
// Layout of 'in' port from right to left:
// column 0, column 1, column 2, ... 
#(
    parameter integer BIT_WIDTH = 4,
    parameter integer COLS = 8
) (
    input [COLS*BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[COLS]
);

    genvar i;
    generate
        for (i = 0; i < COLS; i = i + 1) begin
            assign out[i] = in[BIT_WIDTH+(i*BIT_WIDTH)-1-:BIT_WIDTH];
        end
    endgenerate
endmodule
