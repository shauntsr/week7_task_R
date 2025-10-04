`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.09.2025 14:59:50
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input clk,
    input [31:0] m,
    output reg slow_clock = 0
    );
    
    reg [31:0] count = 0; // Size is as required
    
    always @(posedge clk) begin
        count <= (count == m) ? 0 : count + 1;
        slow_clock <= (count == 0) ? ~slow_clock : slow_clock;
    end
    
endmodule
