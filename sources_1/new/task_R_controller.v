`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 03:45:00
// Design Name: 
// Module Name: task_R_controller
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


module task_R_controller (
    input SW1,
    SW3,
    clk,
    input [6:0] x,
    y,
    output [31:0] pixel_data
);

    wire [15:0] vert_pixel_data;  // Output from vertically moving digit
    move_digit_vert u_move_vert (
        .clk(clk),
        .set(SW3),
        .value(9),
        .px(x),
        .py(y),
        .pixel_data(vert_pixel_data)
    );

    wire [15:0] horiz_pixel_data;  // Output from horizontally moving digit
    move_digit_horiz u_move_horiz (
        .clk(clk),
        .set(SW1),
        .value(9),
        .px(x),
        .py(y),
        .pixel_data(horiz_pixel_data)
    );

    // Vertical oscillating digit overrides
    assign pixel_data = (vert_pixel_data != 16'h0000) ? vert_pixel_data : horiz_pixel_data;

endmodule
