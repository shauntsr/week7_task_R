`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 00:27:25
// Design Name: 
// Module Name: circle
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


module circle (
    input [6:0] x,
    input [5:0] y,
    input [6:0] circle_x,
    input [5:0] circle_y,
    output signalOut
);
    assign signalOut = ( ((x - circle_x) * (x - circle_x) + 
    ( y - circle_y) * ( y - circle_y) ) < 101)? 1 : 0;

endmodule
