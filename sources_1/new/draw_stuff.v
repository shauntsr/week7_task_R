`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 18:07:02
// Design Name: 
// Module Name: draw_stuff
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


module draw_stuff (
    input clk_1khz,
    clk_6p25mhz,
    input [6:0] px,
    input [5:0] py,
    input [2:0] left_square_colour,
    middle_square_colour,
    right_square_colour,
    output [15:0] oled_data
);

    // Top-left x-coordinate of each square
    localparam left_square_x = 10;
    localparam middle_square_x = 40;
    localparam right_square_x = 70;

    // Top-left y-coordinate of all squares
    localparam all_squares_y = 40;

    wire [15:0] left_data, middle_data, right_data;  // output colour of each draw_square module
    draw_square uLeftSquare (
        .clk(clk_6p25mhz),
        .px(px),
        .py(py),
        .base_x(left_square_x),
        .base_y(all_squares_y),
        .colour(left_square_colour),
        .oled_data(left_data)
    );
    draw_square uMiddleSquare (
        .clk(clk_6p25mhz),
        .px(px),
        .py(py),
        .base_x(middle_square_x),
        .base_y(all_squares_y),
        .colour(middle_square_colour),
        .oled_data(middle_data)
    );
    draw_square uRightSquare (
        .clk(clk_6p25mhz),
        .px(px),
        .py(py),
        .base_x(right_square_x),
        .base_y(all_squares_y),
        .colour(right_square_colour),
        .oled_data(right_data)
    );

    reg isDrawDigit = 0;

    always @(posedge clk_1khz) begin
        if (left_square_colour == 3 && middle_square_colour == 2 && right_square_colour == 1) begin
            isDrawDigit <= 1;
        end else begin
            isDrawDigit <= 0;
        end
    end

    localparam integer DIGIT = 6;
    localparam integer DIGIT_WIDTH = 6;
    localparam integer DIGIT_HEIGHT = 13;
    localparam integer DIGIT_THICKNESS = 2;
    localparam integer DIGIT_BASE_X = 80;
    localparam integer DIGIT_BASE_Y = 8;
    localparam BLACK = 16'h0000;
    localparam MAGENTA = 16'hF81F;
    localparam DIGIT_COLOUR = MAGENTA;
    wire [15:0] digit_data;
    draw_digit #(
        .WIDTH(DIGIT_WIDTH),
        .HEIGHT(DIGIT_HEIGHT),
        .THICKNESS(DIGIT_THICKNESS)
    ) uDigit (
        .set(isDrawDigit),
        .value(DIGIT),
        .px(px),
        .py(py),
        .base_x(DIGIT_BASE_X),
        .base_y(DIGIT_BASE_Y),
        .colour(DIGIT_COLOUR),
        .oled_data(digit_data)
    );

    assign oled_data = (left_data != BLACK) ? left_data :
                       (middle_data != BLACK) ? middle_data :
                       (right_data != BLACK) ? right_data :
                       (digit_data != BLACK) ? digit_data :
                       BLACK;
endmodule
