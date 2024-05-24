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
	// ����
	reg clk;
	reg resetn;
	reg start_window;
	reg state;
	reg[7:0] image_in;
	// ���
	wire[4*8-1:0] taps;
	
	// �ļ�ָ��
	integer fp_i;
	integer count_w;
	wire valid;
	// ��ȡ��������
	reg[10:0] cnt_line;
	
	// ����ģ��
	Window #(
    .Kernel_size    (2), // ������ĵĴ�С 4x4
    .Data_width     (8),                 
    .Data_horizontal(8),//�������ݵĺ���
    .Data_vertical  (8),//�������ݵ�����
    .Stride     (2)//������������򻬶��Ĳ���
	)window_inst(
		.clk  (clk),
		.rstn (resetn),
		.start(start_window),
		.din  (image_in),
		.valid(valid),
		.taps (taps)
	);
	
	// ��ȡͼƬ����
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/8_8_2.txt","r"); // ���� 3
	end
	// ��ʼ�ź�
	initial
	begin
		cnt_line = 0;// ��ȡ��������
		clk = 1;
		read_en=0;
		resetn=0;
		start_window = 0;
		state = 1;
		# 20;
		resetn=1;
		start_window = 1;
	end
	
	// ��ȡͼ�����ݣ�һ�� 784 �У��� 784*20 + 20 = 15700 ns = 15.7 ms ����һ��28*28ͼƬ 
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
	// ʱ���ź� 50MHz
	always #10 clk <= ~clk; 
endmodule

