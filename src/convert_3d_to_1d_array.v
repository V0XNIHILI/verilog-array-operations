module convert_3d_to_1d_array
// Layout of 'out' port from right to left:
// column 0 + row 0, column 1 + row 0, column 2 + row 0, ... , column 0 + row 1, column 1 + row 1, column 2 + row 1, ... 
#(
    parameter integer BIT_WIDTH = 4,
    parameter integer ROWS = 8,
    parameter integer COLS = 8
) (
    input [BIT_WIDTH-1:0] in[ROWS][COLS],
    output [ROWS*COLS*BIT_WIDTH-1:0] out
);

    genvar i;
    genvar j;
    generate
        for (j = 0; j < COLS; j = j + 1) begin
            for (i = 0; i < ROWS; i = i + 1) begin
                assign out[BIT_WIDTH+(j*ROWS*BIT_WIDTH)+(i*BIT_WIDTH)-1-:BIT_WIDTH] = in[i][j];
            end
        end
    endgenerate
endmodule
