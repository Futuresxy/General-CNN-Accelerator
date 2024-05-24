`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/28 16:00:33
// Design Name: 
// Module Name: fullcon_tb
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



module fullcon_tb();
	// 输入
	reg clk;
	reg resetn;
	reg start_window;
	reg state;
	reg[12*8-1:0] w_in;
    reg[7:0] a_in;
	
	// 文件指针
	integer fp_a;
	integer fp_w;
	integer count_w;
	integer count_a;
	wire [7:0] out_a;
	// 读取行数计数
	reg[10:0] cnt_line;
	reg   clear;
	wire [10*16-1:0] sum_o;
	wire outvalid;
	wire  finish;
	// 滑窗模块
	FullCon_PE_Control #(
    .DATA_WIDTH     (8),
    .OutData_width  (16),
    .FULLCON_INPUT_SIZE(28),//输入数据的横向长
	.FULLCON_OUTPUT_NUM  (1),//输入数据的纵向长
	.FULLCON_OUTPUT_SIZE (8) //输出层的大小
)   full_1(
  .clk        ( clk ),
  .rstn       ( resetn),
  .io_inAct   ( a_in  ),
  .FULLCON_Input_Size(28 ),
  .FULLCON_Output_Size(8 ),
  .io_inWeight( w_in  ),
//  .io_outAct  (out_a   ),
  .io_outSum  (sum_o ),
  .io_clear   (clear),
  .io_inValid (start_window ),
  .out_finish(finish)
//  .io_outvalid(outvalid   )
  );
	
	// 读取图片数据
	initial
	begin
		fp_a = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/fc_a.txt","r"); 
		fp_w = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/fc_w.txt","r"); 
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		clear=0;
		resetn=0;
		start_window = 0;
		# 20;
		resetn=1;
		start_window = 1;
	end
	
	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk)
	begin
		begin
			if(start_window==1)begin
			count_w  <= $fscanf(fp_w,"%b" ,w_in);
			count_a  <= $fscanf(fp_a,"%b" ,a_in);
			cnt_line <= cnt_line + 1;
			if(cnt_line == 11'd29)
			begin 
			$display("picture read over");
			start_window=0;
			end
			// $display("%d,%b",count_w,image_in);
			end
		end
	end
	
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
endmodule

