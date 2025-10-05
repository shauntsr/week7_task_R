`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:42:20
// Design Name: 
// Module Name: draw_circle
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


module draw_circle (
    input  [15:0] colour,
    input  [ 6:0] px,
    py,
    base_x,
    base_y,
    output [15:0] oled_data
);
    localparam BLACK = 16'h0000;
    wire [6:0] x1;
    wire [6:0] x2;
    // check for underflow
    assign x1 = (px > base_x) ? px - base_x : base_x - px;
    assign x2 = (py > base_y) ? py - base_y : base_y - py;

    assign oled_data = ((x1 * x1) + (x2 * x2) <= 36) ? colour : BLACK;

endmodule
