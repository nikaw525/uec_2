`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2019 13:43:20
// Design Name: 
// Module Name: draw_rect_ctl
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


module draw_rect_ctl(
    input wire space_button,
    input wire [11:0] obj_xpos,
    input wire [11:0] obj_ypos,
    input wire clk,
    input wire rst,
    input wire [11:0] score,
    
    output reg [11:0] xpos,
    output reg [11:0] ypos    
    
       );
       
  reg [11:0] xpos_nxt, ypos_nxt;
        reg mouse_state;
        localparam HEIGHT = 20,
      
                MAX_HEIGHT = 1,
                
                idle = 0,
                falling = 1,
                
                
                timer_count = 1,    
                timer_rst = 0,
                timer_stop = 2,
                
                TIMER_MAX = 100000;
            
            reg [20:0] time_ctr = 0;
            reg [20:0] time_ctr_next = 0;
            
            reg [20:0]time_ctr_ms = 0;
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
            
            reg [26:0] counter;
           
            
            always @* begin 
           
                
                if(space_button == 1) begin
                    
                    if(state == idle) begin 
                       state_nxt = falling;
                       x_pos_start = obj_xpos;
                       y_pos_start = obj_ypos;
                    end 
                end              
            
                else begin 
                    state_nxt = state;
                    x_pos_start = obj_xpos;
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
                 
                 case ( state )
                    
                    idle : begin
                        timer_state_nxt = timer_rst;
                        fall_finish_nxt = 0;
                        
                        y_pos_nxt = obj_ypos;
                        x_pos_nxt = obj_xpos;
                    end
                    
                    falling: begin
                        
                       
                                        
                        timer_state_nxt = timer_count;
                                        
                        if(ypos == MAX_HEIGHT) begin
                            x_pos_nxt = x_pos_start;
                            y_pos_nxt = y_pos_start;
                            timer_state_nxt = timer_rst;
                                                       
                        end
                                                                       
                        else begin 
                            
                           y_pos_nxt = y_pos_start - time_ctr_ms*1/10; //spowolnienie
                          
                            
                            x_pos_nxt = x_pos_start;
                            timer_state_nxt = timer_count;
                            
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
