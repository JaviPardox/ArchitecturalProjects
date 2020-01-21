`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2019 05:40:16 PM
// Design Name: 
// Module Name: testbench
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
   reg signed [31:0] a, b;
   reg signed [31:0] xy;
   reg [3:0] f;
   reg [3:0] xzero;
   wire [31:0] y;
   wire [3:0] zero;
   
   parameter vecs = 21;
   
   reg [103:0] vec[0:vecs-1];
   integer N;
   
   ALU test(.a(a),.b(b),.f(f),.y(y),.zero(zero));
   
   initial
   begin
   
   a = 0;
   b = 0;
   f = 0;
   
   $readmemh("C:/Users/Javier Pardo/Desktop/Chico/Chico/Eece 425/ALU/project_1/project_1.srcs/sources_1/new/alu.txt",vec);
   
   #100
   
   for(N = 0; N < vecs; N = N+1)
   begin
   {f,a,b,xy,xzero} = vec[N];
   #5
   if({xy,xzero} != {y,zero})
   $display ("Mismatch on vector %0b, Expected %0b, Actual %0b", N, {xy,xzero}, {y,zero});
   else
   $display ("Vector %0b OK", N);
   end
   end
   endmodule