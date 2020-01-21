`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2019 01:57:21 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
   input signed [31:0] a, b,
   input [3:0] f,
   output signed [31:0] y,
   output [3:0] zero
   //output [32:0] aver 
   );
     
   reg signed [31:0] result;
   
    
   always @ (*)
   case (f)
   0: result = a & b;
   1: result = a | b;
   2: result = a + b;
   3: result = a ^ b;
   4: result = a & ~b;
   5: result = a | ~b;
   6: result = a + ~b + 1;
   7: result = (a < b) ? 1 : 0;
   default: result = 0;
   endcase
   
   //assign aver = y; 
   assign zero = (y == 0) ? 1 : 0;
   assign y = result;
    
endmodule
