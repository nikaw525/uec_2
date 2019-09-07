`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.07.2019 23:15:13
// Design Name: 
// Module Name: object_fall
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


module object_fall(
    input wire [1:0] floor_hit,
    input wire [1:0] floor_hit_recent,
    input wire [11:0] obj_xpos,
    input wire [11:0] obj_ypos,
    input wire clk,
    input wire rst,
    input wire start,
    input wire ending,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos  
    );
    
       reg [11:0] xpos_nxt, ypos_nxt;
       reg mouse_state;
       localparam 
               HEIGHT = 50,       
               MAX_HEIGHT = 600,
               HOLE = 50,
               
               idle = 0,               
               falling = 1,               
               
               
               timer_count = 1,    
               timer_rst = 0,
               timer_stop = 2,
               
               TIMER_MAX = 100000,
               
               gravity = 1;
           
           reg [20:0] time_ctr = 0;
           reg [20:0] time_ctr_next = 0;
           
           reg [20:0] time_ctr_ms = 0;
           reg [20:0] time_ctr_ms_nxt = 0;
           
           reg [1:0] state = idle;
           reg [1:0] state_nxt;
           reg [1:0] timer_state = timer_rst;
           reg [1:0] timer_state_nxt;
           
           
           reg [11:0] x_pos_nxt;
           reg [11:0] y_pos_nxt;
           
           reg [11:0] x_pos_start;
           reg [11:0] y_pos_start;
           
           reg fall_finish = 0;
           reg fall_finish_nxt;         
              
           
           always @* begin 
                          
                if(fall_finish == 0) begin
                  
                      if(state == idle) begin                                                  
                         state_nxt = falling;
                         x_pos_start = obj_xpos;
                         y_pos_start = obj_ypos;
                      end  
                                           
                      else begin                          
                          state_nxt = state;
                          x_pos_start = x_pos_start; 
                          y_pos_start = obj_ypos; 
                      
                      end
                      
                  end  
               
               else if (fall_finish == 1) begin
                  
                      if(state == falling) begin                          
                         state_nxt = idle;
                         x_pos_start = obj_xpos;
                         y_pos_start = obj_ypos; 
                       
                      end  
                      else begin
                          
                          state_nxt = state;
                          x_pos_start = x_pos_start; 
                          y_pos_start = obj_ypos; 
                      
                      end
                  
               end 
            
               else begin 
                  
                   state_nxt = state;
                   x_pos_start = x_pos_start;
                   y_pos_start = obj_ypos;
               end
         
         end      
           
       
       always @*
           begin            
              
               
               case(timer_state) 
                  
                 timer_count: begin
                       time_ctr_next = (time_ctr == TIMER_MAX) ? 0 : time_ctr +1;            
                       time_ctr_ms_nxt = (time_ctr_next == TIMER_MAX ) ? time_ctr_ms+1 : time_ctr_ms;                       
                   end
                   
                   timer_rst: begin 
                        time_ctr_next = 0;
                        time_ctr_ms_nxt = 0;
                   end
                   
                   timer_stop: begin
                       time_ctr_next = time_ctr;
                       time_ctr_ms_nxt = time_ctr_ms;
                   end 
                   
               endcase
           end 
           
           always @* 
               begin
               
                if(start || ending == 1) begin
                    
                end
                
                case ( state )
                   
                   idle : begin                       
                       
                       
                       timer_state_nxt = timer_rst;
                       fall_finish_nxt = 0;                       
                       
                       y_pos_nxt = obj_ypos;
                       x_pos_nxt = obj_xpos;
                       
                   end
                                      
                   falling: begin
                       
                       
                        timer_state_nxt = timer_count;                
                        
                        if(floor_hit == 1) begin          
                           
                            y_pos_nxt = y_pos_start;
                            fall_finish_nxt = 1;
                        end
                        
                        
                       else if(floor_hit == 0) begin 
                         
                           y_pos_nxt = obj_ypos + time_ctr_ms*4 / 10;
                           x_pos_nxt = x_pos_start;
                           timer_state_nxt = timer_count;
                           fall_finish_nxt = 0;
                          
                       end                     
                           
                   end
                   
                endcase 
           end
         
           always @(posedge clk) begin
               
               xpos <= x_pos_nxt;
               ypos <= y_pos_nxt;      
                              
               state <= state_nxt;
               timer_state <= timer_state_nxt;
               time_ctr <= time_ctr_next;
               
               time_ctr_ms <= time_ctr_ms_nxt;
           
               fall_finish <= fall_finish_nxt;
                 
           end
       
   
endmodule