module to_diagonal_3d_array #(
    parameter integer BIT_WIDTH = 4,
    parameter integer ROWS = 8,
    parameter integer COLS = 8
) (
    input  [BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[ROWS][COLS]
);

    genvar i;
    genvar j;
    generate
        for (i = 0; i < ROWS; i = i + 1) begin
            for (j = 0; j < COLS; j = j + 1) begin
                assign out[i][j] = (i == j) ? in : 0;
            end
        end
    endgenerate

endmodule
