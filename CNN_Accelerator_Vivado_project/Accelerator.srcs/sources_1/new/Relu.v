`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/29 20:03:08
// Design Name: 
// Module Name: Relu
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
module Relu#(
    parameter DATA_IN_WIDETH=32,
    parameter PARA_WIDTH=8,
    parameter DATA_OUT_WIDETH=8
) 
(
    input signed [DATA_IN_WIDETH-1:0] din,  
    input ivalid,
    input [PARA_WIDTH-1:0]scaler, //ÓÒÒÆ
    input [PARA_WIDTH-1:0]scalel,//×óÒÆ
    output  ovalid,   
    output  signed [DATA_OUT_WIDETH-1:0] dout
);


assign ovalid=ivalid;
assign dout=ivalid?(din[DATA_IN_WIDETH-1]?0:(din>>>scaler)<<<scalel):0;


	
endmodule