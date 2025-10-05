`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 00:26:09
// Design Name: 
// Module Name: isNumber
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


module isNumber (
    input [6:0] x,
    input [5:0] y,
    output signalOut
);

    wire hor1;
    wire hor2;
    wire hor3;
    wire ver1;
    wire ver2;

    assign signalOut = hor1 | hor2 | hor3 | ver1 | ver2;
    assign hor1 = (y > 37 & y < 41 & x > 15 & x < 25);
    assign hor2 = (y > 43 & y < 47 & x > 15 & x < 25);
    assign hor3 = (y > 49 & y < 53 & x > 15 & x < 25);
    assign ver1 = (x > 21 & x < 24 & y > 40 & y < 44);
    assign ver2 = (x > 15 & x < 19 & y > 46 & y < 50);
endmodule
