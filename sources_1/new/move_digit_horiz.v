`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 03:05:25
// Design Name: 
// Module Name: move_digit_horiz
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// Determines if the coordinate is inside the moving digit's drawn params
// Returns COLOUR if inside, BLACK otherwise.
module move_digit_horiz #(
    parameter integer OLED_WIDTH      = 96,
    parameter integer DIGIT_WIDTH     = 16,
    parameter integer DIGIT_HEIGHT    = 24,
    parameter integer DIGIT_THICKNESS = 4
) (
    input clk,
    input en,
    input [3:0] value,
    input [6:0] px,
    py,
    output [15:0] pixel_data
);

    localparam [15:0] BLUE = 16'h043F;

    // Max x-value is 96 - 16 = 80
    // Traverse finish in 3s -> 27 Hz
    // 1.8 mil count gives about 27.7 Hz
    wire clk_16p7Hz;
    clock_divider u_16p7Hz (
        .clk(clk),
        .m(1800000),
        .slow_clock(clk_16p7Hz)
    );

    wire [6:0] horiz_x, horiz_y;
    assign horiz_y = 6'd20;  // 

    // Find where the digit's top left corner is
    oscillate u_oscillate (
        .en(en),
        .lower_bound(0),
        .upper_bound(OLED_WIDTH - DIGIT_WIDTH),
        .clk(clk_16p7Hz),
        .coord(horiz_x)
    );

    wire [15:0] oled_data;
    assign pixel_data = oled_data;
    draw_digit #(
        .WIDTH(DIGIT_WIDTH),
        .HEIGHT(DIGIT_HEIGHT),
        .THICKNESS(DIGIT_THICKNESS)
    ) u_vert_digit (
        .set(1),
        .value(9),
        .px(px),
        .py(py),
        .base_x(horiz_x),
        .base_y(horiz_y),
        .colour(BLUE),
        .oled_data(oled_data)
    );

endmodule
