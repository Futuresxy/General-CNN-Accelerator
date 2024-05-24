`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/06 16:16:40
// Design Name: 
// Module Name: axis_windows_tb
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


module axis_windows_tb(

    );
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
	wire ready;
	
		parameter KERNEL_SIZE    = 4          ; //卷积核心的大小
		parameter DATA_HORIZONTAL= 18         ;//输入数据的横向长
		parameter DATA_VERTICAL  = 18         ;//输入数据的纵向长
		parameter STRIDE         = 2          ;//卷积操作窗滑动的步长
	    parameter DATA_WIDTH =8;
	    
	    
	    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  outdata;
	    wire  outvalid;
	    wire OUT_DATA_LAST;
	// 滑窗模块
	Windows_Data_Convert_v1_0  #
	(
		. KERNEL_SIZE              (KERNEL_SIZE ), // 卷积核心的大小 4x4              
		. DATA_HORIZONTAL          (DATA_HORIZONTAL),//输入数据的横向长
		. DATA_VERTICAL            (DATA_VERTICAL),//输入数据的纵向长
		. STRIDE                   (STRIDE ),//卷积操作窗滑动的步长  
		.PARA_DATA_WIDTH	    ( 8 )  ,
		.C_S01_AXI_DATA_WIDTH	( 32),
		.C_S01_AXI_ADDR_WIDTH	( 5),
        .AXIS_TDATA_WIDTH	    ( 8)
    )   test_aix_windows
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S01_AXI
		.s01_axi_aclk    (   clk     )        ,
		.s01_axi_aresetn (   resetn     )            ,

		// Ports of Axi Slave Bus Interface S00_AXIS
		.s00_axis_aclk     ( clk    )    ,
		.s00_axis_aresetn  ( resetn    )     ,
    	.s00_axis_tready   ( pready    )    ,
		.s00_axis_tdata    ( pdata     )    ,
		.s00_axis_tstrb    ( pstrb     )    ,
		.s00_axis_tlast    ( plast     )    ,
		.s00_axis_tvalid   ( pvalid    )   ,

		// Ports of Axi Master Bus Interface M00_AXIS
		.m00_axis_aclk      (  clk          )       ,
		.m00_axis_aresetn   (  resetn        )      ,
		.m00_axis_tvalid    (    mvalid         )      ,
		.m00_axis_tdata     (    moutdata          )   ,
		.m00_axis_tstrb     (    mstrb          )       ,
		.m00_axis_tkeep     (    mkeep          )       ,
		.m00_axis_tlast     (    mlast          )     ,
		.m00_axis_tready    (    mready         )        
	);
	
	
	wire mlast;
	wire mready;
	wire mvalid;
	wire [KERNEL_SIZE*KERNEL_SIZE-1:0]mstrb;
	wire [KERNEL_SIZE*KERNEL_SIZE-1:0]mkeep;
    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  moutdata;	 
    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  mmoutdata;
    
	axis_data_fifo_0  fifo1(
	.s_axis_aclk( clk   ),
	.s_axis_aresetn( resetn ),
	.s_axis_tdata  ( moutdata   ),
	.s_axis_tlast  ( mlast   ),
	.s_axis_tready ( mready   ),
	.s_axis_tstrb(   mstrb         ),
	.s_axis_tkeep(   mkeep    ),
	.s_axis_tvalid ( mvalid   ),
    .m_axis_tdata  ( mmoutdata   ),
	.m_axis_tlast  (    ),
	.m_axis_tready (  mmready  ),
	.m_axis_tvalid (    )
	);
	
	wire ppready;
	reg ppvalid;
	reg pplast;
	
	wire plast;
	wire pready;
	wire pvalid;
	reg  preadgy;
	wire [KERNEL_SIZE*KERNEL_SIZE-1:0]mstrb;	
	wire[ DATA_WIDTH-1:0]  pdata;	 
	picture_fifo_0  fifo0(
	.s_axis_aclk( clk   ),
	.s_axis_aresetn( resetn ),
	.s_axis_tdata  (  image_in      ),
	.s_axis_tlast  (  pplast      ),
	.s_axis_tready ( ppready    ),
	.s_axis_tvalid ( ppvalid   ),
    .m_axis_tdata  ( pdata   ),
	.m_axis_tlast  ( plast   ),
	.m_axis_tready ( pready  ),
	.m_axis_tvalid ( pvalid    )
	);
	
	
	
	
	// 读取图片数据
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/18_18_4.txt","r"); // 数字 3
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		pplast=0;
		resetn=0;
		# 10;
		resetn=1;
	end
	reg  mmready;

	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk  or negedge resetn)
	begin
	      if(!resetn)begin
	        mmready<=0;
	        pplast<=0;
	        ppvalid  <=0;
	        end
	 else
		begin
		if(ppready ==1)begin
			count_w  <= $fscanf(fp_i,"%d" ,image_in);
			
			cnt_line <= cnt_line + 1;
			if(cnt_line < 11'd322)  
			     ppvalid<=1;
			else if(cnt_line == 11'd322) 
			begin
			      pplast<=1;
			end// $display("%d,%b",count_w,image_in);
			else if(cnt_line == 11'd323) 
			begin
			   pplast<=0;
	          ppvalid  <=0;
			end
			else
			   mmready<=1;
			end
		end
	end
	reg read_en;
	wire [9:0] data_count;
	wire [31:0] data_out;
	wire  full,empty;
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
endmodule










/*
module axis_windows_tb(

    );
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
	wire ready;
	
		parameter KERNEL_SIZE    = 4          ; //卷积核心的大小
		parameter DATA_HORIZONTAL= 28         ;//输入数据的横向长
		parameter DATA_VERTICAL  = 28         ;//输入数据的纵向长
		parameter STRIDE         = 1          ;//卷积操作窗滑动的步长
	    parameter DATA_WIDTH =8;
	    
	    
	    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  outdata;
	    wire  outvalid;
	    wire OUT_DATA_LAST;
	// 滑窗模块
	Windows_Data_Convert_v1_0_S00_AXIS #
	(

		. KERNEL_SIZE              (KERNEL_SIZE ), // 卷积核心的大小 4x4              
		. DATA_HORIZONTAL          (DATA_HORIZONTAL),//输入数据的横向长
		. DATA_VERTICAL            (DATA_VERTICAL),//输入数据的纵向长
		. STRIDE                   (STRIDE ),//卷积操作窗滑动的步长  
		. C_S_AXIS_PARA_DATA_WIDTH (DATA_WIDTH ),
		. C_S_AXIS_TDATA_WIDTH	   (DATA_WIDTH)
	)  window1
	(
		// Users to add ports here
		.Data_horizontal (  8'd18   )        ,
		.Data_vertical   (  8'd18   )      ,
		.Kernel_size     (  8'd3   )       ,
		.Stride          (  8'd2   )       ,
		.Refresh         (  1'd0   )        ,
		.OUT_WINDOW_DATA (  outdata   )           ,
		.OUT_DATA_VALID(    outvalid    )          ,
		.OUT_DATA_LAST(OUT_DATA_LAST),
		.S_AXIS_ACLK     (  clk   )        ,
		.S_AXIS_ARESETN  (  resetn   )        ,
		.S_AXIS_TREADY   (  ready   )           ,
		.S_AXIS_TDATA    (  image_in   )      ,
		.S_AXIS_TSTRB    (     )      ,
		.S_AXIS_TLAST    (     )         ,
		.S_AXIS_TVALID   (  start_window   )
	);
	// Instantiation of Axi Bus Interface M00_AXIS
	Windows_Data_Convert_v1_0_M00_AXIS # ( 
	    .KERNEL_SIZE(KERNEL_SIZE),
	    .C_M_AXIS_PARA_DATA_WIDTH( DATA_WIDTH  ),
		.C_M_AXIS_TDATA_WIDTH(DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE)
	) Windows (
	    .Kernel_size( 2 ),
	    .OUT_WINDOW_DATA(outdata),
	    .OUT_DATA_VALID (outvalid),
	    .OUT_DATA_LAST(OUT_DATA_LAST),
		.M_AXIS_ACLK(clk),
		.M_AXIS_ARESETN(resetn),
		.M_AXIS_TVALID( mvalid   ),
		.M_AXIS_TDATA( moutdata     ),
		.M_AXIS_TSTRB( mstrb     ),
		.M_AXIS_TLAST(  mlast    ),
		.M_AXIS_TREADY( mready     )
	);
	wire mlast;
	wire mready;
	wire mvalid;
	wire [KERNEL_SIZE*KERNEL_SIZE-1:0]mstrb;
    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  moutdata;	 
    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  mmoutdata;
    
	axis_data_fifo_0  fifo1(
	.s_axis_aclk( clk   ),
	.s_axis_aresetn( resetn ),
	.s_axis_tdata  ( moutdata   ),
	.s_axis_tlast  ( mlast   ),
	.s_axis_tready ( mready   ),
//	.s_axis_tstrb  ( mstrb   ),
	.s_axis_tvalid ( mvalid   ),
    .m_axis_tdata  ( mmoutdata   ),
	.m_axis_tlast  (    ),
	.m_axis_tready (  mmready  ),
//	.m_axis_tstrb  (       ),
	.m_axis_tvalid (    )
	);
	
	wire plast;
	wire pready;
	wire pvalid;
	reg  preadgy;
	wire [KERNEL_SIZE*KERNEL_SIZE-1:0]mstrb;
    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  poutdata;	 
	picture_fifo_0  fifo0(
	.s_axis_aclk( clk   ),
	.s_axis_aresetn( resetn ),
	.s_axis_tdata  ( moutdata   ),
	.s_axis_tlast  ( mlast   ),
	.s_axis_tready ( mready   ),
//	.s_axis_tstrb  ( mstrb   ),
	.s_axis_tvalid ( pvalid   ),
    .m_axis_tdata  ( poutdata   ),
	.m_axis_tlast  ( plast   ),
	.m_axis_tready (  mmready  ),
//	.m_axis_tstrb  (       ),
	.m_axis_tvalid (    )
	);
	
	
	
	
	// 读取图片数据
	initial
	begin
		fp_i = $fopen("E:/Accelerator_Design/cnn_accelerator-main/sim/cnn_test/18_18_4.txt","r"); // 数字 3
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
		count_w  <= $fscanf(fp_i,"%d" ,image_in);
		# 10;
		resetn=1;
		# 10;
		start_window = 1;
	end
	reg  mmready;
	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk  or negedge resetn)
	begin
	      if(!resetn)
	        mmready<=0;
	 else
		begin
		if(mlast==1)
		   mmready<=1;
		if(start_window==1&&ready==1)begin
			count_w  <= $fscanf(fp_i,"%d" ,image_in);
			cnt_line <= cnt_line + 1;
			if(cnt_line == 11'd323) 
			begin
			     $display("picture read over");
			     start_window <= 0;
			     read_en<=1;
			end// $display("%d,%b",count_w,image_in);
			end
		end
	end
	reg read_en;
	wire [9:0] data_count;
	wire [31:0] data_out;
	wire  full,empty;
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 
endmodule

*/

