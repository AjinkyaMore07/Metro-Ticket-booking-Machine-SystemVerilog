`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2024 06:38:17 PM
// Design Name: 
// Module Name: ram
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

 module ticket(input clk,arstn,transaction , Time_up , input [1:0]dest_sel,ticket_count , input [7:0]Input_money ,output logic Timer_enable, output logic [1:0]ticket_out,count , output logic [7:0]refund,change);
 
 parameter int Fare_B =10;
 parameter int Fare_C =30;
 parameter int Fare_D =50;
 
 reg [7:0] input_money =0;
 
 enum {idle , destn_sel , station_B , station_C , station_D  ,Invalid_dest, Refund_B , Change_B , Ticket_B , Refund_C , Change_C, Ticket_C , Refund_D , Change_D , Ticket_D} c_state,n_state;

 always_ff @(posedge clk , negedge arstn) begin
    if(!arstn)
        c_state <= idle;
    else
        c_state <= n_state;
 end
 
 always_comb begin
    input_money =Input_money;
    case(c_state)
        idle : begin
                    if(transaction)
                        n_state = destn_sel;
                    else
                        n_state = idle;
               end
               
        destn_sel : begin
                        if(dest_sel == 0)
                                n_state = Invalid_dest;
                        else if(dest_sel == 1)
                                n_state = station_B;
                            
                        else if(dest_sel == 2)
                                n_state = station_C;
                       
                        else 
                                n_state = station_D; 
                        
                    end
                    
        station_B : begin
                        if(input_money == (Fare_B * ticket_count))
                            n_state = Ticket_B;
                        else if(input_money > (Fare_B * ticket_count))
                            n_state = Change_B;
                        else
                            n_state = Refund_B;
                    end
                        
                        
        station_C : begin
                        if(input_money == (Fare_C * ticket_count))
                            n_state = Ticket_C;
                        else if(input_money > (Fare_C * ticket_count))
                            n_state = Change_C;
                        else
                            n_state = Refund_C;
                    end
                        
                        
        station_D : begin
                        if(input_money == (Fare_D * ticket_count))
                            n_state = Ticket_D;
                        else if(input_money > (Fare_D * ticket_count))
                            n_state = Change_D;
                        else
                            n_state = Refund_D;
                    end
                    
        Refund_B : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Refund_B  ;
                             
                   end
        Ticket_B  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Ticket_B;
                   end
        Change_B  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Change_B;
                   end 
                   
        Refund_C : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Refund_C;
                             
                   end
        Ticket_C  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Ticket_C;
                   end
        Change_C  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Change_C;
                   end 
        Refund_D : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Refund_D;
                             
                   end
        Ticket_D  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Ticket_D;
                   end
        Change_D  : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state = Change_D;
                   end  
       Invalid_dest : begin
                        if(Time_up)
                            n_state = idle;
                        else
                            n_state =  Invalid_dest;
                      end
    endcase
    
    end
    
 always_comb begin
 
        Timer_enable = 1'b0;
        ticket_out = 2'b00;
        refund = 8'b00;
        change = 8'b00;
        count = 2'b00;
        case(c_state)
                idle :begin
                            Timer_enable = 1'b0;
                            ticket_out = 2'b00;
                            refund = 8'b00;
                            change = 8'b00;
                            count = 2'b00;
                      end
           Refund_B : begin
                        Timer_enable = 1'b1;
                        refund = input_money;
                      
                      end
          Ticket_B :  begin
                        Timer_enable =1;
                        ticket_out = 2'b01;
                      
                        count = ticket_count;
                      end
         Change_B :  begin
                        Timer_enable =1;
                        ticket_out = 2'b01;
                        change = input_money - (Fare_B * ticket_count);
                      
                        count = ticket_count;
                      end
                      
        Refund_C : begin
                        refund = input_money;
                        Timer_enable = 1'b1;
                      end
          Ticket_C :  begin
                        Timer_enable =1;
                        ticket_out = 2'b10;
                       
                        count = ticket_count;
                      end
         Change_C :  begin
                        Timer_enable =1;
                        ticket_out = 2'b10;
                        change = input_money - (Fare_C * ticket_count);
                      
                        count = ticket_count;
                      end
        
        Refund_D : begin
                        Timer_enable = 1'b1;
                        refund = input_money;
                     
                      end
          Ticket_D :  begin
                        Timer_enable =1;
                        ticket_out = 2'b11;
                      
                        count = ticket_count;
                      end
         Change_D :  begin
                        Timer_enable =1;
                        ticket_out = 2'b11;
                        change = input_money - (Fare_D * ticket_count);
                        
                        count = ticket_count;
                      end
       Invalid_dest : begin
                        Timer_enable =1;
                        ticket_out = 2'b00;
                        refund = input_money;
                       
                        change = 2'b00;
                        count = 2'b00;
                      end
       default : begin
                        ticket_out = 2'b00;
                        refund = 2'b00;
                        change = 2'b00;
                        count = 2'b00;
                 end
         
        endcase
        
 end
    
   
 
 endmodule
