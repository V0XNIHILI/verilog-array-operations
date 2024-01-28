module convert_1d_to_3d_sub_array #(
    parameter int BIT_WIDTH = 4,
    parameter int ROWS = 8,
    parameter int COLS = 8,
    parameter int SUB_ROWS = 4,
    parameter int SUB_COLS = 4
) (
    input [ROWS*COLS*BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[ROWS-1:0][COLS-1:0]
);

    genvar i;
    genvar j;
    generate
        for (j = 0; j < COLS; j = j + 1) begin
            for (i = 0; i < SUB_ROWS; i = i + 1) begin
                assign out[i][j] = in[BIT_WIDTH+(j*SUB_ROWS*BIT_WIDTH)+(i*BIT_WIDTH)-1-:BIT_WIDTH];
            end
        end
    endgenerate

    genvar i_2;
    genvar j_2;
    generate
        for (j_2 = 0; j_2 < COLS; j_2 = j_2 + 1) begin
            for (i_2 = 0; i_2 < ROWS - SUB_ROWS; i_2 = i_2 + 1) begin
                assign out[i_2+SUB_ROWS][j_2] = in[BIT_WIDTH+(COLS*SUB_ROWS*BIT_WIDTH)+(j_2*(ROWS-SUB_ROWS)*BIT_WIDTH)+(i_2*BIT_WIDTH)-1-:BIT_WIDTH];
            end
        end
    endgenerate
endmodule
