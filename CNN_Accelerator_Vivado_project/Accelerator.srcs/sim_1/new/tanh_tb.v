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

    );// ����
	reg clk;
	reg resetn;
	reg state;
	reg[31:0] image_in;
	// ���
	wire[31:0] taps;
	
	// �ļ�ָ��
	integer fp_i;
	integer count_w;
	reg valid;
	wire ovalid;
	// ��ȡ��������
	reg[10:0] cnt_line;
    tanh#(
    .Data_width(32),//������������򻬶��Ĳ���
    .OutData_width(64)
    )  tanhx(
  .clk (clk),
  .rstn(resetn),
  .resetExternal(0),
  .io_inAct(image_in),
  .io_inValid(valid),
  .io_outTanh(taps),
  .finishedTanh(),//����
  .io_outValid()
);
	
	// ��ȡͼƬ����
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/tanh.txt","r"); // ���� 3
	end
	// ��ʼ�ź�
	initial
	begin
		cnt_line = 0;// ��ȡ��������
		clk = 1;
		resetn=0;
		valid = 0;
		# 18;
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
			if(cnt_line == 11'd6) 
			begin
			     $display("picture read over");
			     valid = 0;
			end// $display("%d,%b",count_w,image_in);
			end
		end
	end
	
	// ʱ���ź� 50MHz
	always #10 clk <= ~clk; 
endmodule
