`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 01:49:26
// Design Name: 
// Module Name: move_digit_vert
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
module move_digit_vert #(
    parameter integer OLED_HEIGHT     = 64,
    parameter integer DIGIT_WIDTH     = 16,
    parameter integer DIGIT_HEIGHT    = 24,
    parameter integer DIGIT_THICKNESS = 4
) (
    input clk,
    input set,
    input [3:0] value,
    input [6:0] px, py,
    output [15:0] pixel_data
);

    localparam [15:0] ORANGE = 16'hFDA0; 

    // Max y-value is 64 - 24 = 40
    // Traverse finish in 3s -> 13 Hz
    // 4 mil count gives about 12 Hz
    wire clk_2Hz;
    clock_divider u_2Hz (clk, 4000000, clk_2Hz);

    wire [6:0] horiz_x, horiz_y;
    assign horiz_x = 6'd40; // 

    // Find where the digit's top left corner is
    oscillate u_oscillate (
        .set(set),
        .lower_bound(0),
        .upper_bound(OLED_HEIGHT - DIGIT_HEIGHT),
        .clk(clk_2Hz),
        .coord(horiz_y)
    );

    wire [15:0] oled_data;
    assign pixel_data = oled_data;
    draw_digit #(
        .WIDTH(DIGIT_WIDTH), 
        .HEIGHT(DIGIT_HEIGHT), 
        .THICKNESS(DIGIT_THICKNESS)
    ) u_vert_digit (
        .set(1),
        .value(7),
        .px(px),
        .py(py),
        .base_x(horiz_x),
        .base_y(horiz_y),
        .colour(ORANGE),
        .oled_data(oled_data)
    );

endmodule
