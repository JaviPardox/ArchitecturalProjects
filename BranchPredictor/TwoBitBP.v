`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2019 10:53:13 PM
// Design Name: 
// Module Name: TwoBitBP
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


module TwoBitBP(
    input clk,
    input [2:0] branchID,
    input outcome,
    input reset,
    output reg miss
    );
    
    integer i;
    reg [1:0] BHT [7:0];
    reg result;
        
    initial
    begin
    for(i=0;i<8;i=i+1)
    BHT[i] = 2'b00;
    end 
    
    always @ (posedge clk)
    begin
    
    if(reset == 1)
    begin
        for(i=0;i<8;i=i+1)            //initialize the array
        BHT[i] <= 2'b00;
    end
    if(BHT[branchID][1] == outcome)
    begin
        if(outcome == 1 && BHT[branchID] == 2'b10)           //correct prediction, taken -> go up
        BHT[branchID] <= 2'b11;
        else if(outcome == 0 && BHT[branchID] == 2'b01)      //correct orediction, not taken -> go down
        BHT[branchID] <= 2'b00;
        miss <= 0;
    end
    if(BHT[branchID][1] != outcome)
    begin
        if(outcome == 1)                                    //wrong prediction, taken -> go up
        BHT[branchID] <= BHT[branchID] + 2'b01;
        else if(outcome == 0)                               //wrong prediction, not taken -> go down
        BHT[branchID] <= BHT[branchID] - 2'b01;
        miss <= 1;
    end

    end
endmodule
