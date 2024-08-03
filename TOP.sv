`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2024 12:03:00 PM
// Design Name: 
// Module Name: TOP
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

//`include "timer_1sec.sv"
module Top(
    input clk, 
    input arstn, 
    input transaction, 
    input [1:0] destination, 
    input [1:0] ticket_count,
    input [7:0] money, 
    output [1:0] ticket_out, count,
    output [7:0] refund,
    output [7:0] change,
    output done
);
wire w_time_up;
wire w_timerenable;
    ticket dut (
        .clk(clk),
        .arstn(arstn),
        .transaction(transaction),
        .Time_up(w_time_up),
        .ticket_count(ticket_count),
        .dest_sel(destination),
        .Input_money(money),
        .Timer_enable(w_timerenable), // Add the connection for Timer_enable if needed
        .ticket_out(ticket_out),
        .refund(refund),
        .change(change),
        .count(count));
   
    timer_1sec timer(
    .clk(clk),
    .enable(w_timerenable),
    .done(w_time_up),
    .reset(arstn)
);
assign done = w_time_up ? 1 :0 ;
endmodule
