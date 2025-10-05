`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 17:50:57
// Design Name: 
// Module Name: debouncer
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


module debouncer (
    // Checks every 1ms for new input, but doesn't register until 200ms after previous registered input
    input clk_1000Hz,
    input btn,
    output reg debounced = 0
);

    reg [7:0] count = 0;  // counts from 0 to 200
    reg is_pressed = 0;

    // produces a HIGH for 1ms for a single press; no matter how many presses within 200ms
    /* 
     * if held for longer than 200ms, count is held at 200 (so nothing happens); only when
     * button is released will is_pressed be reset.
    */
    always @(posedge clk_1000Hz) begin
        debounced <= 0;
        if (!is_pressed) begin
            if (btn) begin
                is_pressed <= 1;
                debounced <= 1;
                count <= 0;
            end
        end
        if (is_pressed) begin
            if (count < 200) begin
                count <= count + 1;
            end else if (btn == 0) begin
                is_pressed <= 0;
            end
        end
    end
endmodule
