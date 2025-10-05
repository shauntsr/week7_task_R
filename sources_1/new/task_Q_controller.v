`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 12:38:51
// Design Name: 
// Module Name: task_Q_controller
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


module task_Q_controller (
    input clk_1khz,
    clk_6p25mhz,
    input btnL,
    btnC,
    btnR,
    input [6:0] px,
    input [5:0] py,
    output [15:0] oled_data
);

    wire btnL_debounced, btnC_debounced, btnR_debounced;
    debouncer u_btnL (
        clk_1khz,
        btnL,
        btnL_debounced
    );
    debouncer u_btnC (
        clk_1khz,
        btnC,
        btnC_debounced
    );
    debouncer u_btnR (
        clk_1khz,
        btnR,
        btnR_debounced
    );

    // Square Colour Sequence
    // 0: Red > 1: Blue > 2: Yellow > 3: Green > 4: White > 0: Red

    /*
    wire [2:0] left_square_colour = 3;
    assign left_square_colour = btnL_debounced 
        ? (left_square_colour == 4 ? 0 : left_square_colour + 1) 
        : left_square_colour;
    */

    wire [2:0] left_square_colour;
    wire [2:0] middle_square_colour;
    wire [2:0] right_square_colour;
    localparam left_square_colour_init = 0;
    localparam middle_square_colour_init = 3;
    localparam right_square_colour_init = 1;
    set_square_colour #(
        .INIT_COLOUR(left_square_colour_init)
    ) uLeftSquareColour (
        .clk(clk_1khz),
        .btn(btnL_debounced),
        .colour(left_square_colour)
    );
    set_square_colour #(
        .INIT_COLOUR(middle_square_colour_init)
    ) uMiddleSquareColour (
        .clk(clk_1khz),
        .btn(btnC_debounced),
        .colour(middle_square_colour)
    );
    set_square_colour #(
        .INIT_COLOUR(right_square_colour_init)
    ) uRightSquareColour (
        .clk(clk_1khz),
        .btn(btnR_debounced),
        .colour(right_square_colour)
    );

    draw_stuff udraw (
        .clk_1khz(clk_1khz),
        .clk_6p25mhz(clk_6p25mhz),
        .px(px),
        .py(py),
        .left_square_colour(left_square_colour),
        .middle_square_colour(middle_square_colour),
        .right_square_colour(right_square_colour),
        .oled_data(oled_data)
    );

endmodule
