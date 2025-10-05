`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:41:14
// Design Name: 
// Module Name: toggle_set
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


module toggle_set (
    input set,
    clk,
    input debounced,
    output reg to_toggle = 1
);
    reg debounced_p = 0;
    always @(posedge clk) begin
        if (set) begin
            debounced_p <= debounced;
            if (debounced && ~debounced_p) begin
                to_toggle <= ~to_toggle;
            end
        end else begin
            to_toggle <= 1;
        end
    end
endmodule
