`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 00:45:36
// Design Name: 
// Module Name: draw_digit
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

module draw_digit #(
    // use reasonable values; maybe do some pre calculation
    // Must ensure HEIGHT >= 3*THICKNESS  (else V below will be negative/zero)
    parameter integer WIDTH     = 28,
    parameter integer HEIGHT    = 48,
    parameter integer THICKNESS = 8
) (
    input  wire        set,            // enable drawing
    input  wire [3:0]  value,          // number to draw
    input  wire [6:0]  px, py,         // absolute pixel indexes
    input  wire [6:0]  base_x, base_y, // top left (x,y) where u want to draw
    input  wire [15:0] colour,         // colour to draw digit as
    output wire [15:0] oled_data
);

    localparam [15:0] BLACK = 16'h0000;
    
    // Derived vertical gap (space between horizontal bars)
    localparam integer V = (HEIGHT - 3*THICKNESS) / 2;
    
    // avoid underflow, also shortcuts
    wire inside_x = (px >= base_x) && (px < base_x + WIDTH);
    wire inside_y = (py >= base_y) && (py < base_y + HEIGHT);
    wire inside = set && inside_x && inside_y;
    
    // relative indexes
    wire [6:0] rx = inside_x ? (px - base_x) : 7'd0;
    wire [6:0] ry = inside_y ? (py - base_y) : 7'd0;
    
    // scope out 7 rectangular segments (a to g). Assume rx, ry is inside drawing region (WIDTHxHEIGHT)
    wire seg_a = (ry < THICKNESS); // top horizontal
    
    wire seg_f = ( (ry >= 0) && (ry < 2*THICKNESS + V) && (rx < THICKNESS) ); // upper-left vertical
    wire seg_b = ( (ry >= 0) && (ry < 2*THICKNESS + V) && (rx >= (WIDTH - THICKNESS)) ); // upper-right
    
    wire seg_g = ( (ry >= (THICKNESS + V)) && (ry < (2*THICKNESS + V)) ); // middle horizontal
    
    wire seg_e = ( (ry >= (THICKNESS + V)) && (ry < HEIGHT) && (rx < THICKNESS) ); // lower-left
    wire seg_c = ( (ry >= (THICKNESS + V)) && (ry < HEIGHT) && (rx >= (WIDTH - THICKNESS)) ); // lower-right
    
    wire seg_d = (ry >= (HEIGHT - THICKNESS)) && (ry < HEIGHT); // bottom horizontal

    // decode value to segment mask
    // seg_mask = {a,b,c,d,e,f,g}
    reg [6:0] seg_mask_dec;
    always @ (*) begin
        case (value)
            4'd0: seg_mask_dec = 7'b1111110; // only g off
            4'd1: seg_mask_dec = 7'b0110000; // b c
            4'd2: seg_mask_dec = 7'b1101101; // a b g e d
            4'd3: seg_mask_dec = 7'b1111001; // a b c d g
            4'd4: seg_mask_dec = 7'b0110011; // f g b c
            4'd5: seg_mask_dec = 7'b1011011; // a f g c d
            4'd6: seg_mask_dec = 7'b1011111; // a f e d c g
            4'd7: seg_mask_dec = 7'b1110000; // a b c
            4'd8: seg_mask_dec = 7'b1111111;
            4'd9: seg_mask_dec = 7'b1111011; // a b c d f g
            default: seg_mask_dec = 7'b0000000;
        endcase
    end
    
    // assign shorthand btw
    wire [6:0] seg_mask = seg_mask_dec;

    wire any_on =
        (seg_mask[6] && seg_a) ||
        (seg_mask[5] && seg_b) ||
        (seg_mask[4] && seg_c) ||
        (seg_mask[3] && seg_d) ||
        (seg_mask[2] && seg_e) ||
        (seg_mask[1] && seg_f) ||
        (seg_mask[0] && seg_g);
    
    assign oled_data = (inside && any_on) ? colour : BLACK;

endmodule