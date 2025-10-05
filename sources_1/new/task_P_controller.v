`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:27:57
// Design Name: 
// Module Name: task_P_controller
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


module task_P_controller (
    input clk,
    input btnC,
    btnL,
    btnR,
    input [6:0] x,
    y,
    output [15:0] oled_data
);

    // clocks
    wire clock_6p25MHz;
    wire clock_1000Hz;
    clock_divider u6p25Mhz (
        clk,
        7,
        clock_6p25MHz
    );
    clock_divider u1000Hz (
        clk,
        49999,
        clock_1000Hz
    );

    // toggle both 9s, with debouncing
    wire [1:0] set9;  // left bit (MSB) sets left 9 drawn, right bit sets right 9 drawn
    button_controller(
        .clk(clk), .clock_1000Hz(clock_1000Hz), .btnL(btnL), .btnR(btnR), .set9(set9)
    );


    draw_characters draw (
        .px(x),
        .py(y),
        .set9(set9),
        .clock_1000Hz(clock_1000Hz),
        .btnL(btnL),
        .btnR(btnR),
        .oled_data(oled_data)
    );

endmodule
