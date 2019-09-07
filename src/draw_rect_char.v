`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2019 00:17:08
// Design Name: 
// Module Name: draw_rect_char
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


module draw_rect_char(
    input wire [10:0] hcount_in, 
    input wire hsync_in,
    input wire hblnk_in,
    input wire [10:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire pclk,
    input wire [11:0] rgb_in,
    input wire rst,
    input wire [7:0] char_pixels,
    input wire [7:0] char_pixels_2,
    input wire [7:0] ascii,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output [7:0] char_xy,
    output [3:0] char_line,
    output [7:0] char_xy_2,
    output [3:0] char_line_2
    );
    
    reg hsync_buff, hblnk_buff, vsync_buff, vblnk_buff, hsync_buff2, hblnk_buff2, vsync_buff2, vblnk_buff2;
    reg [10:0] hcount_buff, vcount_buff, char_addr, hcount, vcount, hcount_buff2, vcount_buff2;
    reg [11:0] rgb_out_nxt, rgb_buff, rgb_buff2;
    wire [10:0] hcount_in_rect, vcount_in_rect, hcount_in_rect_2, vcount_in_rect_2;
    
    localparam LETTERS = 12'h4_4_4, BG = 12'h7_a_f;
    localparam RECT_X = 336, RECT_Y = 500;
    localparam LETTERS_2 = 12'hf_c_0;
    localparam RECT_X_2 = 750, RECT_Y_2 = 50;
    
    
    always @(posedge pclk) begin
        hcount_buff <= hcount_in;
        hsync_buff <= hsync_in;
        hblnk_buff <= hblnk_in;
        vcount_buff <= vcount;
        vsync_buff <= vsync_in; 
        vblnk_buff <= vblnk_in;
        rgb_buff <= rgb_in;
        
        hcount_buff2 <= hcount_buff;
        hsync_buff2 <= hsync_buff;
        hblnk_buff2 <= hblnk_buff;
        vcount_buff2 <= vcount_buff;
        vsync_buff2 <= vsync_buff; 
        vblnk_buff2 <= vblnk_buff;
        rgb_buff2 <= rgb_buff;
    
        hcount_out <= hcount_buff2;
        hsync_out <= hsync_buff2;
        hblnk_out <= hblnk_buff2;
        vcount_out <= vcount_buff2;
        vsync_out <= vsync_buff2; 
        vblnk_out <= vblnk_buff2;
        
        rgb_out <= rgb_out_nxt;
    
    end
     
    always @* begin
    
        if( vcount_in > RECT_Y && vcount_in <= RECT_Y + 32 && hcount_in > RECT_X && hcount_in <= RECT_X + 128) begin
            if (char_pixels[4'b1000-hcount_in_rect[2:0]])
                 rgb_out_nxt = LETTERS; 
            else
                rgb_out_nxt = rgb_in;
            end 
        else if( vcount_in > RECT_Y_2 && vcount_in <= RECT_Y_2 + 16 && hcount_in > RECT_X_2 && hcount_in <= RECT_X_2 + 24) begin
            if (char_pixels_2[4'b1000-hcount_in_rect_2[2:0]])
                 rgb_out_nxt = LETTERS_2; 
            else
                rgb_out_nxt = BG;
            end 
            
        else 
           rgb_out_nxt = rgb_in;
    end
   
     assign char_xy = {vcount_in_rect[7:4], hcount_in_rect[6:3]};
     assign char_line = vcount_in_rect[3:0] ; 
     
     
     assign vcount_in_rect = vcount_in - RECT_Y;
     assign hcount_in_rect = hcount_in - RECT_X;
     
      assign char_xy_2 = {vcount_in_rect_2[7:4], hcount_in_rect_2[6:3]};
      assign char_line_2 = vcount_in_rect_2[3:0] ; 
     
     
     assign vcount_in_rect_2 = vcount_in - RECT_Y_2;
     assign hcount_in_rect_2 = hcount_in - RECT_X_2;
endmodule
