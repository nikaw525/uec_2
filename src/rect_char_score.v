`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.08.2019 13:03:55
// Design Name: 
// Module Name: rect_char_score
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


module rect_char_score(
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
    input wire [7:0] ascii,
    
    output reg [10:0] hcount_out,
    output reg hsync_out,
    output reg hblnk_out,
    output reg [10:0] vcount_out,
    output reg vsync_out,
    output reg vblnk_out,
    output reg [11:0] rgb_out,
    output [7:0] char_xy,
    output [3:0] char_line
    );
    
    reg hsync_buff, hblnk_buff, vsync_buff, vblnk_buff, hsync_buff2, hblnk_buff2, vsync_buff2, vblnk_buff2;
    reg [10:0] hcount_buff, vcount_buff, char_addr, hcount, vcount, hcount_buff2, vcount_buff2;
    reg [11:0] rgb_out_nxt, rgb_buff, rgb_buff2;
    wire [10:0] hcount_in_rect, vcount_in_rect;
    
    localparam LETTERS = 12'hf_c_0, BG = 12'h7_a_f;
    localparam RECT_X = 50, RECT_Y = 50;
    
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
    
        if( vcount_in > RECT_Y && vcount_in <= RECT_Y + 16 && hcount_in > RECT_X && hcount_in <= RECT_X + 16) begin
            if (char_pixels[4'b1000-hcount_in_rect[2:0]])
                 rgb_out_nxt = LETTERS; 
            else
                rgb_out_nxt = rgb_in;
            end 
            
        else 
           rgb_out_nxt = rgb_in;
    end
   
     assign char_xy = 1; //{vcount_in_rect[7:4], hcount_in_rect[6:3]};
     assign char_line = vcount_in_rect[3:0] ; 
     
     
     assign vcount_in_rect = vcount_in - RECT_Y;
     assign hcount_in_rect = hcount_in - RECT_X;
endmodule
