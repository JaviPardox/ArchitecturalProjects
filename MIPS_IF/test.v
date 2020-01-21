`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/23/2019 03:47:25 PM
// Design Name: 
// Module Name: test
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


module testbench;
   reg [31:0] ex;
   reg clock;
   reg PCSrc;
   wire [7:0] pc_out;
   wire [31:0] inst;
   
   ifStage test(.EX_MEM_PC(ex),.clock(clock),.PCSrc(PCSrc),.PC_4_out(pc_out),.inst(inst));
   
   initial
   begin
   
   ex = 0;
   PCSrc = 0;
   clock = 0;
   #100;

   end
      
   
   always
   begin
   #5;
   clock = ~clock;
   if(clock == 1)
   $display ("PC: %0b, Instruction: %0b", pc_out, inst);
   end
   endmodule
