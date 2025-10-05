`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 17:34:48
// Design Name: 
// Module Name: draw_square
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


module draw_square #(
    parameter integer WIDTH  = 20,
    parameter integer HEIGHT = 20
) (
    input clk,
    input [6:0] px,
    input [5:0] py,
    input [6:0] base_x,
    input [5:0] base_y,
    input [2:0] colour,
    output reg [15:0] oled_data
);

    // 0: Red > 1: Blue > 2: Yellow > 3: Green > 4: White > 0: Red
    localparam BLACK = 16'h0000;
    localparam WHITE = 16'hFFFF;
    localparam RED = 16'hF800;
    localparam GREEN = 16'h07E0;
    localparam YELLOW = 16'hFFE0;
    localparam BLUE = 16'h001F;
    localparam MAGENTA = 16'hF81F;

    always @(posedge clk) begin
        if (px >= base_x && px <= base_x + WIDTH && py >= base_y && py <= base_y + HEIGHT) begin
            case (colour)
                3'd0: oled_data <= RED;
                3'd1: oled_data <= BLUE;
                3'd2: oled_data <= YELLOW;
                3'd3: oled_data <= GREEN;
                3'd4: oled_data <= WHITE;
                default: oled_data <= BLACK;
            endcase
        end else begin
            oled_data <= BLACK;
        end
    end
endmodule
