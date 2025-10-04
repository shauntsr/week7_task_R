`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 23:52:33
// Design Name: 
// Module Name: Task_R_Shaun
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


module Task_R_Shaun (input clk, btnC, input [3:0] sw, output [7:0] JB);

    wire clk_6p25MHz;
    clock_divider u_6p25Mhz(clk, 7, clk_6p25MHz);

    // OLED 
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [15:0] pixel_data; // Output data

    // Current drawing coordinate
    wire [6:0] x;
    wire [6:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;

    wire [15:0] vert_pixel_data; // Output from vertically moving digit
    move_digit_vert u_move_vert(
        .clk(clk),
        .set(sw[3]),
        .value(9),
        .px(x),
        .py(y),
        .pixel_data(vert_pixel_data)
    );

    wire [15:0] horiz_pixel_data; // Output from horizontally moving digit
    move_digit_horiz u_move_horiz(
        .clk(clk),
        .set(sw[1]),
        .value(9),
        .px(x),
        .py(y),
        .pixel_data(horiz_pixel_data)
    );

    // Vertical oscillating digit overrides
    assign pixel_data = (vert_pixel_data != 16'h0000) 
                        ? vert_pixel_data
                        : horiz_pixel_data;

    Oled_Display oled_display(
        .clk(clk_6p25MHz), 
        .reset(btnC), 
        .frame_begin(frame_begin), 
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel), 
        .pixel_index(pixel_index), 
        .pixel_data(pixel_data), 
        .cs(JB[0]), 
        .sdin(JB[1]), 
        .sclk(JB[3]), 
        .d_cn(JB[4]), 
        .resn(JB[5]), 
        .vccen(JB[6]),
        .pmoden(JB[7])
    );

endmodule
