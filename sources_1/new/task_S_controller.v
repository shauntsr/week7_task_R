`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:52:40
// Design Name: 
// Module Name: task_S_controller
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


module task_S_controller (
    input btnU,
    input btnR,
    input btnL,
    input btnD,
    input clk,
    input [6:0] x,
    input [5:0] y,
    output reg [15:0] oled_data
);

    wire CLK25;
    wire CLK50Hz;

    clock_divider refreshClk (
        .clk(clk),
        .m(8),
        .slow_clock(CLK25)
    );
    clock_divider movementClock (
        .clk(clk),
        .m(1_000_000),
        .slow_clock(CLK50Hz)
    );


    reg  [6:0] circle_x;
    reg  [5:0] circle_y;
    wire [6:0] x_mover;
    wire [5:0] y_mover;

    always @(posedge CLK25) begin
        circle_x <= x_mover;
        circle_y <= y_mover;
    end

    moveCircle circleMover (
        .clk50hz(CLK50Hz),
        .clk25mhz(CLK25),
        .btnU(btnU),
        .btnD(btnD),
        .btnR(btnR),
        .btnL(btnL),
        .x_out(x_mover),
        .y_out(y_mover)
    );

    wire numberFrame;
    wire number;
    wire isCircle;
    isNumberFrame determineNumberFrame (
        .x(x),
        .y(y),
        .signalOut(numberFrame)
    );
    isNumber determineNumber (
        .x(x),
        .y(y),
        .signalOut(number)
    );
    circle findCircle (
        .x(x),
        .y(y),
        .circle_x(circle_x),
        .circle_y(circle_y),
        .signalOut(isCircle)
    );

    always @(posedge CLK25) begin
        if (isCircle) begin
            oled_data = 16'hf800;
        end else if (numberFrame) begin
            oled_data = 16'hffff;
        end else if (number) begin
            oled_data = 16'h07e0;
        end else begin
            oled_data = 16'h0000;
        end
    end

endmodule
