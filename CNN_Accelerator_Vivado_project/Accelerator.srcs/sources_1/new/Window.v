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
// 滑窗法，滑窗读取数据
// 用于给卷积模块提供输入数据
module Window 
#(
    parameter Kernel_size=4, // 卷积核心的大小 4x4
	parameter Data_width=8,                 
    parameter Data_horizontal=28,//输入数据的横向长
	parameter Data_vertical=28,//输入数据的纵向长
	parameter Stride=1//卷积操作窗滑动的步长                 
)  
(
    input  clk,
    input  rstn,
    input  start,       // 开始标志             
    input  [Data_width-1:0]  din,  
	output     reg              valid,
    output [Data_width*Kernel_size*Kernel_size-1:0] taps  // 一列数据
);
           
	integer i;
	// reg start_ff;
	reg [Data_width-1:0] mem [0:Data_horizontal*Kernel_size-1];
	//状态机定义
	parameter IDLE = 5'b00000;
	parameter START = 5'b000001;
    parameter READY = 5'b000010;
    parameter HORIZONTIAL_STRIDE = 5'b00100;
    parameter VERTICAL_STRIDE = 5'b01000;
    parameter DONE = 5'b10000;
    parameter VALID_NUM_HORIZONTAL=(Data_horizontal-Kernel_size)/Stride+1;
    reg  [4:0] state;

	//数据计数
	reg [31:0] count;
	reg [15:0] horizontal_count;
	reg [15:0] vertical_count;
	reg [15:0] valid_count;//Data_horizontal-Kernel_size/Stride+1
	
	// 每个上升沿，由低向高移位一次  
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

// 状态寄存器初始化
always @(posedge clk or negedge rstn) begin
  if (!rstn) begin
    state <= IDLE; // 复位时状态为IDLE
    valid<=0;
	count<=0;
	valid_count<=0;
	horizontal_count<=0;
	vertical_count<=0;
  end else begin
    case (state)
      IDLE: begin
        if (start==2'd1) begin
          state <= START; // 如果收到启动信号1，则进入LOAD_WEIGHT状态
          end 
        else begin
          state <= IDLE; // 如果未收到启动信号0，则保持 IDEL状态
          end 
      end
	 START:begin
	   count<=count+1;
	   if(count==Data_horizontal*Kernel_size-2)//存满了keenrl寄存器
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
		   if((count+2)%Data_horizontal==0&&(count!=Data_horizontal*Kernel_size-2))//Data_horizontal-1的时候已经是下一行了，所以要-2
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
		   //如果满了，就后面全not valid
		   if (valid_count>VALID_NUM_HORIZONTAL-1) begin
           	valid<=0;
           end
           else
           begin

           		 if(horizontal_count>=Stride-1)//存满了寄存器
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
	   if(count<Data_horizontal*Data_vertical)//还没有超出图片
	   begin
         if(vertical_count+1>=(Stride-1)*Data_horizontal)//存满了寄存器
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

                  //计算一行有多少次valid
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



