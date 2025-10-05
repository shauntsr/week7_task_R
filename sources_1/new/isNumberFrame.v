`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 00:28:13
// Design Name: 
// Module Name: isNumberFrame
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


module isNumberFrame (
    input [6:0] x,
    input [5:0] y,
    input clk,
    output reg signalOut = 0
);
    wire xIn;
    wire yIn;

    always @(posedge clk) begin
        if (( (((x > 4 & x < 8) | (x > 29 & x < 33)) & (y > 30 & y < 59)) ) || 
            ( (((y > 30 & y < 34) | (y > 55 & y < 59)) & (x > 4 & x < 33)) )) begin
            signalOut <= 1;
        end else signalOut <= 0;
    end
endmodule
