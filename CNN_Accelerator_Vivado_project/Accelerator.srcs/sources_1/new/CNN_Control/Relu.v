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
    parameter Data_width=16
) 
(
    input signed [Data_width-1:0] din,  
    input ivalid,
    output  ovalid,   
    output  signed [Data_width-1:0] dout
);


assign ovalid=ivalid;
assign dout=ivalid?(din[Data_width-1]?0:din):0;

/*
reg signed [Data_width-1:0] reg_din;

always @(posedge clk or negedge rstn) begin
    if(!rstn)
    begin
      ovalid<=0;
      reg_din<=0;
    end
    else begin
      reg_din<=din;
      ovalid<=ivalid;
end
end


always @(posedge clk or negedge rstn) begin
    if(!rstn)
    begin
      dout<=0;
    end
    else begin
      if(ivalid)
         dout<=reg_din[Data_width-1]==0 ? reg_din : 0 ;
        else
         dout<=0;
end
end

*/


	
endmodule