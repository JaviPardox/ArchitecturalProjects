`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 09:01:53 PM
// Design Name: 
// Module Name: FourBitBP
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


module FourBitBP(
    input clk,
    input [2:0] branchID,
    input outcome,
    input reset,
    output reg miss
    );
    
    integer i;
    reg [3:0] BHT [7:0];        
    reg [1:0] Counters [127:0];            //128 total counters, divided in groups of 16 counters -> 8 groups
                                           //use pc (branchID) to access each group since 2^3 = 8
    initial
    begin
    for(i=0;i<128;i=i+1)                   //initialize both arrays
    begin
        if(i < 8)
            BHT[i] = 4'b0000;
        Counters[i] = 2'b00;
    end
    end
    
    always @ (posedge clk)
    begin
    
    if(Counters[{branchID,BHT[branchID]}] == outcome)               //index the counters with the PC and the 4-bit history
    begin
        miss <= 0;
        if(outcome == 0 && Counters[{branchID,BHT[branchID]}] == 2'b01)
            Counters[{branchID,BHT[branchID]}] <= 2'b00;
        if(outcome == 1 && Counters[{branchID,BHT[branchID]}] == 2'b10)
            Counters[{branchID,BHT[branchID]}] <= 2'b11;
        BHT[branchID] <= {BHT[branchID][2], BHT[branchID][1], BHT[branchID][0], outcome};   //shift the outcome into the 4-bit history
    end
    
    if(Counters[{branchID,BHT[branchID]}] != outcome)               //same logic as the 2-bit branch predictor
    begin
        miss <= 1;
        if(outcome == 0)                                                
            Counters[{branchID,BHT[branchID]}] <= Counters[{branchID,BHT[branchID]}] - 2'b01;    
        if(outcome == 1)
            Counters[{branchID,BHT[branchID]}] <= Counters[{branchID,BHT[branchID]}] + 2'b01;
        BHT[branchID] <= {BHT[branchID][2], BHT[branchID][1], BHT[branchID][0], outcome};
    end        
     
    
    
  end
    
    
    
endmodule
