# Verilog array-shape conversion

This repository contains a few simple modules to perform, among other things, array-shape conversion in Verilog. For example, it is possible to convert a 1D array of n-bit values to a 2D (or 3D) array of m-bit values, and vice versa.

## Example usage

### `convert_1d_to_2d_array` (and vice versa for `convert_2d_to_1d_array`)

Input (`12'b011011100101`):

|MSB|   |   |   |   |   |   |   |   |   |   |LSB|
|---|---|---|---|---|---|---|---|---|---|---|---|
| 0 | 1 | 1 | 0 | ***1*** | ***1*** | ***1*** | ***0*** | 0 | 1 | 0 | 1 |

Output:

|idx|   |   |   |   |
|---|---|---|---|---|
| 0 | 0 | 1 | 0 | 1 |
| 1 | ***1*** | ***1*** | ***1*** | ***0*** |
| 2 | 0 | 1 | 1 | 0 |
