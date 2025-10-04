`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (input clk, btnC, btnU, btnD, btnR, btnL, output [7:0] JB);


wire clk_6p25MHz, clk_25MHz, clk_10MHz;
clock_divider u_6p25Mhz(clk, 7, clk_6p25MHz);
clock_divider u_25Mhz(clk, 3, clk_25MHz);
clock_divider u_10Mhz(clk, 49999999, clk_10MHz);

wire [12:0] pixel_index;
wire frame_begin, sending_pixels, sample_pixel;
reg [15:0] pixel_data = 16'h0000;

wire [6:0] x;
wire [6:0] y;

assign x = pixel_index % 96;
assign y = pixel_index / 96;

reg [6:0] cornerX = 7'd10;
reg [6:0] cornerY = 6'd20; 
localparam WIDTH = 20;
localparam HEIGHT = 20;

always @ (posedge clk_10MHz) begin 
begin
    cornerX <= cornerX + 1;
    cornerY <= cornerY + 1;
end 
end

always @ (posedge clk_25MHz) begin
    if (x >= cornerX && x <= cornerX + WIDTH && y >= cornerY && y <= cornerY + HEIGHT) pixel_data <= 16'h07E0;
    else pixel_data <= 16'hf800;
    
end

Oled_Display oled_display(
    .clk(clk_6p25MHz), 
    .reset(btnC), 
    .frame_begin(frame_begin), 
    .sending_pixels(sending_pixels),
    .sample_pixel(sample_pixel), 
    .pixel_index(pixel_index), 
    .pixel_data(pixel_data), 
    .cs(JB[0]), 
    .sdin(JB[1]), 
    .sclk(JB[3]), 
    .d_cn(JB[4]), 
    .resn(JB[5]), 
    .vccen(JB[6]),
    .pmoden(JB[7]));

endmodule