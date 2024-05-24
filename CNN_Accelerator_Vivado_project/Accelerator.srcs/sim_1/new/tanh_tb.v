`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/01 12:23:48
// Design Name: 
// Module Name: tanh_tb
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


module tanh_tb(

    );// 输入
	reg clk;
	reg resetn;
	reg state;
	reg[31:0] image_in;
	// 输出
	wire[31:0] taps;
	
	// 文件指针
	integer fp_i;
	integer count_w;
	reg valid;
	wire ovalid;
	// 读取行数计数
	reg[10:0] cnt_line;
    tanh#(
    .Data_width(32),//卷积操作窗横向滑动的步长
    .OutData_width(64)
    )  tanhx(
  .clk (clk),
  .rstn(resetn),
  .resetExternal(0),
  .io_inAct(image_in),
  .io_inValid(valid),
  .io_outTanh(taps),
  .finishedTanh(),//结束
  .io_outValid()
);
	
	// 读取图片数据
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/tanh.txt","r"); // 数字 3
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		resetn=0;
		valid = 0;
		# 18;
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
			if(cnt_line == 11'd6) 
			begin
			     $display("picture read over");
			     valid = 0;
			end// $display("%d,%b",count_w,image_in);
			end
		end
	end
	
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
endmodule
