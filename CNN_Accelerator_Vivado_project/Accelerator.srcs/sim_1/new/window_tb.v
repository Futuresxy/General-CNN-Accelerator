`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/27 17:06:52
// Design Name: 
// Module Name: window_tb
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

module window_tb();
	// 输入
	reg clk;
	reg resetn;
	reg start_window;
	reg state;
	reg[7:0] image_in;
	// 输出
	wire[4*8-1:0] taps;
	
	// 文件指针
	integer fp_i;
	integer count_w;
	wire valid;
	// 读取行数计数
	reg[10:0] cnt_line;
	
	// 滑窗模块
	Window #(
    .Kernel_size    (2), // 卷积核心的大小 4x4
    .Data_width     (8),                 
    .Data_horizontal(8),//输入数据的横向长
    .Data_vertical  (8),//输入数据的纵向长
    .Stride     (2)//卷积操作窗横向滑动的步长
	)window_inst(
		.clk  (clk),
		.rstn (resetn),
		.start(start_window),
		.din  (image_in),
		.valid(valid),
		.taps (taps)
	);
	
	// 读取图片数据
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/8_8_2.txt","r"); // 数字 3
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		read_en=0;
		resetn=0;
		start_window = 0;
		state = 1;
		# 20;
		resetn=1;
		start_window = 1;
	end
	
	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk)
	begin
		begin
		if(start_window==1)begin
			count_w  <= $fscanf(fp_i,"%d" ,image_in);
			cnt_line <= cnt_line + 1;
			if(cnt_line == 11'd64) 
			begin
			     $display("picture read over");
			     start_window = 1;
			     read_en<=1;
			end// $display("%d,%b",count_w,image_in);
			end
		end
	end
	reg read_en;
	wire [9:0] data_count;
	wire [31:0] data_out;
	wire  full,empty;
	fifo_windows_data  fifo0(
    .clk  (   clk       ),
    .srst (   !resetn       ),
    .din  (   taps       ),
    .wr_en(   valid       ),
    .dout (   data_out       ),
    .rd_en(   read_en       ),
	.full (   full       ),
    .empty(   empty       ),
    .data_count( data_count    )
	);
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
endmodule

