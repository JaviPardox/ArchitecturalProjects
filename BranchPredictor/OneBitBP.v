`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2019 12:12:16 AM
// Design Name: 
// Module Name: OneBitBP
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


module OneBitBP(
    input clk,
    input [2:0] branchID,
    input outcome,
    input reset,
    output reg miss
    );
    
    integer i;
    reg BHT [0:7];
    
    initial
    begin
    for(i=0;i<8;i=i+1)       //initialize the array
    BHT[i] = 0;
    end 
    
    always @ (posedge clk)
    begin
      if(reset == 1)
          begin
          for(i=0;i<8;i=i+1)
          BHT[i] <= 0;
          end
      else if(BHT[branchID] == outcome)    //no miss
         miss <= 0;
      else if(BHT[branchID] != outcome)    //miss
      begin
         miss <= 1;
         BHT[branchID] <= outcome;         //change of state 
      end
      
    end
    
        
    
    
endmodule
