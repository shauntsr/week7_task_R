`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 22:24:19
// Design Name: 
// Module Name: integrated_task
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


module integrated_task (
    input clk,
    btnC,
    btnL,
    btnR,
    btnU,
    btnD,
    input [15:0] sw,
    output [7:0] JB,
    output [7:0] seg,
    output [3:0] an
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


    // Task Controller (P Q R S
    wire [15:0] controller_pixel_data;

    integrated_task_controller integrated_controller (
        .clk(clk),
        .btnC(btnC),
        .btnL(btnL),
        .btnR(btnR),
        .btnD(btnD),
        .btnU(btnU),
        .sw(sw),
        .pixel_index(pixel_index),
        .display_data(pixel_data)
    );

    Oled_Display oled_display (
        .clk(clk_6p25MHz),
        .reset(0),
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

    // Group ID
    display_group_id u_display_id (
        .clk(clk),
        .seg(seg),
        .an (an)
    );
endmodule
