# Verilog array operations

This repository contains a few simple modules to perform, among other things, array-shape conversion in Verilog. For example, it is possible to convert a 1D array of n-bit values to a 2D (or 3D) array of m-bit values, and vice versa.

This can be useful when reading data from a memory (SRAM or register file), where the data is stored in a different shape than the one you want to use in your design.

## Available modules

subrow0,col0;subrow1,col0;subrow2,col0;subrow3,col0;subrow1,col1;subrow2,col1;subrow3,col1;subrow2,col2;subrow3,col2;subrow3,col3;row0,col4

- [`convert_1d_to_2d_array`](./src/convert_1d_to_2d_array.v)
- [`convert_2d_to_1d_array`](./src/convert_2d_to_1d_array.v)
- [`convert_1d_to_3d_array`](./src/convert_1d_to_3d_array.v)
- [`convert_3d_to_1d_array`](./src/convert_3d_to_1d_array.v)
- [`convert_1d_sub_to_3d_array`](./src/convert_1d_sub_to_3d_array.v)
- [`convert_3d_to_1d_sub_array`](./src/convert_3d_to_1d_sub_array.v)
- [`to_diagonal_3d_array`](./src/to_diagonal_3d_array.v)

## Example usage

### Code examples

#### Shape conversion

The below code example shows how to use the `convert_1d_to_2d_array` module to convert a 1D array of 256-bit values to a 2D array of 64x 4-bit values. For 1D-to-3D conversion, use `convert_1d_to_3d_array` instead. The syntax for 2D-to-1D and 3D-to-1D conversion is analogous.

```verilog
localparam WORD_BIT_WIDTH = 256;
localparam ENTRY_BIT_WIDTH = 4;
localparam VECTOR_SIZE = 64;

wire [WORD_BIT_WIDTH-1:0] in_data = ...;
wire [ENTRY_BIT_WIDTH-1:0] out_data [VECTOR_SIZE-1:0];

convert_1d_to_2d_array #(
    .BIT_WIDTH(ENTRY_BIT_WIDTH),
    .COLS(VECTOR_SIZE)
) convert_data_to_array (
    .in(in_data),
    .out(out_data)
);
```

#### Diagonalization

```verilog
localparam ENTRY_BIT_WIDTH = 4;
localparam ROWS = 8;
localparam COLS = 8;

wire [ENTRY_BIT_WIDTH-1:0] diagonal_value = ...;
wire [ENTRY_BIT_WIDTH-1:0] out_data [ROWS][COLS];

to_diagonal_3d_array #(
    .BIT_WIDTH(ENTRY_BIT_WIDTH),
    .ROWS(ROWS),
    .COLS(COLS)
) put_value_into_diagonal_matrix (
    .in(diagonal_value),
    .out(out_data)
);
```

### Conditional array

```verilog
localparam ENTRY_BIT_WIDTH = 4;
localparam ROWS = 8;
localparam COLS = 8;

wire condition = ...;
wire [ENTRY_BIT_WIDTH-1:0] pass_if_true [ROWS][COLS];
wire [ENTRY_BIT_WIDTH-1:0] pass_if_false [ROWS][COLS];
wire [ENTRY_BIT_WIDTH-1:0] out_data [ROWS][COLS];

conditional_3d_array #(
    .BIT_WIDTH(ENTRY_BIT_WIDTH),
    .ROWS(ROWS),
    .COLS(COLS)
) conditional_array (
    .in(condition),
    .if_true(pass_if_true),
    .if_false(pass_if_false),
    .out(out_data)
);
```

### Data layout

#### `convert_1d_to_2d_array` (and vice versa for `convert_2d_to_1d_array`)

Input (`12'b011011100101`, `BIT_WIDTH = 4`, `COLS = 3`)

|MSB|   |   |   |   |   |   |   |   |   |   |LSB|
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1 | 0 | ***1*** | ***1*** | ***1*** | ***0*** | 0 | 1 | 0 | 1 |

Output:

|idx|   |   |   |   |
|---|---|---|---|---|
| 0 | 0 | 1 | 0 | 1 |
| 1 | ***1*** | ***1*** | ***1*** | ***0*** |
| 2 | 0 | 1 | 1 | 0 |

#### `convert_1d_to_3d_array` (and vice versa for `convert_3d_to_1d_array`)

Input (`30b'011010100101011011100100011011`, `BIT_WIDTH = 4`, `ROWS = 5`, `COLS = 3`)

|MSB|   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |LSB|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1 | 0 | 1 | 0 | 1 | 0 | ***0*** | ***1*** | 0 | 1 | 1 | 0 | 1 | 1 | 1 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 1 | 1 |

Output:

| row/ column | 0  | 1  | 2  |
|-------------|----|----|----|
| 0           | *11* | 10 | 01 |
| 1           | 00 | 01 | 10 |
| 2           | 11 | 10 | 01 |
| 3           | 01 |***01***| 10 |
| 4           | 10 | 10 | 01 |

#### `convert_1d_to_3d_sub_array` (and vice versa for `convert_3d_sub_to_1d_array`)

Basically, the first (starting as LSB) `BIT_WIDTH * SUB_ROWS * SUB_COLS` bits of the input are converted to a 3D array, exactly as in `convert_1d_to_3d_array`. This makes sure that in these LSB, you have a subarray. The remaining bits are then also put into the 3D, by first filling up the remaining values in the subrows of the columns outside the subarray. Finally, the remaining rows are filled up.
