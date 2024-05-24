`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/27 17:03:58
// Design Name: 
// Module Name: window
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
// ��������������ȡ����
// ���ڸ����ģ���ṩ��������
module Window 
#(
    parameter Kernel_size=4, // ������ĵĴ�С 4x4
	parameter Data_width=8,                 
    parameter Data_horizontal=28,//�������ݵĺ���
	parameter Data_vertical=28,//�������ݵ�����
	parameter Stride=1//��������������Ĳ���                 
)  
(
    input  clk,
    input  rstn,
    input  start,       // ��ʼ��־             
    input  [Data_width-1:0]  din,  
	output     reg              valid,
    output [Data_width*Kernel_size*Kernel_size-1:0] taps  // һ������
);
           
	integer i;
	// reg start_ff;
	reg [Data_width-1:0] mem [0:Data_horizontal*Kernel_size-1];
	//״̬������
	parameter IDLE = 5'b00000;
	parameter START = 5'b000001;
    parameter READY = 5'b000010;
    parameter HORIZONTIAL_STRIDE = 5'b00100;
    parameter VERTICAL_STRIDE = 5'b01000;
    parameter DONE = 5'b10000;
    parameter VALID_NUM_HORIZONTAL=(Data_horizontal-Kernel_size)/Stride+1;
    reg  [4:0] state;

	//���ݼ���
	reg [31:0] count;
	reg [15:0] horizontal_count;
	reg [15:0] vertical_count;
	reg [15:0] valid_count;//Data_horizontal-Kernel_size/Stride+1
	
	// ÿ�������أ��ɵ������λһ��  
	always@(posedge clk or negedge rstn)begin
		if(!rstn)begin
          for(i=0;i<Data_horizontal*Kernel_size;i=i+1)  
           mem[i] <= 0;
		end
		else begin
		  if(state!==IDLE&&state!=DONE||start==1)
			begin
			   mem[0] <= din;           
			   for(i=0;i<Data_horizontal*Kernel_size-1;i=i+1)  
			   	  mem[i+1] <= mem[i];
			end
		   else begin
			for(i=0;i<Data_horizontal*Kernel_size;i=i+1)  
                  mem[i] <= 0;
		end
		end
		
	end

// ״̬�Ĵ�����ʼ��
always @(posedge clk or negedge rstn) begin
  if (!rstn) begin
    state <= IDLE; // ��λʱ״̬ΪIDLE
    valid<=0;
	count<=0;
	valid_count<=0;
	horizontal_count<=0;
	vertical_count<=0;
  end else begin
    case (state)
      IDLE: begin
        if (start==2'd1) begin
          state <= START; // ����յ������ź�1�������LOAD_WEIGHT״̬
          end 
        else begin
          state <= IDLE; // ���δ�յ������ź�0���򱣳� IDEL״̬
          end 
      end
	 START:begin
	   count<=count+1;
	   if(count==Data_horizontal*Kernel_size-2)//������keenrl�Ĵ���
	   begin
		 state<=HORIZONTIAL_STRIDE;
		 valid<=1;
	   end
	   else
	   begin
		 state<=START;
		 valid<=0;
	   end
	 end
	 HORIZONTIAL_STRIDE:begin
		count<=count+1;
		vertical_count<=0;

        if(count>=Data_horizontal*(Data_vertical+1)-Kernel_size)
		begin
			state<=DONE;
		end
		else
		begin
		   if((count+2)%Data_horizontal==0&&(count!=Data_horizontal*Kernel_size-2))//Data_horizontal-1��ʱ���Ѿ�����һ���ˣ�����Ҫ-2
		   begin
		     if(Stride>1)begin
		      state<=VERTICAL_STRIDE;
			  valid<=0;
		       end
		      else begin
		      	state<=HORIZONTIAL_STRIDE;
				valid<=1;
		      	end
		      
		   end
		   else begin
		   //������ˣ��ͺ���ȫnot valid
		   if (valid_count>VALID_NUM_HORIZONTAL-1) begin
           	valid<=0;
           end
           else
           begin

           		 if(horizontal_count>=Stride-1)//�����˼Ĵ���
           	       begin
           		    valid<=1;
           		    horizontal_count<=0;
           	       end
           		   else
           		   begin
           		     horizontal_count<=horizontal_count+1;
           		     valid<=0;
           		   end
           		   
				 
		             end 
           end
end

	 end
	 VERTICAL_STRIDE:begin
	   count<=count+1;
	   horizontal_count<=0;
	   if(count<Data_horizontal*Data_vertical)//��û�г���ͼƬ
	   begin
         if(vertical_count+1>=(Stride-1)*Data_horizontal)//�����˼Ĵ���
	        begin
		      valid<=1;
		      vertical_count<=0;
		      state<=HORIZONTIAL_STRIDE;
	        end
	     else
	        begin
		       valid<=0;
               vertical_count<=vertical_count+1;
		       state<=VERTICAL_STRIDE;
	        end
		end
		else
		begin
		  state<=DONE;
		  
		end
	 
	 end

	 DONE:begin
	   state<=IDLE;
	   valid<=0;
	   vertical_count<=0;
	   horizontal_count<=0;
	   valid_count<=0;
	 end
    default :begin
	 state<=IDLE;
	 valid<=0;
	 count<=0;
	 horizontal_count<=0;
	 vertical_count<=0;
	end
	endcase
  end
end

always @(negedge clk or negedge rstn) begin
	if (!rstn) begin
		valid_count<=0;
	end
	else begin
		if(state==HORIZONTIAL_STRIDE)
		begin
			    if((count+2)%Data_horizontal==0&&(count!=Data_horizontal*Kernel_size-2))
			         valid_count<=0;
			    else begin

                  //����һ���ж��ٴ�valid
		          if(valid==1)
		            begin
		             valid_count<=valid_count+1;
		            end
                  else begin
		           valid_count<=valid_count;
		            end
					
				end

		end
	end
	
		
end



	// state=0:28*28   state=1:12*12
genvar j,k;
generate
    for (j = 0; j < Kernel_size; j=j+1)
    begin: vertical_windowdata
	    for (k =0; k<Kernel_size; k=k+1)
		begin: horizontal_windowdata
        assign taps[(j*Kernel_size+k)*Data_width+Data_width-1:(j*Kernel_size+k)*Data_width] = (valid)?mem[((Kernel_size-j)*Data_horizontal-k)-1]:0;
		end
    end
endgenerate


endmodule



