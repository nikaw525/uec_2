// File: vga_timing.v
// This is the vga timing design for EE178 Lab #4.

// The `timescale directive specifies what the
// simulation time units are (1 ns here) and what
// the simulator time step should be (1 ps here).

`timescale 1 ns / 1 ps

// Declare the module and its ports. This is
// using Verilog-2001 syntax.

module vga_timing (
  output reg [10:0] vcount,
  output reg vsync,
  output reg vblnk,
  output reg [10:0] hcount,
  output reg hsync,
  output reg hblnk,
  input wire pclk
  );
  
  

  // Describe the actual circuit for the assignment.
  // Video timing controller set for 800x600@60fps
  // using a 40 MHz pixel clock per VESA spec.
     
    initial begin
    
        hcount <= 0;
        vcount <= 0;
    
    end
    
    
    always @(posedge pclk) begin
    
    hcount <= hcount + 1;
    
        if( 799 <= hcount && hcount < 1055) begin
            hblnk <= 1;
            if(839 <= hcount  && hcount < 967)
                hsync <= 1;
            else 
                hsync <= 0;
        end
        else if(hcount == 1055) begin
            hcount <= 0;
            hblnk <= 0;
        end
        
        if(hcount == 1055) begin
            vcount <= vcount + 1;
            if(599 <= vcount && vcount < 627)
                vblnk <= 1;
            if(600 <= vcount && vcount < 604)
                vsync <= 1;
            else 
                vsync <= 0;
        end
        else if (vcount == 627) begin
            vcount <= 0;
            vblnk <= 0;
        end
        
    end   
    
    endmodule