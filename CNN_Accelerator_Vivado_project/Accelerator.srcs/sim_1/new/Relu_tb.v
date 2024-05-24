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
	// ����
	reg clk;
	reg resetn;
	reg state;
	reg[7:0] image_in;
	wire [31:0] image;
	// ���
	wire[8-1:0] taps;
	
	// �ļ�ָ��
	integer fp_i;
	integer count_w;
	reg valid;
	wire ovalid;
	// ��ȡ��������
	reg[10:0] cnt_line;
	
	// ����ģ��
	Relu #(
    .Data_width(8)//������������򻬶��Ĳ���
	)relu_inst(
		.din  ({image}),
		.ivalid(valid),
		.ovalid(ovalid),
		.dout (taps)
	);
	
	// ��ȡͼƬ����
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/relu.txt","r"); // ���� 3
	end
	// ��ʼ�ź�
	initial
	begin
		cnt_line = 0;// ��ȡ��������
		clk = 1;
		resetn=0;
		valid = 0;
		# 19;
		resetn=1;
		valid = 1;
	end
	
	// ��ȡͼ�����ݣ�һ�� 784 �У��� 784*20 + 20 = 15700 ns = 15.7 ms ����һ��28*28ͼƬ 
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
	
	// ʱ���ź� 50MHz
	always #10 clk <= ~clk; 
	assign image={{24{image_in[7]}},image_in};
endmodule
