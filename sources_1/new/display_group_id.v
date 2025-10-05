`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 14:34:58
// Design Name: 
// Module Name: display_group_id
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


module display_group_id (
    input clk,
    output reg [7:0] seg,
    output reg [3:0] an
);
    wire clk_500hz;
    reg [1:0] pos = 2'd0;
    clock_divider u_500hz (
        .clk(clk),
        .m(99_999),
        .slow_clock(clk_500hz)
    );

    always @(posedge clk_500hz) begin
        pos <= (pos == 3) ? 0 : pos + 1;
        case (pos)
            2'd0: begin
                an  <= 4'b0111;
                seg <= 8'b1001_0010;  // A, C, D, F, G on
            end
            2'd1: begin
                an  <= 4'b1011;
                seg <= 8'b0011_0000;  // A, B, C, D, G, dp on
            end
            2'd2: begin
                an  <= 4'b1101;
                seg <= 8'b1111_1001;  // B, C on 
            end
            2'd3: begin
                an  <= 4'b1110;
                seg <= 8'b1000_0010;  // A, C, D, E, F, G on
            end
            default: begin
            end
        endcase
    end

endmodule
