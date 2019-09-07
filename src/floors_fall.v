`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2019 18:42:59
// Design Name: 
// Module Name: floors_fall
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



module floors_fall(
   
    input wire space_button,
    input wire [11:0] x_pos,
    input wire [11:0] y_pos,
    input wire [11:0] x_obj,
    input wire [11:0] y_obj,
    input wire [10:0] hcount_in, 
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire pclk,
    input wire [11:0] rgb_in,
    input wire rst,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output reg [11:0] xpos,
    output reg [11:0] ypos,
    output reg [11:0] x_obj_out,
    output reg [11:0] y_obj_out,
    output reg [1:0] floor_hit,
    output reg start,
    output reg ending
       
    );
     
   
    localparam OBJECT_WIDTH = 36;
    localparam MAX_HEIGHT = 600;
    localparam HEIGHT = 20;
    localparam HOLE = 60;
    localparam COLOR = 12'h6_4_2 ;
    localparam OBJECT_COLOR = 12'h8_1_d;
    localparam OBJECT_HEIGHT = 48;
    
    localparam start_screen = 0;
    localparam play = 1;
    localparam game_over = 2;
    
    reg [1:0] screen_state = start_screen; 
    reg [1:0] screen_state_nxt, screen_state_buff;
    reg start_nxt=1, ending_nxt;
    reg [11:0] rgb_out_nxt, rgb_out_buff, pixel_addr_nxt, pixel_addr_buff, adress, rgb_in_buff;    
    reg [10:0] vcount_out_nxt, vcount_out_buff;
    reg vsync_out_nxt, vsync_out_buff;
    reg vblnk_out_nxt, vblnk_out_buff;
    reg [10:0] hcount_out_nxt, hcount_out_buff;
    reg hsync_out_nxt, hsync_out_buff;
    reg hblnk_out_nxt, hblnk_out_buff;
    reg [11:0]x_pos2, y_pos2=600, y_obj_nxt=270, x_obj_nxt= 500;    
    reg [11:0] floor1, floor2, floor3, floor4, floor5, floor6, floor7;
    reg [11:0] floor1_rnd=570, floor2_rnd=300, floor3_rnd=500, floor4_rnd=230, floor5_rnd=450, floor6_rnd=125, floor7_rnd=600;     
    
     always @* begin
         
               vcount_out_buff = vcount_in;
               vsync_out_buff = vsync_in;
               vblnk_out_buff = vblnk_in;
               hcount_out_buff = hcount_in;
               hsync_out_buff = hsync_in;
               hblnk_out_buff = hblnk_in;
               
               if(space_button) begin
                  screen_state_buff = play;
               end                
               
               else if(y_obj == 1) begin
                  screen_state_buff = game_over;
               end
               
               else begin
                  screen_state_buff = screen_state;
               end 
               
             
               
                
   end
   
   
   always @* begin
                
        case(screen_state)
        
            start_screen: begin
            
            //F
            
            if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 250 && hcount_in <= 260)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 150 && vcount_in <= 160 && hcount_in >= 260 && hcount_in <= 315)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 195 && vcount_in <= 205 && hcount_in >= 260 && hcount_in <= 315)
                        rgb_out_buff <= 12'h0_0_0;
                        
            //R
                                         
             else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 330 && hcount_in <= 340)
                          rgb_out_buff <= 12'h0_0_0;
                          
             else if(vcount_in >= 150 && vcount_in <= 160 && hcount_in >= 340 && hcount_in <= 378)
                           rgb_out_buff <= 12'h0_0_0;
                                        
             else if(vcount_in >= 190 && vcount_in <= 200 && hcount_in >= 340 && hcount_in <= 378)
                           rgb_out_buff <= 12'h0_0_0;             
                          
             else if (((hcount_in - 378)**2 + (vcount_in - 175)**2 <= 26**2) && ((hcount_in - 378)**2 + (vcount_in - 175)**2 >= 15**2) && hcount_in >= 378)
                          rgb_out_buff <= 12'h0_0_0;     
                          
             else if (((-2*hcount_in + vcount_in <= -542 && -2*hcount_in + vcount_in >= -565)) && (vcount_in >=200 && vcount_in <=250))  
                          rgb_out_buff <= 12'h0_0_0;                                                                          
                     
                        
           //E        
            else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 420 && hcount_in <= 430)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 150 && vcount_in <= 160 && hcount_in >= 430 && hcount_in <= 485)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 195 && vcount_in <= 205 && hcount_in >= 430 && hcount_in <= 485)
                        rgb_out_buff <= 12'h0_0_0;
                        
            else if(vcount_in >= 240 && vcount_in <= 250 && hcount_in >= 430 && hcount_in <= 485)
                        rgb_out_buff <= 12'h0_0_0;      
                   
           //E        
            else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 495 && hcount_in <= 505)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 150 && vcount_in <= 160 && hcount_in >= 505 && hcount_in <= 560)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 195 && vcount_in <= 205 && hcount_in >= 505 && hcount_in <= 560)
                        rgb_out_buff <= 12'h0_0_0;
                        
            else if(vcount_in >= 240 && vcount_in <= 250 && hcount_in >= 505 && hcount_in <= 560)
                        rgb_out_buff <= 12'h0_0_0;      
                   
                   
                   
                        
            //F
            
            if(vcount_in >= 300 && vcount_in <= 400 && hcount_in >= 250 && hcount_in <= 260)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 300 && vcount_in <= 310 && hcount_in >= 260 && hcount_in <= 315)
                        rgb_out_buff <= 12'h0_0_0;
                                    
            else if(vcount_in >= 345 && vcount_in <= 355 && hcount_in >= 260 && hcount_in <= 315)
                        rgb_out_buff <= 12'h0_0_0;
                        
                        
           //A         
             else if ((hcount_in >= 314 && hcount_in <= 365 && (2*hcount_in + vcount_in >= 1028 && 2*hcount_in + vcount_in <= 1048)) && (vcount_in >=300 && vcount_in <=400))  
                         rgb_out_buff <= 12'h0_0_0;
                        
             else if ((hcount_in >= 365 && hcount_in <= 418 && (-2*hcount_in + vcount_in <= -412 && -2*hcount_in + vcount_in >= -432)) && (vcount_in >=300 && vcount_in <=400))  
                         rgb_out_buff <= 12'h0_0_0;
                         
             else if (vcount_in <= 360 && vcount_in >= 350 && hcount_in >= 345 && hcount_in <= 385)
                         rgb_out_buff <= 12'h0_0_0;
                   
             
           //L        
             else if(vcount_in >= 300 && vcount_in <= 400 && hcount_in >= 425 && hcount_in <= 435)
                         rgb_out_buff <= 12'h0_0_0;
                               
             else if(vcount_in >= 390 && vcount_in <= 400 && hcount_in >= 435 && hcount_in <= 490)
                         rgb_out_buff <= 12'h0_0_0;                                               
           
          //L        
              else if(vcount_in >= 300 && vcount_in <= 400 && hcount_in >= 500 && hcount_in <= 510)
                          rgb_out_buff <= 12'h0_0_0;
                                                                                           
              else if(vcount_in >= 390 && vcount_in <= 400 && hcount_in >= 510 && hcount_in <= 565)
                          rgb_out_buff <= 12'h0_0_0; 
                   
                rgb_out_buff = rgb_in;               
                start_nxt=1;
                ending_nxt=0;
            end
            
            
            play: begin
           //floors       
                   floor1 = y_pos - 450;
                   floor2 = y_pos - 300;
                   floor3 = y_pos - 150;
                   floor4 = y_pos;
                   floor5 = y_pos + 150;
                   floor6 = y_pos + 300;
                   floor7 = y_pos + 450;
                    
                 if(((vcount_in <= (floor4 + HEIGHT) && (vcount_in >= floor4))) && (((hcount_in > 0) && (hcount_in < floor4_rnd)) || (hcount_in > floor4_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor1 + HEIGHT) && (vcount_in >= floor1)) && (((hcount_in > 0) && (hcount_in < floor1_rnd)) || (hcount_in > floor1_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor2 + HEIGHT) && (vcount_in >= floor2)) && (((hcount_in > 0) && (hcount_in < floor2_rnd)) || (hcount_in > floor2_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor3 + HEIGHT) && (vcount_in >= floor3)) && (((hcount_in > 0) && (hcount_in < floor3_rnd)) || (hcount_in > floor3_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor5 + HEIGHT) && (vcount_in >= floor5)) && (((hcount_in > 0) && (hcount_in < floor5_rnd)) || (hcount_in > floor5_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor6 + HEIGHT) && (vcount_in >= floor6)) && (((hcount_in > 0) && (hcount_in < floor6_rnd)) || (hcount_in > floor6_rnd + HOLE) && (hcount_in < 799)) ||
                    (vcount_in <= (floor7 + HEIGHT) && (vcount_in >= floor7)) && (((hcount_in > 0) && (hcount_in < floor7_rnd)) || (hcount_in > floor7_rnd + HOLE) && (hcount_in < 799))) 
                    
                        rgb_out_buff = COLOR;
                    else 
                        rgb_out_buff = rgb_in;                  
                   
                  
                 //pixel man
                   if(hcount_in > 0 && hcount_in < 799 && vcount_in > 0 && vcount_in <599 ) begin
                   //red
                   if((vcount_in > y_obj) && (vcount_in <= (y_obj + 3)) && (hcount_in >= x_obj+9) && (hcount_in < x_obj + 27) ||
                   (vcount_in > y_obj+3) && (vcount_in <= (y_obj + 6)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 36) ||
                   (vcount_in > y_obj+21) && (vcount_in <= (y_obj + 24)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 12) ||
                   (vcount_in > y_obj+21) && (vcount_in <= (y_obj + 24)) && (hcount_in >= x_obj+15) && (hcount_in < x_obj + 21) ||
                   (vcount_in > y_obj+21) && (vcount_in <= (y_obj + 24)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 30) ||
                   (vcount_in > y_obj+24) && (vcount_in <= (y_obj + 27)) && (hcount_in >= x_obj+3) && (hcount_in < x_obj + 12) ||
                   (vcount_in > y_obj+24) && (vcount_in <= (y_obj + 27)) && (hcount_in >= x_obj+15) && (hcount_in < x_obj + 21) ||
                   (vcount_in > y_obj+24) && (vcount_in <= (y_obj + 27)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 33) ||
                   (vcount_in > y_obj+27) && (vcount_in <= (y_obj + 30)) && (hcount_in >= x_obj) && (hcount_in < x_obj + 12) ||
                   (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 9) ||
                   (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+27) && (hcount_in < x_obj + 30) ||
                   (vcount_in > y_obj+27) && (vcount_in <= (y_obj + 30)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 36)) begin
                     rgb_out_buff = 12'hc_1_2;
                  end
                   
                   
                  //blue
                  
                  if((vcount_in > y_obj+21) && (vcount_in <= (y_obj + 30)) && (hcount_in >= x_obj+12) && (hcount_in < x_obj + 15) ||
                  (vcount_in > y_obj+21) && (vcount_in <= (y_obj + 30)) && (hcount_in >= x_obj+21) && (hcount_in < x_obj + 24) ||
                  (vcount_in > y_obj+27) && (vcount_in <= (y_obj + 39)) && (hcount_in >= x_obj+15) && (hcount_in < x_obj + 21) ||
                  (vcount_in > y_obj+36) && (vcount_in <= (y_obj + 42)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 15) ||
                  (vcount_in > y_obj+36) && (vcount_in <= (y_obj + 42)) && (hcount_in >= x_obj+21) && (hcount_in < x_obj + 30) ||
                  (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+9) && (hcount_in < x_obj + 12) ||
                  (vcount_in > y_obj+33) && (vcount_in <= (y_obj + 36)) && (hcount_in >= x_obj+9) && (hcount_in < x_obj + 15) ||
                  (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 27) ||
                  (vcount_in > y_obj+33) && (vcount_in <= (y_obj + 36)) && (hcount_in >= x_obj+21) && (hcount_in < x_obj + 27) 
                  ) begin
                    rgb_out_buff = 12'h0_1_d;
                  end
                                     
                                    
                   //black
                   if((vcount_in > y_obj +6) && (vcount_in <= (y_obj + 12)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 27)||
                   (vcount_in > y_obj +12) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+27) && (hcount_in < x_obj + 30)||
                   (vcount_in > y_obj +15) && (vcount_in <= (y_obj + 18)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 36)
                   ) begin
                     rgb_out_buff = 12'h0_0_0;
                   end
                  
                   
                   //yellow
                   if((vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+12) && (hcount_in < x_obj + 15)||
                   (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 33)) && (hcount_in >= x_obj+21) && (hcount_in < x_obj + 24)) begin
                    rgb_out_buff = 12'hf_e_0;
                   end
                                      
                   //brown
                   if((vcount_in > y_obj+6) && (vcount_in <= (y_obj + 9)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 15)||
                   (vcount_in > y_obj+9) && (vcount_in <= (y_obj + 18)) && (hcount_in >= x_obj+3) && (hcount_in < x_obj + 6)||
                   (vcount_in > y_obj+15) && (vcount_in <= (y_obj + 18)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 9)||
                   (vcount_in > y_obj+9) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+9) && (hcount_in < x_obj + 12)||
                   (vcount_in > y_obj+12) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+12) && (hcount_in < x_obj + 15)||
                   (vcount_in > y_obj+42) && (vcount_in <= (y_obj + 48)) && (hcount_in >= x_obj+3) && (hcount_in < x_obj + 12)||
                   (vcount_in > y_obj+45) && (vcount_in <= (y_obj + 48)) && (hcount_in >= x_obj) && (hcount_in < x_obj + 3)||
                   (vcount_in > y_obj+42) && (vcount_in <= (y_obj + 48)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 33)||
                   (vcount_in > y_obj+45) && (vcount_in <= (y_obj + 48)) && (hcount_in >= x_obj+33) && (hcount_in < x_obj + 36)
                   ) begin
                     rgb_out_buff = 12'h7_3_0;
                   end
                                      
                                      
                   //nude                   
                   if((vcount_in > y_obj+8) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 9)||
                   (vcount_in > y_obj+6) && (vcount_in <= (y_obj + 21)) && (hcount_in >= x_obj+15) && (hcount_in < x_obj + 24)||
                   (vcount_in > y_obj+15) && (vcount_in <= (y_obj + 21)) && (hcount_in >= x_obj+9) && (hcount_in < x_obj + 15)||
                   (vcount_in > y_obj+9) && (vcount_in <= (y_obj + 12)) && (hcount_in >= x_obj+12) && (hcount_in < x_obj + 15)||
                   (vcount_in > y_obj+12) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 27)||
                   (vcount_in > y_obj+18) && (vcount_in <= (y_obj + 21)) && (hcount_in >= x_obj+24) && (hcount_in < x_obj + 33)||
                   (vcount_in > y_obj+6) && (vcount_in <= (y_obj + 12)) && (hcount_in >= x_obj+27) && (hcount_in < x_obj + 30)||
                   (vcount_in > y_obj+9) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+30) && (hcount_in < x_obj + 36)||
                   (vcount_in > y_obj+12) && (vcount_in <= (y_obj + 15)) && (hcount_in >= x_obj+36) && (hcount_in < x_obj + 39)||
                   (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 39)) && (hcount_in >= x_obj) && (hcount_in < x_obj + 6)||
                   (vcount_in > y_obj+33) && (vcount_in <= (y_obj + 36)) && (hcount_in >= x_obj+6) && (hcount_in < x_obj + 9)||
                   (vcount_in > y_obj+33) && (vcount_in <= (y_obj + 36)) && (hcount_in >= x_obj+27) && (hcount_in < x_obj + 30)||
                   (vcount_in > y_obj+30) && (vcount_in <= (y_obj + 39)) && (hcount_in >= x_obj+30) && (hcount_in < x_obj + 36)
                   ) begin
                      rgb_out_buff = 12'hf_e_c;
                   end
                  end
               
 
                   
                   
                   start_nxt=0;
                   ending_nxt=0;                  
            
            end
            
            
            game_over: begin
                
                        
                // G                   
                 if (((hcount_in - 250)**2 + (vcount_in - 200)**2 <= 50**2) && ((hcount_in - 250)**2 + (vcount_in - 200)**2 >= 40**2 && hcount_in < 250)                       
                     || ((hcount_in - 250)**2 + (vcount_in - 200)**2 <= 50**2) && ((hcount_in - 250)**2 + (vcount_in - 200)**2 >= 40**2 && (vcount_in < 175 || vcount_in > 225) && hcount_in >= 250))
                        rgb_out_buff <= 12'h0_0_0;
                        
                else if(vcount_in <= 225 && vcount_in >= 200 && hcount_in >= 282 && hcount_in <= 293)
                        rgb_out_buff <= 12'h0_0_0;
                        
                else if(vcount_in <= 210 && vcount_in >= 200 && hcount_in >= 263 && hcount_in <= 283)
                        rgb_out_buff <= 12'h0_0_0;
                        
               //A         
                else if ((hcount_in >= 300 && hcount_in <= 350 && (2*hcount_in + vcount_in >= 850 && 2*hcount_in + vcount_in <= 870)) && (vcount_in >=150 && vcount_in <=250))  
                            rgb_out_buff <= 12'h0_0_0;
                           
                else if ((hcount_in >= 350 && hcount_in <= 400 && (-2*hcount_in + vcount_in <= -530 && -2*hcount_in + vcount_in >= -550)) && (vcount_in >=150 && vcount_in <=250))  
                            rgb_out_buff <= 12'h0_0_0;
                            
                else if (vcount_in <= 210 && vcount_in >= 200 && hcount_in >= 325 && hcount_in <= 375)
                            rgb_out_buff <= 12'h0_0_0;
                
                //M            
                                                  
                 else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 500 && hcount_in <= 510)
                             rgb_out_buff <= 12'h0_0_0;
                             
                 else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 410 && hcount_in <= 420)
                             rgb_out_buff <= 12'h0_0_0; 
                  
                 else if ((hcount_in >= 460 && hcount_in <= 500 && ((3/2)*hcount_in + vcount_in >= 650 && (3/2)*hcount_in + vcount_in <= 665) && (vcount_in >=150 && vcount_in <=250)))  
                             rgb_out_buff <= 12'h0_0_0;  
                             
                 else if ((hcount_in >= 420 && hcount_in <= 460 && (-(3/2)*hcount_in + vcount_in <= -255 && -(3/2)*hcount_in + vcount_in >= -270) && (vcount_in >=150 && vcount_in <=250)))  
                             rgb_out_buff <= 12'h0_0_0;  
                                                     
                //E
                
                else if(vcount_in >= 150 && vcount_in <= 250 && hcount_in >= 520 && hcount_in <= 530)
                            rgb_out_buff <= 12'h0_0_0;
                                        
                else if(vcount_in >= 150 && vcount_in <= 160 && hcount_in >= 530 && hcount_in <= 585)
                            rgb_out_buff <= 12'h0_0_0;
                                        
                else if(vcount_in >= 195 && vcount_in <= 205 && hcount_in >= 530 && hcount_in <= 585)
                            rgb_out_buff <= 12'h0_0_0;
                            
                else if(vcount_in >= 240 && vcount_in <= 250 && hcount_in >= 530 && hcount_in <= 585)
                            rgb_out_buff <= 12'h0_0_0;     
                            
                //O
                else if (((hcount_in - 265)**2 + (vcount_in - 350)**2 <= 50**2) && ((hcount_in - 265)**2 + (vcount_in - 350)**2 >= 40**2))
                            rgb_out_buff <= 12'h0_0_0;
                            
                //V
                
                else if ((hcount_in >= 365 && hcount_in <= 415 && (2*hcount_in + vcount_in >= 1110 && 2*hcount_in + vcount_in <= 1130)) && (vcount_in >=300 && vcount_in <=400))  
                            rgb_out_buff <= 12'h0_0_0;
                                       
                else if ((hcount_in >= 315 && hcount_in <= 365 && (-2*hcount_in + vcount_in <= -330 && -2*hcount_in + vcount_in >= -350)) && (vcount_in >=300 && vcount_in <=400))  
                            rgb_out_buff <= 12'h0_0_0;            
                
                //E
                
                 else if(vcount_in >= 300 && vcount_in <= 400 && hcount_in >= 425 && hcount_in <= 435)
                              rgb_out_buff <= 12'h0_0_0;
                                          
                  else if(vcount_in >= 300 && vcount_in <= 310 && hcount_in >= 435 && hcount_in <= 490)
                              rgb_out_buff <= 12'h0_0_0;
                                          
                  else if(vcount_in >= 345 && vcount_in <= 355 && hcount_in >= 435 && hcount_in <= 490)
                              rgb_out_buff <= 12'h0_0_0;
                              
                  else if(vcount_in >= 390 && vcount_in <= 400 && hcount_in >= 435 && hcount_in <= 490)
                              rgb_out_buff <= 12'h0_0_0;
                    
                 //R
                 
                 else if(vcount_in >= 300 && vcount_in <= 400 && hcount_in >= 500 && hcount_in <= 510)
                              rgb_out_buff <= 12'h0_0_0;
                              
                 else if(vcount_in >= 300 && vcount_in <= 310 && hcount_in >= 510 && hcount_in <= 542)
                               rgb_out_buff <= 12'h0_0_0;
                                            
                 else if(vcount_in >= 340 && vcount_in <= 350 && hcount_in >= 510 && hcount_in <= 542)
                               rgb_out_buff <= 12'h0_0_0;             
                              
                 else if (((hcount_in - 547)**2 + (vcount_in - 325)**2 <= 26**2) && ((hcount_in - 547)**2 + (vcount_in - 325)**2 >= 15**2) && hcount_in >= 542)
                              rgb_out_buff <= 12'h0_0_0;     
                              
                 else if (((-2*hcount_in + vcount_in <= -735 && -2*hcount_in + vcount_in >= -757)) && (vcount_in >=350 && vcount_in <=400))  
                              rgb_out_buff <= 12'h0_0_0;           
                                 
                    rgb_out_buff = rgb_in;                    
                    
                    start_nxt=0;
                    ending_nxt=1;
            end
            
       endcase 
    
   end 
   
     
     always @(posedge pclk) begin
        if (rst) begin
            vcount_out <= 0;
            vsync_out <= 0;
            vblnk_out <= 0;
            hcount_out <= 0;
            hsync_out <= 0;
            hblnk_out <= 0;                           
            rgb_out <= 0;
            //accel <= 0;
            
            screen_state <= 0;
        end
     
         else begin
             
            vcount_out_nxt <= vcount_out_buff;
            vsync_out_nxt <= vsync_out_buff; 
            vblnk_out_nxt <= vblnk_out_buff;
            hcount_out_nxt <= hcount_out_buff;
            hsync_out_nxt <= hsync_out_buff;  
            hblnk_out_nxt <= hblnk_out_buff;
            rgb_out_nxt <= rgb_out_buff;
                  
            vcount_out <= vcount_out_nxt; 
            vsync_out <= vsync_out_nxt;
            vblnk_out <= vblnk_out_nxt;
            hcount_out <= hcount_out_nxt;
            hsync_out <= hsync_out_nxt;
            hblnk_out <= hblnk_out_nxt;      
            rgb_out <= rgb_out_nxt;            
           
            y_obj_out <= y_obj_nxt;
            
           
            
            start <= start_nxt;
            ending <= ending_nxt;
                        
            screen_state_nxt <= screen_state_buff;
            screen_state <= screen_state_nxt;
            
            if(((y_obj + OBJECT_HEIGHT) >= floor3 && (y_obj + OBJECT_HEIGHT) <= floor3 + 20) && ((x_obj >= 0 && x_obj < floor3_rnd) || (x_obj >= floor3_rnd + HOLE - OBJECT_WIDTH)))  begin
                 y_obj_nxt = floor3 - OBJECT_HEIGHT - 1; 
                 floor_hit = 1;
                                                             
                end 
                
            else if(((y_obj + OBJECT_HEIGHT) >= floor4 && (y_obj + OBJECT_HEIGHT) <= floor4 + 20) && ((x_obj >= 0 && x_obj < floor4_rnd) || (x_obj >= floor4_rnd + HOLE - OBJECT_WIDTH)))  begin
                    y_obj_nxt = floor4 - OBJECT_HEIGHT - 1;
                    floor_hit = 1;
                    
                 end
             else if(((y_obj + OBJECT_HEIGHT) >= floor5 && (y_obj + OBJECT_HEIGHT) <= floor5 + 20) && ((x_obj >= 0 && x_obj < floor5_rnd) || (x_obj >= floor5_rnd + HOLE - OBJECT_WIDTH)))  begin
                   y_obj_nxt = floor5 - OBJECT_HEIGHT - 1; 
                   floor_hit = 1;
                  
                end                       
             else if(((y_obj + OBJECT_HEIGHT) >= floor6 && (y_obj + OBJECT_HEIGHT) <= floor6 + 20) && ((x_obj >= 0 && x_obj < floor6_rnd) || (x_obj >= floor6_rnd + HOLE - OBJECT_WIDTH)))  begin
                  y_obj_nxt = floor6 - OBJECT_HEIGHT - 1;
                  floor_hit = 1;
                  
                end
                              
               else if(((y_obj + OBJECT_HEIGHT) >= floor7 && (y_obj + OBJECT_HEIGHT) <= floor7 + 20) && ((x_obj >= 0 && x_obj < floor7_rnd) || (x_obj >= floor7_rnd + HOLE - OBJECT_WIDTH)))  begin
                  y_obj_nxt = floor7 - OBJECT_HEIGHT - 1;
                  floor_hit = 1;
                 
                end
                            
             else if(((y_obj + OBJECT_HEIGHT) >= floor1 && (y_obj + OBJECT_HEIGHT) <= floor1 + 20) && ((x_obj >= 0 && x_obj < floor1_rnd) || (x_obj >= floor1_rnd + HOLE - OBJECT_WIDTH)))  begin
                  y_obj_nxt = floor1 - OBJECT_HEIGHT - 1;     
                  floor_hit = 1;
                  
                 end   
                                                                                                                                        
             else if(((y_obj + OBJECT_HEIGHT) >= floor2 && (y_obj + OBJECT_HEIGHT) <= floor2 + 20) && ((x_obj >= 0 && x_obj < floor2_rnd) || ( x_obj >= floor2_rnd + HOLE - OBJECT_WIDTH)))  begin
                 y_obj_nxt = floor2 - OBJECT_HEIGHT - 1;       
                 floor_hit = 1;
                 
               end
               
               else if(y_obj == MAX_HEIGHT - OBJECT_HEIGHT) begin
                 y_obj_nxt = MAX_HEIGHT - OBJECT_HEIGHT; 
                 floor_hit = 1;
                
               end
               else if(x_obj < 0) begin  //zmiana
                x_obj_nxt = 0;
               end
               
               else if(x_obj_nxt > 799) begin //zmiana
                    x_obj_nxt = 799;
               end
               
               else if(y_obj == 1) begin
                y_obj_nxt = 300; 
                floor_hit = 1;
                 
              end    
                                                                               
             else begin
                 floor_hit = 0;
                 
              end
            
           if(y_pos <= 1) begin
                xpos <= x_pos;
                ypos <= floor1;
                
                floor1_rnd <= floor5_rnd;
                floor2_rnd <= floor6_rnd;
                floor3_rnd <= floor7_rnd;
                
                if(floor5_rnd < 700)
                     floor5_rnd = floor5_rnd + 50;
                else 
                     floor5_rnd = floor5_rnd - 650;
                     
                if(floor6_rnd < 625)
                     floor6_rnd = floor6_rnd + 250;
                else 
                     floor6_rnd = floor6_rnd - 500;                    
                 
                if(floor7_rnd > 100)
                     floor7_rnd = floor7_rnd - 100;
                else 
                     floor7_rnd = floor7_rnd + 550;
                     
                if(floor4_rnd > 70)
                     floor4_rnd = floor4_rnd - 80;
                else 
                     floor4_rnd = floor4_rnd + 640;     
                
            end
             
           else begin
                ypos <= y_pos2;
                
          end   
            
         end   

     end
endmodule

