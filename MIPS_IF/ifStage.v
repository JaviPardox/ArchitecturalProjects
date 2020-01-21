`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/18/2019 02:23:47 PM
// Design Name: 
// Module Name: ifStage
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


module ifStage(
    input [31:0] EX_MEM_PC,
    input clock,
    input PCSrc,
    output [7:0] PC_4_out,
    output [31:0] inst
    );
    
    reg [31:0] mem_array [0:17];

    reg [7:0] PC;
    wire [7:0] PC_out;
    wire [7:0] wire_pc;
    reg [31:0] reg_inst;
    reg [7:0] reg_pc;
    
    initial
    begin 
    PC = 0;
    reg_inst = 0;
    reg_pc = 0;
    $readmemh("C:/Users/Javier Pardo/Desktop/Chico/Chico/Eece 425/MIPS/IF/IF.srcs/sources_1/new/memfile.dat",mem_array);
      
    end
    
    mux ifmux(.in0(PC_out),.in1(EX_MEM_PC),.sel(PCSrc),.out(wire_pc));

    always @ (posedge clock)
    begin
    
    PC <= wire_pc;
    reg_pc <= PC_out;
    reg_inst <= mem_array[PC[7:2]];

    end
    
    assign PC_out = PC + 4;
    assign PC_4_out = reg_pc;
    assign inst = reg_inst;    
    
endmodule
