module to_diagonal_3d_array #(
    parameter int BIT_WIDTH = 4,
    parameter int ROWS = 8,
    parameter int COLS = 8
) (
    input  [BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[ROWS-1:0][COLS-1:0]
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
