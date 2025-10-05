`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 17:41:57
// Design Name: 
// Module Name: set_square_colour
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


module set_square_colour #(
    parameter integer INIT_COLOUR = 0
) (
    input clk,
    btn,
    output reg [2:0] colour
);

    reg init = 0;
    // 0: Red > 1: Blue > 2: Yellow > 3: Green > 4: White > 0: Red
    always @(posedge clk) begin
        if (~init) begin
            init   <= 1;
            colour <= INIT_COLOUR;
        end else if (btn) begin
            colour <= (colour == 4) ? 0 : colour + 1;
        end
    end
endmodule
