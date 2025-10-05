`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:33:33
// Design Name: 
// Module Name: draw_characters
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


module draw_characters (
    input [6:0] px,
    py,
    input [1:0] set9,
    input clock_1000Hz,
    btnL,
    btnR,  // for circle sampling
    output [15:0] oled_data
);
    localparam BLACK = 16'h0000;
    localparam WHITE = 16'hFFFF;
    localparam GREEN = 16'h07E0;
    localparam RED = 16'hF800;
    localparam BLUE = 16'h001F;
    localparam MAGENTA = 16'hF87A;

    // describes the top left positions of left and right characters to be drawn
    localparam LEFTCHAR_x = 18;
    localparam RIGHTCHAR_x = 50;

    localparam CHAR_y = 8;
    localparam circle_x = 7;
    localparam circle_y = 7;
    wire [15:0] left_data, right_data, circle_data;  // output colour of individual draw modules

    draw_digit uLeft9 (
        .set(set9[1]),
        .value(9),
        .px(px),
        .py(py),
        .base_x(LEFTCHAR_x),
        .base_y(CHAR_y),
        .colour(RED),
        .oled_data(left_data)
    );
    draw_digit uRight9 (
        .set(set9[0]),
        .value(9),
        .px(px),
        .py(py),
        .base_x(RIGHTCHAR_x),
        .base_y(CHAR_y),
        .colour(GREEN),
        .oled_data(right_data)
    );

    // poll btns to change circle color at 1000Hz
    reg [15:0] circle_col = WHITE;
    always @(posedge clock_1000Hz) begin
        if (btnL || btnR) circle_col <= MAGENTA;
        else circle_col <= WHITE;
    end

    draw_circle uCircle (
        .px(px),
        .py(py),
        .base_x(circle_x),
        .base_y(circle_y),
        .colour(circle_col),
        .oled_data(circle_data)
    );

    assign oled_data = (left_data != BLACK) ? left_data :
                       (right_data != BLACK) ? right_data :
                       (circle_data != BLACK) ? circle_data :
                       BLACK;
endmodule
