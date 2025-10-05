`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 01:35:30
// Design Name: 
// Module Name: oscillate
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


// Oscillates a number between lower and upper bounds
// Rate is affected by the input clock
// Output is the number value
module oscillate (
    input set,
    input [6:0] lower_bound,
    upper_bound,
    input clk,
    output wire [6:0] coord
);

    reg dir = 0;  // 0 means forward, 1 means reverse
    reg [6:0] curr = 0;
    assign coord = curr;
    always @(posedge clk) begin
        if (set) begin
            case (dir)
                1'b0: // forwards
                begin
                    if (curr >= upper_bound) dir <= ~dir;
                    else curr <= curr + 1;
                end
                1'b1: // forwards
                begin
                    if (curr <= lower_bound) dir <= ~dir;
                    else curr <= curr - 1;
                end
                default: curr <= curr;
            endcase
        end
    end

endmodule
