module conditional_3d_array #(
    parameter integer BIT_WIDTH = 4,
    parameter integer ROWS = 8,
    parameter integer COLS = 8
) (
    input condition,

    input [BIT_WIDTH-1:0] if_true [ROWS][COLS],
    input [BIT_WIDTH-1:0] if_false[ROWS][COLS],

    output [BIT_WIDTH-1:0] out[ROWS][COLS]
);

    wire [ROWS*COLS*BIT_WIDTH-1:0] if_true_1d;

    convert_3d_to_1d_array #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROWS(ROWS),
        .COLS(COLS)
    ) convert_3d_to_1d_array_if_true (
        .in (if_true),
        .out(if_true_1d)
    );

    wire [ROWS*COLS*BIT_WIDTH-1:0] if_false_1d;

    convert_3d_to_1d_array #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROWS(ROWS),
        .COLS(COLS)
    ) convert_3d_to_1d_array_if_false (
        .in (if_false),
        .out(if_false_1d)
    );

    convert_1d_to_3d_array #(
        .BIT_WIDTH(BIT_WIDTH),
        .ROWS(ROWS),
        .COLS(COLS)
    ) convert_1d_to_3d_array_inst (
        .in (condition ? if_true_1d : if_false_1d),
        .out(out)
    );

endmodule
