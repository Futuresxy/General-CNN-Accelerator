`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/01 10:05:42
// Design Name: 
// Module Name: Relu_tb
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


module Relu_tb();
	// 输入
	reg clk;
	reg resetn;
	reg state;
	reg[7:0] image_in;
	wire [31:0] image;
	// 输出
	wire[8-1:0] taps;
	
	// 文件指针
	integer fp_i;
	integer count_w;
	reg valid;
	wire ovalid;
	// 读取行数计数
	reg[10:0] cnt_line;
	
	// 滑窗模块
	Relu #(
    .Data_width(8)//卷积操作窗横向滑动的步长
	)relu_inst(
		.din  ({image}),
		.ivalid(valid),
		.ovalid(ovalid),
		.dout (taps)
	);
	
	// 读取图片数据
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/relu.txt","r"); // 数字 3
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		resetn=0;
		valid = 0;
		# 19;
		resetn=1;
		valid = 1;
	end
	
	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk)
	begin
		begin
		if(valid==1)begin
			count_w  <= $fscanf(fp_i,"%d" ,image_in);
			cnt_line <= cnt_line + 1;
			if(cnt_line == 11'd10) 
			begin
			     $display("picture read over");
			     valid = 0;
			end// $display("%d,%b",count_w,image_in);
			end
		end
	end
	
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
	assign image={{24{image_in[7]}},image_in};
endmodule
