`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/16 17:16:04
// Design Name: 
// Module Name: CNN_Accelerator_tb
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/10 17:51:23
// Design Name: 
// Module Name: CNN_Accelerator
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

module CNN_Accelerator_tb ();


//////////////////////////////////////////////

    parameter DATA_WIDTH         =8;//数据位宽
    parameter PARA_WIDTH         =8;// 参数位宽
    parameter CONV_KERNEL_SIZE   =4;//卷积核大小长
    parameter CONV_KERNEL_NUM    =4;//卷积核个数
    parameter POOL_KERNEL_SIZE   =2;//池化核大小长
    parameter POOL_KERNEL_NUM    =1;//池化核个数
    parameter FULLCON_INPUT_SIZE =100;//全连接层输入大小
    parameter FULLCON_OUTPUT_SIZE=10;//全连接层输出大小

reg start=1'd0;
reg [4:0] mode=5'd0;

CNN_Accelerator
#(
    .DATA_WIDTH         (DATA_WIDTH           ),//数据位宽
    .PARA_WIDTH         (PARA_WIDTH           ),// 参数位宽
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
    .Conv_Kernel_Size      (      2             ),                                            
    .Conv_Kernel_Num       (      4            ),                                          
    .Pool_Kernel_Size      (      2             ),                                             
    .Pool_Kernel_Num       (       1            ),                                          
    .FULLCON_Input_Size    (       28            ),                                        
    .FULLCON_Output_Size   (       10            ),   

    .image_tvalid          (m0_axis_tvalid                   ),                     
    .image_tlast           (m0_axis_tlast                   ),                    
    .image_tready          (m0_axis_tready                  ),                     
    .image_tdata           (m0_axis_tdata                   ),                    
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
    .result_tvalid         (     ),                      
    .result_tdata          (      ),                     
    .result_tkeep          (                   ),                     
    .result_tstrb          (                   ),  

    .cnn_done              (                   ),                 
    .cnn_cnt               (                   )               
);
reg clk,rstn;
	// 读取图片数据
	initial
	begin
		fp_0 = $fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_0.txt","r"); // 数字 3
        fp_1 = $fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_1.txt","r"); // 数字 3
        fp_2 = $fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_2.txt","r"); // 数字 3
        fp_fifo=$fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_pool.txt","r"); 
       fp_fc_act =$fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_fc_act.txt","r");
       fp_fc_weight =$fopen("E:/Accelerator_Design/cnn_accelerator-main/rtl/accelerator_testbench/fifo_fc_weight.txt","r");
        mode<=5'd1;
        start<=0;
	end
	// 初始信号
	initial
	begin
		clk = 1;
		rstn=0;

		# 10;
		rstn=1;

	end
	reg  mmready;
    integer count_0,count_1,count_2,count_3,fp_0,fp_1,fp_2,fp_3,fp_fifo,fp_fc_act,fp_fc_weight;
     reg[10:0] cnt_line_0,cnt_line_1,cnt_line_2,cnt_line_3;  






/*测试卷积模块
	// 读取图像数据，一共 12行  一行有效数据为4个 8bit
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s0_axis_tvalid<=0;
            s0_axis_tlast<=0;
            s0_axis_tdata<=0;
            cnt_line_0<=0;
            end
	 else
		begin
            if(cnt_line_0<=12)begin
                        
		                if(s0_axis_tready==1)begin
		                       s0_axis_tvalid <=1;
		                	cnt_line_0  <= $fscanf(fp_0,"%h" ,s0_axis_tdata);
		                	cnt_line_0 <= cnt_line_0 + 1;
		                	if(cnt_line_0 == 11'd11) 
                            begin
                              s0_axis_tlast<=1;
                            end
                            if(cnt_line_0 == 11'd12)
		                	begin
                                s0_axis_tlast<=0;
                                s0_axis_tvalid<=0;
                                
		                	     $display("picture act read over");
		                	end// $display("%d,%b",count_w,image_in);
		                	end
                            end
            else if(cnt_line_0>12&&cnt_line_0<50)begin
//                 m0_axis_tready<=1;
                     cnt_line_0 <= cnt_line_0 + 1;
                   if(cnt_line_0<14&&cnt_line_0>12)
                         start<=1;
                   else
                      start<=0;
			end
			else if(cnt_line_0>=50&&cnt_line_0<=54)begin
			             if(s0_axis_tready==1)begin
		                       s0_axis_tvalid <=1;
		                	cnt_line_0  <= $fscanf(fp_2,"%h" ,s0_axis_tdata);
		                	cnt_line_0 <= cnt_line_0 + 1;
		                	if(cnt_line_0 == 11'd53) 
                            begin
                              s0_axis_tlast<=1;
                            end
                            if(cnt_line_0 == 11'd54)
		                	begin
                                s0_axis_tlast<=0;
                                s0_axis_tvalid<=0;
                                
		                	     $display("picture act read over");
		                	end// $display("%d,%b",count_w,image_in);
		                	end
			end
		  else if(cnt_line_0>54&&cnt_line_0<=60)begin
//                 m0_axis_tready<=1;
                     cnt_line_0 <= cnt_line_0 + 1;
                   if(cnt_line_0<56&&cnt_line_0>54)
                         start<=1;
                   else
                      start<=0;
			end
			
			
		end
	end



	// ///////////////////////////////////读取权重//////////////////////////////////
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s1_axis_tvalid<=0;
            s1_axis_tlast<=0;
            s1_axis_tdata<=0;
            cnt_line_1<=0;
            end
	 else
		begin


            if(cnt_line_1<=4)begin
                            
		             if(s1_axis_tready==1)begin
		                    s1_axis_tvalid <=1;
		                	count_1  <= $fscanf(fp_1,"%h" ,s1_axis_tdata);
		                	cnt_line_1 <= cnt_line_1 + 1;
		                	if(cnt_line_1 == 11'd3) 
                            begin
                              s1_axis_tlast<=1;
                            end
                            if(cnt_line_1 == 11'd4)
		                	begin
                                s1_axis_tlast<=0;
                                s1_axis_tvalid<=0;
                                
		                	     $display("weight read over");
		                	end// $display("%d,%b",count_w,image_in);
                
                            
		             end
            end
//        if(cnt_line_1>4) 
//                 m1_axis_tready<=1;
			end
	end
*/











/*
//测试池化模块
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s0_axis_tvalid<=0;
            s0_axis_tlast<=0;
            s0_axis_tdata<=0;
            cnt_line_0<=0;
            end
	 else
		begin
            if(cnt_line_0<=12)begin
                        
		                if(s0_axis_tready==1)begin
		                       s0_axis_tvalid <=1;
		                	cnt_line_0  <= $fscanf(fp_fifo,"%h" ,s0_axis_tdata);
		                	cnt_line_0 <= cnt_line_0 + 1;
		                	if(cnt_line_0 == 11'd11) 
                            begin
                              s0_axis_tlast<=1;
                            end
                            if(cnt_line_0 == 11'd12)
		                	begin
                                s0_axis_tlast<=0;
                                s0_axis_tvalid<=0;
                                mode<=5'b00100;
		                	     $display("picture act read over");
		                	end// $display("%d,%b",count_w,image_in);
		                	end
                            end
            else if(cnt_line_0>12&&cnt_line_0<50)begin
//                 m0_axis_tready<=1;
                         
                     cnt_line_0 <= cnt_line_0 + 1;
                   if(cnt_line_0<24&&cnt_line_0>12)
                         start<=1;
                   else  begin
                      start<=0;

                      end
                      
			end
			
			else if(cnt_line_0>=50&&cnt_line_0<=62)begin
			             if(s0_axis_tready==1)begin
		                       s0_axis_tvalid <=1;
		                	cnt_line_0  <= $fscanf(fp_2,"%h" ,s0_axis_tdata);
		                	cnt_line_0 <= cnt_line_0 + 1;
		                	if(cnt_line_0 == 11'd61) 
                            begin
                              s0_axis_tlast<=1;
                            end
                            if(cnt_line_0 == 11'd62)
		                	begin
                                s0_axis_tlast<=0;
                                s0_axis_tvalid<=0;
                                mode<=5'b00101;
		                	     $display("picture act read over");
		                	end
		                	end
			end
		  else if(cnt_line_0>62&&cnt_line_0<80)begin
                     cnt_line_0 <= cnt_line_0 + 1;
                   if(cnt_line_0<70&&cnt_line_0>63)
                         start<=1;
                   else
                      start<=0;
			end
		else  begin
		
		
		end
		 
end
end

*/
///////////////////////////////////////测试全连接层//////////////////////
   //全连接层的激励输入
	always@(posedge clk  or negedge rstn)
	begin
	      if(!rstn)begin
	        s1_axis_tvalid<=0;
            s1_axis_tlast<=0;
            s1_axis_tdata<=0;
            cnt_line_1<=0;
            end
	 else
		begin
            if(cnt_line_1<=28)begin
                            
		             if(s1_axis_tready==1)begin
		                    s1_axis_tvalid <=1;
		                	count_3  <= $fscanf(fp_fc_act,"%b" ,s1_axis_tdata);
		                	cnt_line_1 <= cnt_line_1 + 1;
		                	if(cnt_line_1 == 11'd27) 
                            begin
                              s1_axis_tlast<=1;
                            end
                            if(cnt_line_1 == 11'd28)
		                	begin
                                s1_axis_tlast<=0;
                                s1_axis_tvalid<=0;
                                mode<=5'b01000;
		                	     $display("fc_act read over");
		                	end// $display("%d,%b",count_w,image_in);
                
                            
		             end
            end

			end
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
            if(cnt_line_2<=28)begin
                            
		             if(s2_axis_tready==1)begin
		                    s2_axis_tvalid <=1;
		                	count_2  <= $fscanf(fp_fc_weight,"%b" ,s2_axis_tdata);
		                	cnt_line_2 <= cnt_line_2 + 1;
		                	if(cnt_line_2 == 11'd27) 
                            begin
                              s2_axis_tlast<=1;
                            end
                            if(cnt_line_2 == 11'd28)
		                	begin
                                s2_axis_tlast<=0;
                                s2_axis_tvalid<=0;
                                
		                	     $display("weight read over");
		                	end// $display("%d,%b",count_w,image_in);
                
                            
		             end
            end
            else begin
                cnt_line_2 <= cnt_line_2 + 1;
                if(start>50)
                   start<=0;
                else
                   start<=1;
            
            end

			end
	end



	// 时钟信号 100MHz
	always #5 clk <= ~clk; 

    reg    [127:0]s0_axis_tdata ;
    reg           s0_axis_tlast ;
    wire           s0_axis_tready;
    reg           s0_axis_tvalid;

    wire   [127:0]m0_axis_tdata ;
    wire          m0_axis_tlast ;
    wire           m0_axis_tready;
    wire          m0_axis_tvalid;


	axis_data_fifo_0  fifo_act(
	.s_axis_aclk   ( clk       ),
	.s_axis_aresetn( rstn      ),

	.s_axis_tdata  (s0_axis_tdata ),
	.s_axis_tlast  (s0_axis_tlast ),
	.s_axis_tready (s0_axis_tready),
    .s_axis_tvalid (s0_axis_tvalid),
	// .s_axis_tstrb  (           ),
	
    .m_axis_tdata  (m0_axis_tdata ),
	.m_axis_tlast  (m0_axis_tlast ),
	.m_axis_tready (m0_axis_tready),
    .m_axis_tvalid (m0_axis_tvalid)
	// .m_axis_tstrb  (           ),
	
	);

    reg    [31:0]s1_axis_tdata ;
    reg          s1_axis_tlast ;
    wire         s1_axis_tready;
    reg          s1_axis_tvalid;

    wire    [31:0]m1_axis_tdata ;
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
    reg    [127:0]s3_axis_tdata ;
    reg           s3_axis_tlast ;
    wire          s3_axis_tready;
    reg           s3_axis_tvalid;

    wire    [127:0]m3_axis_tdata ;
    wire           m3_axis_tlast ;
    reg            m3_axis_tready;
    wire           m3_axis_tvalid;
	fifo_result  fifo_result_1(
	.s_axis_aclk   ( clk       ),
	.s_axis_aresetn( rstn      ),
    
	.s_axis_tdata  (s3_axis_tdata ),
	.s_axis_tlast  (s3_axis_tlast ),
	.s_axis_tready (s3_axis_tready),
    .s_axis_tvalid (s3_axis_tvalid),
	// .s_axis_tstrb  (           ),
	
    .m_axis_tdata  (m3_axis_tdata ),
	.m_axis_tlast  (m3_axis_tlast ),
	.m_axis_tready (m3_axis_tready),
    .m_axis_tvalid (m3_axis_tvalid)
	// .m_axis_tstrb  (           ),
	
	);

endmodule

