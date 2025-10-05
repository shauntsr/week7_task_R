`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.10.2025 00:24:48
// Design Name: 
// Module Name: moveCircle
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


module moveCircle (
    input btnU,
    input btnD,
    input btnL,
    input btnR,
    input clk50hz,
    input clk25mhz,
    output reg [6:0] x_out,
    output reg [5:0] y_out
);

    reg move_L;
    reg move_R;
    reg move_U;
    reg move_D;
    reg reset_move_x;
    reg reset_move_y;
    /*wire [6:0] x_next;
    wire [5:0] y_next;
    
    assign x_next = (move_R & ~isColliding) ? x_out + 1 :
                    (move_L & ~isColliding) ? x_out - 1 :
                    x_out;
    
    assign y_next = (move_D & ~isColliding) ? y_out + 1 :
                    (move_U & ~isColliding) ? y_out - 1 :
                    y_out;
                    
    wire isColliding;
    collision collisionChecker(.clk(clk25mhz), .x_circle(x_next), 
    .y_circle(y_next), .signalOut( isColliding));
       */
    initial begin
        x_out  = 6'd47;
        y_out  = 5'b10000;
        move_L = 1'b0;
        move_R = 1'b0;
        move_U = 1'b0;
        move_D = 1'b0;
    end

    always @(posedge clk25mhz) begin
        move_R <= ((move_R | btnR) & ~(btnL | btnD | btnU));
        move_L <= ((move_L | btnL) & ~(btnR | btnD | btnU));
        move_U <= ((move_U | btnU) & ~(btnD | btnR | btnL));
        move_D <= ((move_D | btnD) & ~(btnU | btnR | btnL));
        reset_move_x <= (btnL | btnR | btnD | btnU);
        reset_move_y <= (btnD | btnU | btnR | btnL);
    end

    always @(posedge clk50hz) begin

        if (move_R) begin
            //   if ( ~ isColliding) begin
            x_out <= ((x_out < 7'd85) ? x_out + 1 : x_out);
            //   end 
        end
        if (move_L) begin
            //  if ( ~ isColliding) begin
            x_out <= ((x_out > 6'd9 & ~(x_out < 42 & y_out > 22)) ? x_out - 1 : x_out);
            // end 
        end
    end

    always @(posedge clk50hz) begin

        if (move_D) begin
            //if ( ~isColliding) begin
            y_out <= ((y_out < 7'd53 & ~(x_out < 41 & y_out > 19)) ? y_out + 1 : y_out);
            //  end 
        end
        if (move_U) begin
            //   if ( ~ isColliding) begin
            y_out <= ((y_out > 6'd9) ? y_out - 1 : y_out);
            //   end
        end
    end

endmodule
