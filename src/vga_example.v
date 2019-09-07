// File: vga_example.v
// This is the top level design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_example (
  input wire clk,
  output reg vs,
  output reg hs,
  output reg [3:0] r,
  output reg [3:0] g,
  output reg [3:0] b,
  output wire pclk_mirror,
  inout wire ps2_clk,
  inout wire ps2_data, 
  input wire rst
  );

  wire mclk, kclk; 
  wire locked;
  wire pclk; //, slow_clk;
  
  clk_wiz_0 my_clk_wiz_0 (
    .clk(clk),
    .clk40MHz(pclk),
    .clk100MHz(mclk),
    .clk50MHz(kclk),
    .reset(rst),
    .locked(locked)
  );
  

  ODDR pclk_oddr (
    .Q(pclk_mirror),
    .C(pclk),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
  );
  
  wire [10:0] vcount, hcount, vcount_out, hcount_out, vcount_in, hcount_in, vcount_out_x, hcount_out_x, vcount_out_a, hcount_out_a, vcount_out_b, hcount_out_b, vcount_out_c, hcount_out_c, char_addr, vcount_out_d, hcount_out_d, vcount_out_e, hcount_out_e, vcount_out_f, hcount_out_f;
  wire vsync, hsync, vsync_out, hsync_out, vsync_in, hsync_in, vsync_in_a, hsync_in_a, vsync_out_x, hsync_out_x, vsync_out_a, hsync_out_a,vsync_out_c, hsync_out_c, vsync_out_d, hsync_out_d, vsync_out_e, hsync_out_e, vsync_out_f, hsync_out_f;
  wire vblnk, hblnk, vblnk_out, hblnk_out, vblnk_in, hblnk_in, vblnk_out_x, hblnk_out_x, vblnk_out_a, hblnk_out_a, vblnk_out_b, hblnk_out_b, vblnk_out_c, hblnk_out_c, vblnk_out_d, hblnk_out_d, vblnk_out_e, hblnk_out_e, vblnk_out_f, hblnk_out_f;
  wire [11:0] rgb_out, rgb_in, rgb_out_x, rgb_out_a, rgb_out_b, rgb_out_c, rgb_out_d, rgb_out_e, rgb_out_f;
  wire [11:0] x_pos, y_pos, pixel_addr, rgb, x_pos_m, y_pos_m, pixel_addr2, x_pos_f, y_pos_f, xpos, ypos, xpos2, ypos2, x_pos_o, y_pos_o, x_pos_k, y_pos_k;
  
  //reg [3:0] red_in, green_in, blue_in;
  //wire [3:0] red_out, green_out, blue_out, char_line, char_line_2, an;
  wire [3:0] char_line, char_line_2;
  reg [11:0] x_buff, y_buff;
  //wire mouse_click, tx_monitor, start, ending;
  wire start, ending;
  wire [7:0] char_pixels, char_pixels_2, char_xy, char_xy_2;
  wire [6:0] char_code, char_code_2; // char_code_score, sseg;
  //reg vs_buff, hs_buff, vsync_out_b, hsync_out_b;
  //reg [11:0] rgb_buff;
  //wire [15:0] ascii;
  //wire [7:0] code;
  wire [1:0] hit;
  //wire [1:0] hit_recent;
  //wire [23:0] accel;
  
   //wire btn_db;
   //wire [7:0] rec_data, wrt_data, rec_data_fifo;
   //wire tx_full, rx_empty, tx, rx;  
 
   wire [9:0] score_out;
   
    wire ascii_new;
   wire [6:0] ascii_out;
   
   wire Space;
   
  vga_timing my_timing (
    .vcount(vcount),
    .vsync(vsync),
    .vblnk(vblnk),
    .hcount(hcount),
    .hsync(hsync),
    .hblnk(hblnk),
    .pclk(pclk)
  );
  
     
  draw_background my_background(
    .hcount_in(hcount),
    .hsync_in(hsync),
    .hblnk_in(hblnk),
    .vcount_in(vcount),
    .vsync_in(vsync),
    .vblnk_in(vblnk),
    .pclk(pclk),
    .rst(rst),
    
    .vcount_out(vcount_out_x),
    .vblnk_out(vblnk_out_x),
    .vsync_out(vsync_out_x),
    .hcount_out(hcount_out_x),
    .hblnk_out(hblnk_out_x),
    .hsync_out(hsync_out_x),
    .rgb_out(rgb_out_x)
    );
    
    floors_fall my_floor(         
         .space_button(Space),
         .x_pos(x_pos),
         .y_pos(y_pos),
         .x_obj(x_buff),
         .y_obj(y_pos_f),
         .hcount_in(hcount_out_x),
         .hsync_in(hsync_out_x),
         .hblnk_in(hblnk_out_x),
         .vcount_in(vcount_out_x),
         .vsync_in(vsync_out_x),
         .vblnk_in(vblnk_out_x),
         .rgb_in(rgb_out_x),
         .pclk(pclk),
         .rst(rst),
        
         .vcount_out(vcount_out_d),
         .vblnk_out(vblnk_out_d),
         .vsync_out(vsync_out_d),
         .hcount_out(hcount_out_d),
         .hblnk_out(hblnk_out_d),
         .hsync_out(hsync_out_d),
         .rgb_out(rgb_out_d),
         .xpos(xpos),
         .ypos(ypos),
         .x_obj_out(x_pos_o),
         .y_obj_out(y_pos_o),
         .floor_hit(hit),
         .start(start),
         .ending(ending)         
          );
          
    object_fall my_object(
        .floor_hit(hit),
        .obj_xpos(x_buff),
        .obj_ypos(y_pos_o),
        .clk(pclk),
        .rst(rst),
        .start(start),
        .ending(ending),
        
        .xpos(x_pos_f),
        .ypos(y_pos_f)                            
        ); 
        
        score my_score(
            .clk(pclk),          
            .start(start),
            .ending(ending),            
            
            .score_out(score_out)
            
        );
        
      ps2_keyboard_to_ascii my_ps2_keyboard_to_ascii (
           .clk(mclk),
           .ps2_clk(ps2_clk),
           .ps2_data(ps2_data),
               
           .ascii_new(ascii_new),
           .ascii_code(ascii_out)
        ); 
             
      keyboard my_keyboard(
           .clk(pclk),
           .ascii_new(ascii_new),
           .ascii_out(ascii_out),
           .x_pos_in(x_buff),
           .y_pos_in(y_buff),
           .hcount(hcount),
           .vcount(vcount),
                                     
           .x_pos_k(x_pos_k),
           .y_pos_k(y_pos_k),       
           .Space(Space)
       ); 
   
   draw_rect_char my_rect_char (
         .hcount_in(hcount_out_d),
         .hsync_in(hsync_out_d),
         .hblnk_in(hblnk_out_d),
         .vcount_in(vcount_out_d),
         .vsync_in(vsync_out_d),
         .vblnk_in(vblnk_out_d),
         .rst(rst),
         .pclk(pclk),
         .rgb_in(rgb_out_d),
         .char_pixels(char_pixels),
         .char_pixels_2(char_pixels_2),
              
         .hcount_out(hcount_out_f),
         .hsync_out(hsync_out_f),
         .hblnk_out(hblnk_out_f),
         .vcount_out(vcount_out_f),
         .vsync_out(vsync_out_f),
         .vblnk_out(vblnk_out_f),
         .rgb_out(rgb_out_f),
         .char_xy(char_xy),
         .char_line(char_line),
         .char_xy_2(char_xy_2),
         .char_line_2(char_line_2)
        //       .char_addr(char_addr)
         );
  
   draw_rect_ctl my_rect_ctl(
     .space_button(Space),
     .obj_xpos(xpos),
     .obj_ypos(ypos),
     .score(score_out),
     .clk(pclk),
     .rst(rst),
     .xpos(x_pos),
     .ypos(y_pos)     
   );  
     
   font_rom my_font_rom (
     .clk(pclk),
     .addr({char_code, char_line}),            // {char_code[6:0], char_line[3:0]}
     .char_line_pixels(char_pixels)  // pixels of the character line
    );
    
    font_rom my_font_rom2 (
     .clk(pclk),
     .addr({char_code_2, char_line_2}),            // {char_code[6:0], char_line[3:0]}
     .char_line_pixels(char_pixels_2)  // pixels of the character line
    );
           
   char_rom_end my_char_rom_end(
      .clk(pclk),
     .start(start),
     .ending(ending),
     .char_xy(char_xy),
     .char_code(char_code)
   );     
     
   char_rom_16x16 my_char_rom_16x16(
     .char_xy(char_xy_2),          
     .score(score_out),
     .char_code(char_code_2)
   );  
  
    always @(posedge pclk)begin
         
     vs <= vsync_out_f;
     hs <= hsync_out_f; 
     {r,g,b} <= rgb_out_f;
     x_buff <= x_pos_k;
     y_buff <= y_pos_k;
     end
    
endmodule
