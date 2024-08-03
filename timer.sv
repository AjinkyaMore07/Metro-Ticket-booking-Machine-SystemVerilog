`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2024 11:13:12 AM
// Design Name: 
// Module Name: timer
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


//module clkgen_10sec( input clk_100MHz , in  ,  output timer_out);

//    reg [29:0] counter = 30'h00000000; // 30-bit counter
//    reg clk_reg = 1'b0;

//    always @(posedge clk_100MHz) begin
//        if(in)
//            begin
//                if (counter == 30'd999999999) begin
//                    counter <= 30'h00000000;
//                    clk_reg <= ~clk_reg;
//                end
//                else
//                    counter <= counter + 1;
//            end
//       else
//            begin
//                counter=0;
//                clk_reg=0;
//            end
//    end

//    assign timer_out = clk_reg;

//endmodule

//module milisec(
//    input clk, 
//    input en, 
//    output reg timerout
//);
//    reg [15:0] count;

//    // Initialize count and timerout
//    initial begin
//        count = 'h0000;
//        timerout = 1'b0;
//    end

//    always @(posedge clk) begin
//        if (en) begin
//            if (count == 'hc350) begin
//                count <= 0;
//                timerout <= ~timerout;
//            end else begin
//                count <= count + 1;
//                timerout <= 0;
//            end
//        end else begin
//            count <= 0;
//            timerout <= 0;
//        end
//    end
//endmodule

//module timer_1sec(
//    input clk_100MHz,
//    input en,
//    output reg timeout
//);

//    reg [25:0] counter;

//    // Initialize counter and timeout
//    initial begin
//        counter = 'd50000000;
//        timeout = 1'b0;
//    end

//    always @(posedge clk_100MHz) begin
//        if (en) begin
//            if (counter == 'd50000000) begin
//                counter <= 'd0;
//                timeout <= 1'b1;
//            end else begin
//                counter <= counter + 1;
//                timeout <= 0;
//            end
//        end else begin
//            counter <= 'd0;
//            timeout <= 0;
//        end
//    end
//endmodule


module timer_1sec #(parameter count = 500) (input clk , reset , enable,output done);

localparam temp = $clog2(count);
logic [temp-1:0] q_reg,q;

always_ff @(posedge clk,negedge reset)begin
    if(!reset)
        begin
            q_reg <=0;
        end
    else
        begin
            if(enable)
                q_reg <= q;
            else
                q_reg <= q_reg;
        end
end 

assign done = q_reg == count;
assign q = done ? 'b0:q_reg+1;

endmodule