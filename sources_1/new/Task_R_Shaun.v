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


module Task_R_Shaun (
    input clk,
    btnC,
    input [3:0] sw,
    output [7:0] JB
);

    wire clk_6p25MHz;
    clock_divider u_6p25Mhz (
        .clk(clk),
        .m(7),
        .slow_clock(clk_6p25MHz)
    );

    // OLED 
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    wire [15:0] pixel_data;  // Output data

    // Current drawing coordinate
    wire [ 6:0] x;
    wire [ 6:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;

    wire [31:0] controller_pixel_data;
    task_R_controller u_R_controller (
        .SW1(sw[1]),
        .SW3(sw[3]),
        .clk(clk),
        .x(x),
        .y(y),
        .pixel_data(controller_pixel_data)
    );

    assign pixel_data = controller_pixel_data;
    Oled_Display oled_display (
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
