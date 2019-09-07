`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2019 14:36:11
// Design Name: 
// Module Name: draw_background
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


module draw_background(
    input wire [10:0] hcount_in, 
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire pclk,
    input wire rst,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    
    output reg [11:0] rgb_out
    );
    
    
    reg [11:0] rgb_out_nxt;
    
    reg [10:0] vcount_out_nxt;
    reg vsync_out_nxt;
    reg vblnk_out_nxt;
    reg [10:0] hcount_out_nxt;
    reg hsync_out_nxt;
    reg hblnk_out_nxt;
        
    always @* begin 
        // Just pass these through.
        
        
        vcount_out_nxt <= vcount_in;
        vblnk_out_nxt <= vblnk_in;
        hcount_out_nxt <= hcount_in;
        hblnk_out_nxt <= hblnk_in;
        hsync_out_nxt <= hsync_in;
        vsync_out_nxt <= vsync_in; 
        // During blanking, make it it black.
        if (vblnk_in || hblnk_in) rgb_out_nxt <= 12'h0_0_0; 
        else begin
          // Active display, top edge, make a yellow line.
          if (vcount_in == 0) rgb_out_nxt <= 12'hf_f_0;
          // Active display, bottom edge, make a red line.
          else if (vcount_in == 599) rgb_out_nxt <= 12'hf_0_0;
          // Active display, left edge, make a green line.
          else if (hcount_in == 0) rgb_out_nxt <= 12'h0_f_0;
          // Active display, right edge, make a blue line.
          else if (hcount_in == 799) rgb_out_nxt <= 12'h0_0_f;
          // Active display, interior, fill with gray.
          // You will replace this with your own test.
         /* else if (hcount_in >= 49 && hcount_in < 71 && vcount_in >= 10 && vcount_in < 15) rgb_out_nxt <= 12'h0_f_0;
          
          else if (hcount_in >= 57 && hcount_in < 63 && vcount_in >= 15 && vcount_in < 45) rgb_out_nxt <= 12'h0_f_0;
          
          else if (hcount_in >= 20 && hcount_in < 26 && vcount_in >= 10 && vcount_in < 45) rgb_out_nxt <= 12'h0_f_0;
          
          else if (hcount_in >= 26 && hcount_in < 28 && vcount_in >= 10 && vcount_in < 15) rgb_out_nxt <= 12'h0_f_0;
          
          else if (hcount_in >= 26 && hcount_in < 28 && vcount_in >= 26 && vcount_in < 30) rgb_out_nxt <= 12'h0_f_0;
          
          else if ((((hcount_in - 28)*(hcount_in - 28)+(vcount_in - 20)*(vcount_in - 20)<= 121 ) && 
                    ((hcount_in - 28)*(hcount_in - 28)+(vcount_in - 20)*(vcount_in - 20)>= 36)) && hcount_in >= 20) rgb_out_nxt <= 12'h0_f_0;
         */
          else rgb_out_nxt <= 12'h8_b_e;    
        end
      end
      
      
      always @(posedge pclk) begin
         
        if(rst) begin
          rgb_out <= 0;
                            
          vcount_out <= 0;
          vsync_out <= 0;
          vblnk_out <= 0;
          hcount_out <= 0;
          hsync_out <= 0;
          hblnk_out <= 0;
        
        end 
         
        else begin 
          rgb_out <= rgb_out_nxt;
                  
          vcount_out <= vcount_out_nxt;
          vsync_out <= vsync_out_nxt;
          vblnk_out <= vblnk_out_nxt;
          hcount_out <= hcount_out_nxt;
          hsync_out <= hsync_out_nxt;
          hblnk_out <= hblnk_out_nxt;
        end                                  
      end
endmodule
