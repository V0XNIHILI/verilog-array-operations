module convert_1d_to_2d_array
// Layout of 'in' port from right to left:
// column 0, column 1, column 2, ... 
#(
    parameter BIT_WIDTH = 4,
    parameter COLS = 8
) (
    input [COLS*BIT_WIDTH-1:0] in,
    output [BIT_WIDTH-1:0] out[COLS-1:0]
);

    genvar i;
    generate
        for (i = 0; i < COLS; i = i + 1) begin
            assign out[i] = in[BIT_WIDTH+(i*BIT_WIDTH)-1-:BIT_WIDTH];
        end
    endgenerate
endmodule
