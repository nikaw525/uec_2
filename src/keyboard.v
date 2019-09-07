`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.09.2019 18:03:50
// Design Name: 
// Module Name: keyboard
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

module keyboard(
    input wire clk,  
    //input wire rst, 
    input wire [11:0] x_pos_in,
    input wire [11:0] y_pos_in,
    input wire ascii_new,
    input wire [6:0] ascii_out,
    input wire [10:0] vcount,
    input wire [10:0] hcount,
    
    output reg [11:0] x_pos_k,
    output reg [11:0] y_pos_k,
    output reg Space    
    );    
    
    reg [11:0] x_pos_buff;
    reg [11:0] y_pos_buff;
    
    reg Space_buff;    
     
       always @* begin 
      
               case(ascii_out)
                    7'h61: begin
                        if(x_pos_in <= 2) x_pos_buff = 1;  
                        else
                            x_pos_buff = x_pos_in - 2;  //turn left
                        end 
                    7'h64: begin
                        if(x_pos_in >= 763) x_pos_buff = 763;
                        else
                            x_pos_buff = x_pos_in + 2;  //turn right
                        end
                    7'h20: Space_buff = 1; 
                    default:  Space_buff = 0;            
                    
                endcase            
          
       end
       
       always @(posedge clk) begin
            if(hcount == 799 && vcount == 599) begin
                x_pos_k <= x_pos_buff;
                y_pos_k <= y_pos_in;
                Space <= Space_buff;
            end
       end
       
endmodule

