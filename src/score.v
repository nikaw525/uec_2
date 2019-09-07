`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.08.2019 10:47:34
// Design Name: 
// Module Name: score
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


module score(
    input clk,
    //input rst,
    input start,
    input ending,  
    
    output reg [9:0] score_out
 );
    
    reg [11:0] score_nxt;  
    reg [25:0] counter;
    
     always @(posedge clk)
     begin  
            if((start == 1) || (ending == 1)) begin
            score_nxt = 0;
            counter = 0;
            end
            else begin         
                counter = counter + 1;
                
                if(counter == 20000000) begin 
                    score_nxt = score_nxt + 1;
                    counter = 0;
                end
            end  
     end
     
     always @(posedge clk) begin
        score_out <= score_nxt;
     end
     
endmodule
