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

module windows
#(
	parameter Data_width=8,          
	parameter PARA_DATA_WIDTH =8,       
    parameter KERNEL_SIZE    =2, //���ľ�����ĵĴ�С 4x4              
	parameter DATA_HORIZONTAL=28,//�����������ݵĺ���
	parameter DATA_VERTICAL  =28,//�����������ݵ�����
	parameter STRIDE         =1//���ľ�������������Ĳ���                 
)  
(
    input  clk,
    input  rstn,
	input	wire [PARA_DATA_WIDTH-1:0]	DATA_horizontal,
	input	wire [PARA_DATA_WIDTH-1:0]	DATA_vertical,
	input	wire [PARA_DATA_WIDTH-1:0]	KERNEL_size,
	input	wire [PARA_DATA_WIDTH-1:0]	Window_Stride, 
    input  start,       // ��ʼ��־   
	input  refresh,          
    input  [Data_width-1:0]     din,  
	output     reg              out_valid,
	output                      done,
	output                      last,          
    output reg [Data_width*KERNEL_SIZE*KERNEL_SIZE-1:0] taps  // һ������
);
//       ila_window ila_00(
//       .clk(clk),
//       .probe0(count),
//       .probe1(state),
//       .probe2(out_valid),
//       .probe3(taps),
//       .probe4(start),
//       .probe5(din),
//       .probe6(done),
//       .probe7(Data_Complete_Size),
//       .probe8(Data_Whole_Size),
//       .probe9({Data_horizontal,Data_vertical}),
//       .probe10(Kernel_size)
//       );    

	// reg start_ff;
	 reg [Data_width-1:0] mem [DATA_HORIZONTAL*KERNEL_SIZE-1:0];
	reg  signed [15:0]   VALID_NUM_HORIZONTAL;
	reg  signed [15:0]   VALID_NUM_HORIZONTAL1;
	wire signed [15:0]   Divider_Out;
	reg  signed [PARA_DATA_WIDTH-1:0]   VALID_NUM_HORIZONTAL0;
	//״̬������
	parameter IDLE = 5'b00000;
	parameter START = 5'b000001;
    parameter READY = 5'b000010;
    parameter HORIZONTIAL_STRIDE = 5'b00100;
    parameter VERTICAL_STRIDE = 5'b01000;
    parameter DONE = 5'b10000;

    reg  [4:0] state;
     reg              valid;
	//���ݼ���
	 reg [31:0] count;
	reg [15:0] horizontal_count;
	reg [15:0] vertical_count;
	reg [15:0] horizontal_stride_count;
	reg [15:0] valid_count;//Data_horizontal-Kernel_size/Stride+1
	reg [31:0] whole_valid_count;
	reg [PARA_DATA_WIDTH-1:0]	Data_horizontal;
	reg [PARA_DATA_WIDTH-1:0]	Data_vertical  ;
	reg [PARA_DATA_WIDTH-1:0]	Kernel_size    ;
	reg [PARA_DATA_WIDTH-1:0]	Stride         ;

    	always@(posedge clk )begin
		if(!rstn||refresh)begin
          Data_horizontal <=   DATA_HORIZONTAL   ;
          Data_vertical   <=   DATA_VERTICAL   ;
          Kernel_size     <=   KERNEL_SIZE   ;
          Stride          <=   STRIDE   ;
          end
		else begin
          Data_horizontal <=   DATA_horizontal;
          Data_vertical   <=   DATA_vertical ;
          Kernel_size     <=   KERNEL_size  ; 
          Stride          <=   Window_Stride   ;

        end
        end
	
   div_gen_0 VALID_NUM_divider (
  .aclk(clk),                                      // input wire aclk
  .s_axis_divisor_tvalid(1'b1),    // input wire s_axis_divisor_tvalid
  .s_axis_divisor_tdata(Stride),      // input wire [15 : 0] s_axis_divisor_tdata
  .s_axis_dividend_tvalid(1'b1),  // input wire s_axis_dividend_tvalid
  .s_axis_dividend_tdata(VALID_NUM_HORIZONTAL0),    // input wire [15 : 0] s_axis_dividend_tdata
  .m_axis_dout_tvalid(divider_out_valid),          // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(Divider_Out)            // output wire [15 : 0] m_axis_dout_tdata
);
	wire divider_out_valid;
		always@(posedge clk )begin
		if(!rstn||refresh)begin
          VALID_NUM_HORIZONTAL<=0;
          VALID_NUM_HORIZONTAL0<=0;
          VALID_NUM_HORIZONTAL1<=0;
		end
		else begin
		  VALID_NUM_HORIZONTAL0<=Data_horizontal-Kernel_size;
		  if(Stride!=0&&divider_out_valid)
		  begin
		     VALID_NUM_HORIZONTAL1<=Divider_Out[15:8];
		     VALID_NUM_HORIZONTAL<=VALID_NUM_HORIZONTAL1+1;
		  end
		  else begin
		     VALID_NUM_HORIZONTAL <=VALID_NUM_HORIZONTAL;
		     VALID_NUM_HORIZONTAL1<=VALID_NUM_HORIZONTAL1;
		  
		  end
		  
		end
		
	end	
	
	
	
	
	
assign done=state==DONE;
assign last=VALID_NUM_HORIZONTAL>1?(whole_valid_count==VALID_NUM_HORIZONTAL*VALID_NUM_HORIZONTAL):0;
wire [2*PARA_DATA_WIDTH-1:0]	Data_Cache_Size;
wire [2*PARA_DATA_WIDTH-1:0]	Data_Whole_Size;
wire [2*PARA_DATA_WIDTH-1:0]	Data_Complete_Size;
assign Data_Whole_Size=Data_horizontal*Data_vertical;
assign Data_Cache_Size=Data_horizontal*Kernel_size;
assign Data_Complete_Size =Data_Whole_Size+Data_horizontal-Kernel_size;
// ÿ�������أ�����һ�� 
	always@(posedge clk )begin
		if(!rstn||refresh)begin
          out_valid<=0;
		end
		else begin
		  out_valid<=valid;
		end
		
	end	


		genvar i;
	// ÿ�������أ��ɵ������λһ��  
	generate
		for(i=0;i<DATA_HORIZONTAL*KERNEL_SIZE;i=i+1)  
	       always@(posedge clk  )begin:memory
	           	if(!rstn||refresh)begin
                      mem[i] <= 0;
	           	end
	           	else begin
	           	  if(state!==IDLE&&state!=DONE)
	           		begin
						if(i==0)
	           		        mem[i] <= din;  
						else         
	           		   	  mem[i] <= mem[i-1];
	           		end
	           	   else begin
                             mem[i] <= 0;
	           	end
	           	end
	           	
	           end
	endgenerate
	
// �������ݵ����
always @(posedge clk ) begin
  if (!rstn||refresh) begin
	count<=0;
  end else begin
       if(state==IDLE)
	     count<=0;
	    else if(state==START||state==HORIZONTIAL_STRIDE||state==VERTICAL_STRIDE)
		  count<=count+1;
	    else
		  count<=count;
	end
end
// ��ֱ���򲽽����ݵ����
always @(posedge clk ) begin
  if (!rstn||refresh) begin
	vertical_count<=0;
  end else begin
       if(state==VERTICAL_STRIDE)
	     vertical_count<=vertical_count+1;
	    else
		  vertical_count<=0;
	end
end
// ˮƽ���򴫵����ݵ����
always @(posedge clk ) begin
  if (!rstn||refresh) begin
	horizontal_count<=0;
  end else begin
       if(state==HORIZONTIAL_STRIDE)
	     horizontal_count<=horizontal_count<Data_horizontal? horizontal_count+1:1;
	    else
		  horizontal_count<=0;
	end
end
// ˮƽ���򲽽����ݵ����
always @(posedge clk ) begin
  if (!rstn||refresh) begin
	horizontal_stride_count<=0;
  end else begin
       if(state==HORIZONTIAL_STRIDE)
	     horizontal_stride_count<=horizontal_stride_count>=Stride-1 ? 0 : horizontal_stride_count+1;
	    else
		  horizontal_stride_count<=0;
	end
end
wire horizontal_valid;
assign horizontal_valid= horizontal_stride_count==0;

//valid �������
always @(posedge clk ) begin
  if (!rstn||refresh) begin
	valid<=0;
  end else begin
       if(state==HORIZONTIAL_STRIDE)begin
           if(valid_count<VALID_NUM_HORIZONTAL)begin
			  if(horizontal_valid)
			     valid<=1;
			  else 
			      valid<=0;
			end
			else begin
				valid<=0;
			end
	     end
	    else
		  valid<=0;
	end
end










// ״̬�Ĵ�����ʼ��

wire Horizontal_Full_Flag;
wire Hor2Ver_Flag;
assign Hor2Ver_Flag= horizontal_count==Data_horizontal-1;
assign Horizontal_Full_Flag= horizontal_count==Data_horizontal;

wire Vertiacal_Full_Flag;
assign Vertiacal_Full_Flag= vertical_count==(Stride-1)*Data_horizontal-1;
always @(posedge clk ) begin
  if (!rstn||refresh) begin
    state <= IDLE; // ��λʱ״̬ΪIDLE
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
	   if(count==Data_Cache_Size-2)//Data_Cache_Size-1��ʱ���Ǵ�����kernel�Ĵ���
	   begin
		 state<=HORIZONTIAL_STRIDE;
	   end
	   else
	   begin
		 state<=START;
	   end
	 end
	 HORIZONTIAL_STRIDE:begin
        if(count>=Data_Complete_Size)//�в����������������������������ֻʣ���һ��kernel����ʱ�����ܵ����ݸ�������һ�����ݼ�ȥһ��kernel
		begin
			state<=DONE;
		end
		else
		begin
		   if(Hor2Ver_Flag&&Stride>1)//Data_horizontal-1��ʱ���Ѿ�����һ���ˣ�����Ҫ-2
		      begin
		      state<=VERTICAL_STRIDE;
		       end
		    else begin
		      	state<=HORIZONTIAL_STRIDE;
		      	end
		      
		end

	 end
	 VERTICAL_STRIDE:begin		
	   if(count<Data_Whole_Size)//��û�г���ͼƬ
	   begin
         if(Vertiacal_Full_Flag)//��ֱ�����ƶ�ȥ���˲�Ҫ�Ĳ������ݼĴ���
	        begin
		      state<=HORIZONTIAL_STRIDE;
	        end
	     else
	        begin
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
	 end
    default :begin
	 state<=IDLE;
	end
	endcase
  end
end


always @(negedge clk) begin
	if (!rstn||refresh) begin
		valid_count<=0;
		whole_valid_count<=0;
	end
	else begin
		if(state==HORIZONTIAL_STRIDE||state==VERTICAL_STRIDE)
		begin
			    if(Horizontal_Full_Flag)
			         valid_count<=0;
			    else begin
                  //����һ���ж��ٴ�valid
		          if(valid==1)
		            begin
		             valid_count<=valid_count+1;
		             whole_valid_count<=whole_valid_count+1;
		            end
                  else begin
		           valid_count<=valid_count;
		           whole_valid_count<=whole_valid_count;
		            end
					
				end
        
		end
		else
		   begin
		      valid_count<=0;
		       whole_valid_count<=0;
		   end
	end
			
end


genvar j,k;
generate
    for (j = 0; j < KERNEL_SIZE; j=j+1)
    begin: vertical_windowdata
	    for (k =0; k<KERNEL_SIZE; k=k+1)
		begin:horizontal_windowdata
		
		wire [31:0] Index=(j*KERNEL_SIZE+k);
		reg  [31:0] New_Hang=0;
		reg  [31:0] New_Lie=0;
		reg  [31:0] New_Kernel=0;
		reg  [31:0] Diff=0;
		reg  [31:0] New_Num=0;
		always @(posedge clk ) begin
        	if(!rstn||refresh)
        	begin
        		New_Hang<=0;
        		New_Lie<=0;
        		Diff<=0;
        		New_Num<=0;
        		New_Kernel<=0;
        	end
            else begin
               New_Hang<=Index/Kernel_size;
               New_Lie<=Index%Kernel_size;
               Diff<=Kernel_size-New_Hang;
               New_Num<=Diff*Data_horizontal;
               New_Kernel<=Kernel_size*Kernel_size;
            end
            
            end
        always @(posedge clk ) begin
        	if(!rstn||refresh)
        	begin
        		taps[(j*KERNEL_SIZE+k)*Data_width+Data_width-1:(j*KERNEL_SIZE+k)*Data_width]<=0;
        	end
            else begin
			    if((j*KERNEL_SIZE+k)>=New_Kernel)begin
            	  taps[(j*KERNEL_SIZE+k)*Data_width+Data_width-1:(j*KERNEL_SIZE+k)*Data_width]<=0;
		        end else begin
				  taps[(j*KERNEL_SIZE+k)*Data_width+Data_width-1:(j*KERNEL_SIZE+k)*Data_width]<=(valid)?mem[New_Num-New_Lie-1]:0;
				end
				   
			end
      end
   end
end
endgenerate



endmodule









