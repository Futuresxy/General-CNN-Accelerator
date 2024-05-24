`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/08 15:05:57
// Design Name: 
// Module Name: Relu_Array_Control
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
module Relu_Array_Control#(   
    parameter Data_width=16,
    parameter Relu_Num=3 
)(
  input                                     clk,
  input                                     rstn,
  input                                     refresh,
  input  [Relu_Num*Data_width-1:0]          io_inAct,
  input                                     io_invalid,
  output [Relu_Num*Data_width-1:0]          io_outSum,
  output                                    out_valid
);



genvar i;

for (i=0;i<Relu_Num;i=i+1)
begin:Relu_Array
    wire [Data_width-1:0] data_relu;
    wire                  ovalid;
	Relu #(
    .Data_width(Data_width)//卷积操作窗横向滑动的步长
	)relu_inst(
		.din  (io_inAct[(i+1)*Data_width-1:i*Data_width]),
		.ivalid(io_invalid),
		.ovalid(ovalid),
		.dout (data_relu)
	);
end

genvar j;

for (j =0 ;j<Relu_Num ;j=j+1 ) begin

assign io_outSum[(j+1)*Data_width-1:j*Data_width] = Relu_Array[j].data_relu;

end

assign  out_valid =Relu_Array[Relu_Num-1].ovalid;











endmodule
