module convert_3d_sub_to_1d_array #(
    parameter integer BIT_WIDTH = 4,
    parameter integer ROWS = 8,
    parameter integer COLS = 8,
    parameter integer SUB_ROWS = 4
) (
    input [BIT_WIDTH-1:0] in[ROWS-1:0][COLS-1:0],
    output [ROWS*COLS*BIT_WIDTH-1:0] out
);

    genvar i;
    genvar j;
    generate
        for (j = 0; j < COLS; j = j + 1) begin
            for (i = 0; i < SUB_ROWS; i = i + 1) begin
                assign out[BIT_WIDTH+(j*SUB_ROWS*BIT_WIDTH)+(i*BIT_WIDTH)-1-:BIT_WIDTH] = in[i][j];
            end
        end
    endgenerate

    genvar i_2;
    genvar j_2;
    generate
        for (j_2 = 0; j_2 < COLS; j_2 = j_2 + 1) begin
            for (i_2 = 0; i_2 < ROWS - SUB_ROWS; i_2 = i_2 + 1) begin
                assign out[BIT_WIDTH+(COLS*SUB_ROWS*BIT_WIDTH)+(j_2*(ROWS-SUB_ROWS)*BIT_WIDTH)+(i_2*BIT_WIDTH)-1-:BIT_WIDTH] = in[i_2+SUB_ROWS][j_2];
            end
        end
    endgenerate
endmodule
