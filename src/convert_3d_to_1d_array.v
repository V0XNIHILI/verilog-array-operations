module convert_3d_to_1d_array
// Layout of 'out' port from right to left:
// column 0 + row 0, column 1 + row 0, column 2 + row 0, ... , column 0 + row 1, column 1 + row 1, column 2 + row 1, ... 
#(
    parameter int BIT_WIDTH = 4,
    parameter int ROWS = 8,
    parameter int COLS = 8
) (
    input [BIT_WIDTH-1:0] in[ROWS-1:0][COLS-1:0],
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
