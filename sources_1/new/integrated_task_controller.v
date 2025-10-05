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


module integrated_task_controller (
    input clk,
    btnC,
    btnL,
    btnR,
    input [15:0] sw,
    input [12:0] pixel_index,
    output [15:0] display_data
);

    wire clk_6p25MHz;
    clock_divider u_6p25Mhz (
        .clk(clk),
        .m(7),
        .slow_clock(clk_6p25MHz)
    );

    wire clk_1KHz;
    clock_divider u_1Khz (
        .clk(clk),
        .m(49999),
        .slow_clock(clk_1KHz)
    );

    // Current drawing coordinate
    wire [6:0] x;
    wire [6:0] y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;

    // Task Q
    wire [31:0] Q_pixel_data;
    task_Q_controller u_Q_controller (
        .clk_1khz(clk_1KHz),
        .clk_6p25mhz(clk_6p25MHz),
        .btnL(btnL),
        .btnC(btnC),
        .btnR(btnR),
        .px(x),
        .py(y),
        .oled_data(Q_pixel_data)
    );


    // Task R
    wire [31:0] R_pixel_data;
    task_R_controller u_R_controller (
        .SW1(sw[1]),
        .SW3(sw[3]),
        .clk(clk),
        .x(x),
        .y(y),
        .pixel_data(R_pixel_data)
    );

    assign display_data = sw[14] ? R_pixel_data : sw[13] ? Q_pixel_data : 0;


endmodule

