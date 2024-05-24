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
    parameter DATA_IN_WIDETH=32,
    parameter DATA_OUT_WIDETH=8,
    parameter PARA_WIDTH=8,
    parameter Relu_Num=3 
)(
  input                                     clk,
  input                                     rstn,
  input                                     refresh,
  input   [PARA_WIDTH-1:0]                  scaler, //右移
  input   [PARA_WIDTH-1:0]                  scalel,//左移
  input   [Relu_Num*DATA_IN_WIDETH-1:0]     io_inAct,
  input                                     io_invalid,
  output  [Relu_Num*DATA_OUT_WIDETH-1:0]    io_outSum,
  output                                    out_valid
);



genvar i;

for (i=0;i<Relu_Num;i=i+1)
begin:Relu_Array
    wire [DATA_OUT_WIDETH-1:0] data_relu;
    wire                  ovalid;
	Relu #(
	.DATA_IN_WIDETH(DATA_IN_WIDETH),
	.PARA_WIDTH(PARA_WIDTH),
    .DATA_OUT_WIDETH(DATA_OUT_WIDETH)//卷积操作窗横向滑动的步长
	)relu_inst(
		.din  (io_inAct[(i+1)*DATA_IN_WIDETH-1:i*DATA_IN_WIDETH]),
		.scalel(scalel),
		.scaler(scaler),
		.ivalid(io_invalid),
		.ovalid(ovalid),
		.dout (data_relu)
	);
end

genvar j;

for (j =0 ;j<Relu_Num ;j=j+1 ) begin

assign io_outSum[(j+1)*DATA_OUT_WIDETH-1:j*DATA_OUT_WIDETH] = Relu_Array[j].data_relu;

end

assign  out_valid =Relu_Array[Relu_Num-1].ovalid;











endmodule
