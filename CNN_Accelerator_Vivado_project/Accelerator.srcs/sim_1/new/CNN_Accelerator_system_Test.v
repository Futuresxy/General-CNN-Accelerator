`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/08 19:25:43
// Design Name: 
// Module Name: CNN_Accelerator_system_Test
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

module CNN_Accelerator_system_Test(

    );
    
    
///////////////////////////////////windows
	// 输入
	reg clk;
	reg rstn;
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
	reg start=1'd0;
	// 计算模式
	parameter IDLE =5'b00000;
    parameter CONV =5'b00001;
    parameter RELU =5'b00010;
    parameter POOL_Max =5'b00100;
    parameter POOL_Mean =5'b00101;
    parameter FULLCON =5'b01000;
    parameter CONV_RELU =5'b10000;
    
    //选择一个模式
    reg [4:0] mode=POOL_Max;
    reg  [7:0]  data_size=28;//读取的数据size
    
    
	parameter KERNEL_SIZE    =5          ; //卷积核心的大小
	parameter RESULT_NUM       =8; 
    parameter RESULT_DATA_WIDTH =32; 
	parameter DATA_HORIZONTAL= 28         ;//输入数据的横向长
	parameter DATA_VERTICAL  = 28         ;//输入数据的纵向长
	parameter STRIDE         = 1          ;//卷积操作窗滑动的步长
	parameter DATA_WIDTH =8;
	parameter S01_AXI_DATA_WIDTH=32;
	parameter S01_AXI_ADDR_WIDTH=32;
	    
	    
	    wire[ DATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0]  outdata;
	    wire  outvalid;
	    wire OUT_DATA_LAST;
	    
	     wire [S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr;
		 wire [2 : 0] s01_axi_awprot;
		 wire  s01_axi_awvalid;
		 wire  s01_axi_awready;
		 wire [S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata;
		 wire [(S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb;
		 wire  s01_axi_wvalid;
		 wire  s01_axi_wready;
		 wire [1 : 0] s01_axi_bresp;
		 wire  s01_axi_bvalid;
		 wire  s01_axi_bready;
		 wire [S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr;
		 wire [2 : 0] s01_axi_arprot;
		 wire  s01_axi_arvalid;
		 wire  s01_axi_arready;
		 wire [S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata;
		 wire [1 : 0] s01_axi_rresp;
		 wire  s01_axi_rvalid;
		 wire  s01_axi_rready;
	    
	// 滑窗模块
	Windows_Data_Convert_v1_0  #
	(
		. KERNEL_SIZE              (KERNEL_SIZE ), // 卷积核心的大小             
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
		.s01_axi_aresetn (   rstn     )            ,                                  
		.s01_axi_awaddr (           ),                                   
		.s01_axi_awprot (           ),                                   
		.s01_axi_awvalid(           ),                                    
		.s01_axi_awready(           ),                                    
		.s01_axi_wdata  (           ),                                  
		.s01_axi_wstrb  (           ),                                  
		.s01_axi_wvalid (           ),                                   
		.s01_axi_wready (           ),                                   
		.s01_axi_bresp  (           ),                                  
		.s01_axi_bvalid (           ),                                   
		.s01_axi_bready (           ),                                   
		.s01_axi_araddr (           ),                                   
		.s01_axi_arprot (           ),                                   
		.s01_axi_arvalid(           ),                                    
		.s01_axi_arready(           ),                                    
		.s01_axi_rdata  (           ),                                  
		.s01_axi_rresp  (           ),                                  
		.s01_axi_rvalid (           ),                                   
		.s01_axi_rready (           ),   
		// Ports of Axi Slave Bus Interface S00_AXIS
		.s00_axis_aclk     ( clk    )    ,
		.s00_axis_aresetn  ( rstn    )     ,
    	.s00_axis_tready   ( pready    )    ,
		.s00_axis_tdata    ( pdata     )    ,
		.s00_axis_tstrb    ( pstrb     )    ,
		.s00_axis_tlast    ( plast     )    ,
		.s00_axis_tvalid   ( pvalid    )   ,

		// Ports of Axi Master Bus Interface M00_AXIS
		.m00_axis_aclk      (  clk          )       ,
		.m00_axis_aresetn   (  rstn        )      ,
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
    wire mmlast;
    wire mmvalid;
    wire  mmready;
	fifo_act  fifo_act_0(
	.s_axis_aclk( clk   ),
	.s_axis_aresetn( rstn ),
	.s_axis_tdata  ( moutdata   ),
	.s_axis_tlast  ( mlast   ),
	.s_axis_tready ( mready   ),
	.s_axis_tstrb(   mstrb         ),
	.s_axis_tkeep(   mkeep    ),
	.s_axis_tvalid ( mvalid   ),
    .m_axis_tdata  ( mmoutdata   ),
	.m_axis_tlast  ( mmlast   ),
	.m_axis_tready (  mmready  ),
	.m_axis_tvalid ( mmvalid   )
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
	.s_axis_aresetn( rstn ),
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
		fp_i = $fopen("E:/Accelerator/CNN_Accelerator_Vivado_project/Accelerator.sim/sim_testdata/2_2.txt","r"); // 28*28卷积激励
		fp_2 = $fopen("E:/Accelerator/CNN_Accelerator_Vivado_project/Accelerator.sim/sim_testdata/fifo_pool_act_28_28.txt","r"); // 池化输入激励
	end
	// 初始信号
	initial
	begin
		cnt_line = 0;// 读取行数清零
		clk = 1;
		data_size=28;
		pplast=0;
		rstn=0;
		# 10;
		rstn=1;
	end
	

	// 读取图像数据，一共 784 行，即 784*20 + 20 = 15700 ns = 15.7 ms 读完一张28*28图片 
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
//	        mmready<=0;
	        pplast<=0;
	        ppvalid  <=0;
//	        start<=0;
	        end
	 else
		begin
		if(ppready ==1)begin
			
			if(cnt_line < data_size*data_size-1) begin
			    cnt_line <= cnt_line + 1; 
			    if(mode==1||mode==5'b10000)
			      count_w  <= $fscanf(fp_i,"%b" ,image_in);
			    else
			     count_w  <= $fscanf(fp_2,"%d" ,image_in);
			     
			     ppvalid<=1;
			     end
			else if(cnt_line == data_size*data_size-1) 
			begin
			    cnt_line <= cnt_line + 1; 			
			     if(mode==1||mode==5'b10000)
			      count_w  <= $fscanf(fp_i,"%b" ,image_in);
			    else
			     count_w  <= $fscanf(fp_2,"%d" ,image_in);		    
			       pplast<=1;
			end// $display("%d,%b",count_w,image_in);
			else if(cnt_line == data_size*data_size) 
			begin
			   pplast<=0;
	           ppvalid  <=0;
	           cnt_line <= cnt_line + 1; 
	           if(mode==1)
			      count_w  <= $fscanf(fp_i,"%b" ,image_in);
			    else
			     count_w  <= $fscanf(fp_2,"%d" ,image_in);	
			end
			else begin
			 if(mode!=5'b01000)
			  start<=1;
			  end
			end
		end
	end
	// 时钟信号 50MHz
	always #10 clk <= ~clk; 



//////////////////////////////////////////////

    //parameter DATA_WIDTH         =8;//数据位宽
    parameter PARA_WIDTH         =8;// 参数位宽
    parameter CONV_KERNEL_SIZE   =5;//卷积核大小长
    parameter CONV_KERNEL_NUM    =8;//卷积核个数
    parameter POOL_KERNEL_SIZE   =5;//池化核大小长
    parameter POOL_KERNEL_NUM    =1;//池化核个数
    parameter FULLCON_INPUT_SIZE =100;//全连接层输入大小
    parameter FULLCON_OUTPUT_SIZE=8;//全连接层输出大小



CNN_Accelerator
#(
    .DATA_WIDTH         (DATA_WIDTH           ),//数据位宽
    .PARA_WIDTH         (PARA_WIDTH           ),// 参数位宽
    .RESULT_NUM         (RESULT_NUM             ),
    .RESULT_DATA_WIDTH  (RESULT_DATA_WIDTH     ), 
    .CONV_KERNEL_SIZE   (CONV_KERNEL_SIZE     ),//卷积核大小长
    .CONV_KERNEL_NUM    (CONV_KERNEL_NUM      ),//卷积核个数
    .POOL_KERNEL_SIZE   (POOL_KERNEL_SIZE     ),//池化核大小长
    .POOL_KERNEL_NUM    (POOL_KERNEL_NUM      ),//池化核个数
    .FULLCON_INPUT_SIZE (FULLCON_INPUT_SIZE   ),//全连接层输入大小
    .FULLCON_OUTPUT_SIZE(FULLCON_OUTPUT_SIZE  )//全连接层输出大小
)CNN_Accelerator_00
(
    .clk                   (      clk             ),                           
    .rstn                  (      rstn             ),                           
    .cnn_start             (      start             ),                                 
    .select_mode           (      mode             ),                                     
    .Conv_Kernel_Size      (      5             ),                                            
    .Conv_Kernel_Num       (      8            ),                                          
    .Pool_Kernel_Size      (      5             ),                                             
    .Pool_Kernel_Num       (       1            ),                                          
    .FULLCON_Input_Size    (       28            ),                                        
    .FULLCON_Output_Size   (       8            ),   
    .scaler                  (  10           ),
    .scalel                  (  0            ),
    .image_tvalid          (mmvalid                   ),                     
    .image_tlast           (mmlast                   ),                    
    .image_tready          (mmready                  ),                     
    .image_tdata           (mmoutdata                   ),                    
    .image_tkeep           (                   ),                    
    .image_tstrb           (                   ),  

    .weight_tvalid         (m1_axis_tvalid     ),                       
    .weight_tlast          (m1_axis_tlast      ),                                           
    .weight_tready         (m1_axis_tready     ),                      
    .weight_tdata          (m1_axis_tdata      ),                     
    .weight_tkeep          (                   ),                     
    .weight_tstrb          (                   ),   

    .weightfc_tvalid       (m2_axis_tvalid     ),                        
    .weightfc_tlast        (m2_axis_tlast      ),                                             
    .weightfc_tready       (m2_axis_tready     ),                        
    .weightfc_tdata        (m2_axis_tdata      ),                       
    .weightfc_tkeep        (                   ),                       
    .weightfc_tstrb        (                   ),    

    .result_tready         (s3_axis_tready     ),                      
    .result_tvalid         (s3_axis_tvalid     ),                      
    .result_tdata          (s3_axis_tdata      ),                     
    .result_tkeep          (s3_axis_tkeep       ),                     
    .result_tstrb          (s3_axis_tstrb        ),  
    .result_tlast          (s3_axis_tlast     ),
    
    .cnn_done              (                   ),                 
    .cnn_cnt               (                   )               
);


    reg    [63:0]s1_axis_tdata ;
    reg          s1_axis_tlast ;
    wire         s1_axis_tready;
    reg          s1_axis_tvalid;

    wire    [63:0]m1_axis_tdata ;
    wire          m1_axis_tlast ;
    wire           m1_axis_tready;
    wire          m1_axis_tvalid;

	fifo_weight  fifo_weight_1(
	.s_axis_aclk   ( clk       ),
	.s_axis_aresetn( rstn      ),
    
	.s_axis_tdata  (s1_axis_tdata ),
	.s_axis_tlast  (s1_axis_tlast ),
	.s_axis_tready (s1_axis_tready),
    .s_axis_tvalid (s1_axis_tvalid),
	// .s_axis_tstrb  (           ),
	
    .m_axis_tdata  (m1_axis_tdata ),
	.m_axis_tlast  (m1_axis_tlast ),
	.m_axis_tready (m1_axis_tready),
    .m_axis_tvalid (m1_axis_tvalid)
	// .m_axis_tstrb  (           ),
	
	);
	
	reg  [7:0] kenerl_size=8'd5;
	// 读取图片数据
	initial
	begin
        fp_1 = $fopen("E:/Accelerator/CNN_Accelerator_Vivado_project/Accelerator.sim/sim_testdata/Conv1_weight.txt","r");
        fp_3 = $fopen("E:/Accelerator/CNN_Accelerator_Vivado_project/Accelerator.sim/sim_testdata/fifo_fc_act.txt","r"); 
	end
    integer count_0,count_1,count_2,count_3,fp_0,fp_1,fp_2,fp_3,fp_fifo,fp_fc_act,fp_fc_weight;
     reg[10:0] cnt_line_0,cnt_line_1,cnt_line_2,cnt_line_3;  
	// ///////////////////////////////////读取权重//////////////////////////////////
	
	reg [7:0]fc_size=28;
	
	
	
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s1_axis_tvalid<=0;
            s1_axis_tlast<=0;
            s1_axis_tdata<=0;
            cnt_line_1<=0;
            kenerl_size<=5;
            fc_size<=28;
            end
	 else
		begin
 if(mode==1||mode==5'b10000)
begin
    if(cnt_line_1<=kenerl_size*kenerl_size)begin        
        if(s1_axis_tready==1)begin
            s1_axis_tvalid <=1;
        	count_1  <= $fscanf(fp_1,"%h" ,s1_axis_tdata);
        	cnt_line_1 <= cnt_line_1 + 1;
        	if(cnt_line_1 == kenerl_size*kenerl_size-1) 
            begin
              s1_axis_tlast<=1;
            end
            else if(cnt_line_1 == kenerl_size*kenerl_size)
        	begin
                s1_axis_tlast<=0;
                s1_axis_tvalid<=0;
        	     $display("weight read over");
        	end
         end
		 end
    else  begin



	end
end
         else if (mode==5'b01000) begin
			if(cnt_line_1<=fc_size)begin
                if(s1_axis_tready==1)begin
                s1_axis_tvalid <=1;
        	    count_1  <= $fscanf(fp_3,"%b" ,s1_axis_tdata);
        	    cnt_line_1 <= cnt_line_1 + 1;
        	    if(cnt_line_1 == fc_size-1) 
                begin
                  s1_axis_tlast<=1;
                end
                else if(cnt_line_1 == fc_size)
        	    begin
                    s1_axis_tlast<=0;
                    s1_axis_tvalid<=0;
        	         $display("weightfc read over");
        	    end
         end  
         end
		 

		 else if (cnt_line_1<100)begin
//		    cnt_line_1 <= cnt_line_1 + 1;
//		    if(cnt_line_1==99)
//		       cnt_line_1<=0;
		 end
            
     end         
          end
	end
	

    reg    [79:0]s2_axis_tdata ;
    reg          s2_axis_tlast ;
    wire         s2_axis_tready;
    reg          s2_axis_tvalid;

    wire    [79:0]m2_axis_tdata ;
    wire          m2_axis_tlast ;
    wire           m2_axis_tready;
    wire          m2_axis_tvalid;

	fifo_weightfc  fifo_weightfc_1(
	.s_axis_aclk   ( clk       ),
	.s_axis_aresetn( rstn      ),
    
	.s_axis_tdata  (s2_axis_tdata ),
	.s_axis_tlast  (s2_axis_tlast ),
	.s_axis_tready (s2_axis_tready),
    .s_axis_tvalid (s2_axis_tvalid),
	// .s_axis_tstrb  (           ),
	
    .m_axis_tdata  (m2_axis_tdata ),
	.m_axis_tlast  (m2_axis_tlast ),
	.m_axis_tready (m2_axis_tready),
    .m_axis_tvalid (m2_axis_tvalid)
	// .m_axis_tstrb  (           ),
	
	);
	///////////////////////////////////////测试全连接层//////////////////////
		// 读取图片数据
	initial
	begin
        fp_fc_weight = $fopen("E:/Accelerator/CNN_Accelerator_Vivado_project/Accelerator.sim/sim_testdata/fifo_fc_weight-1.txt","r"); // 
	end
	
 //全连接层的权重输入
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s2_axis_tvalid<=0;
            s2_axis_tlast<=0;
            s2_axis_tdata<=0;
            cnt_line_2<=0;
            end
	 else
		begin
		if(mode==5'b01000)begin
            if(cnt_line_2<=fc_size)begin
                            
		             if(s2_axis_tready==1)begin
		                    s2_axis_tvalid <=1;
		                	count_2  <= $fscanf(fp_fc_weight,"%b" ,s2_axis_tdata);
		                	cnt_line_2 <= cnt_line_2 + 1;
		                	if(cnt_line_2 == fc_size-1) 
                            begin
                              s2_axis_tlast<=1;
                            end
                            if(cnt_line_2 ==fc_size)
		                	begin
                                s2_axis_tlast<=0;
                                s2_axis_tvalid<=0;
                                
		                	     $display("weight read over");
		                	end// $display("%d,%b",count_w,image_in);
                
                            
		             end
            end
            else begin
                cnt_line_2 <= cnt_line_2 + 1;
                if(cnt_line_2>30)
                   start<=0;
                else
                   start<=1;
            end
         end 
	   end
	end


    wire    [RESULT_NUM*RESULT_DATA_WIDTH-1:0]s3_axis_tdata ;
    wire           s3_axis_tlast ;
    wire          s3_axis_tready;
    wire           s3_axis_tvalid;
    wire   [15:0]   s3_axis_tstrb;
    wire   [15:0]   s3_axis_tkeep;
    wire    [RESULT_NUM*RESULT_DATA_WIDTH-1:0]m3_axis_tdata ;
    wire           m3_axis_tlast ;
    wire            m3_axis_tready;
    wire           m3_axis_tvalid;
	
	
	fifo_result  fifo_result_1(
	.s_axis_aclk   ( clk       ),
	.s_axis_aresetn( rstn      ),
    
	.s_axis_tdata  (s3_axis_tdata ),
	.s_axis_tlast  (s3_axis_tlast ),
	.s_axis_tready (s3_axis_tready),
    .s_axis_tvalid (s3_axis_tvalid),
	.s_axis_tstrb  (s3_axis_tstrb),
	.s_axis_tkeep  (s3_axis_tkeep),
    .m_axis_tdata  (m3_axis_tdata ),
	.m_axis_tlast  (m3_axis_tlast ),
	.m_axis_tready (m3_axis_tready),
    .m_axis_tvalid (m3_axis_tvalid)
	// .m_axis_tstrb  (           ),
	
	);










    
    
    
endmodule
