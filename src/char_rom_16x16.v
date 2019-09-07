`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2019 12:41:54
// Design Name: 
// Module Name: char_rom_16x16
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

module char_rom_16x16(    
    input wire [7:0] char_xy,    
    input wire [9:0] score,
    output reg [6:0] char_code
    );
        always@* begin       
            if(char_xy == 0) begin
                 char_code = ((score / 100) + 48 );                  
             end     
             else if(char_xy == 1) begin
                  char_code = (((score / 10 ) % 10) + 48) ;
             end
             else if(char_xy == 2) begin
                  char_code = ((score % 10) + 48);
             end
        end
           
endmodule
       
            

