module convert_1d_to_3d_array
// Layout of 'in' port from right to left:
// column 0 + row 0, column 1 + row 0, column 2 + row 0, ... , column 0 + row 1, column 1 + row 1, column 2 + row 1, ... 
#(
    parameter BIT_WIDTH = 4,
    parameter ROWS = 8,
    parameter COLS = 8
) (
    input [ROWS*COLS*BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[ROWS-1:0][COLS-1:0]
);

    genvar i;
    genvar j;
    generate
        for (j = 0; j < COLS; j = j + 1) begin
            for (i = 0; i < ROWS; i = i + 1) begin
                assign out[i][j] = in[BIT_WIDTH+(j*ROWS*BIT_WIDTH)+(i*BIT_WIDTH)-1-:BIT_WIDTH];
            end
        end
    endgenerate
endmodule
