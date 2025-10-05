`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2025 23:37:17
// Design Name: 
// Module Name: button_controller
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


module button_controller (
    input clk,
    clock_1000Hz,
    btnL,
    btnR,
    input [1:0] set9
);

    // debounce btnL and btnR with 1000Hz clock
    wire btnL_debounced;
    wire btnR_debounced;
    debouncer debounce_btnL (
        clock_1000Hz,
        btnL,
        btnL_debounced
    );
    debouncer debounce_btnR (
        clock_1000Hz,
        btnR,
        btnR_debounced
    );

    // this checks for a discrete press and toggles set appropriately   
    toggle_set toggleSet9_1 (
        clk,
        btnL_debounced,
        set9[1]
    );
    toggle_set toggleSet9_0 (
        clk,
        btnR_debounced,
        set9[0]
    );
endmodule
