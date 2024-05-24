//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/11 18:13:12
// Design Name: 
// Module Name: CNN_Control
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

	module CNN_Control #
	(
		// Users to add parameters here
		    parameter DATA_WIDTH=8,
		    parameter PARA_WIDTH=8,
		    parameter RESULT_NUM         =12, 
            parameter RESULT_DATA_WIDTH =32, 
    	    parameter CONV_KERNEL_SIZE   =2,
    	    parameter CONV_KERNEL_NUM    =4,
    	    parameter POOL_KERNEL_SIZE   =2,
    	    parameter POOL_KERNEL_NUM    =1,
    	    parameter FULLCON_INPUT_SIZE =100,
    	    parameter FULLCON_OUTPUT_SIZE=8,
    	    parameter SCALE_RIGHT =10,
    	    parameter SCALE_LEFT=0,
		// User parameters ends
		// Do not modify the parameters beyond this line

		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 8
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

        input wire image_tvalid,
        input wire image_tlast,
        output wire image_tready,
        input wire signed [CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH-1:0] image_tdata,
        input wire [(CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH/8)-1 : 0] image_tkeep,
        input wire [(CONV_KERNEL_SIZE*CONV_KERNEL_SIZE*DATA_WIDTH/8)-1 : 0] image_tstrb,
        
        input wire weight_tvalid, 
        input wire weight_tlast,                      
        output wire weight_tready,
        input wire signed [CONV_KERNEL_NUM*DATA_WIDTH-1:0] weight_tdata,
        input wire [(CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] weight_tkeep,
        input wire [(CONV_KERNEL_NUM*DATA_WIDTH/8)-1 : 0] weight_tstrb,
        
        input wire weightfc_tvalid,
        input wire weightfc_tlast,                      
        output wire weightfc_tready,
        input wire signed [FULLCON_OUTPUT_SIZE*DATA_WIDTH-1:0] weightfc_tdata,
        input wire [(FULLCON_OUTPUT_SIZE*DATA_WIDTH/8)-1 : 0] weightfc_tkeep,
        input wire [(FULLCON_OUTPUT_SIZE*DATA_WIDTH/8)-1 : 0] weightfc_tstrb,
        
        input wire result_tready,
        output wire result_tvalid,
        output wire result_tlast,
        output wire signed [RESULT_NUM*RESULT_DATA_WIDTH-1:0] result_tdata,
        output wire [(RESULT_NUM*RESULT_DATA_WIDTH/8)-1 : 0] result_tkeep,
        output wire [(RESULT_NUM*RESULT_DATA_WIDTH/8)-1 : 0] result_tstrb,
        
        output wire cnn_done,
        output wire [3:0]cnn_cnt




	);


wire    CNN_Start;
wire  [4:0] Select_Mode;
    
wire  [ PARA_WIDTH-1  :    0  ]	 Conv_Kernel_Size   ;
wire  [ PARA_WIDTH-1  :    0  ]	 Conv_Kernel_Num    ;
wire  [ PARA_WIDTH-1  :    0  ]	 Pool_Kernel_Size   ;
wire  [ PARA_WIDTH-1  :    0  ]	 Pool_Kernel_Num    ;
wire  [ PARA_WIDTH-1  :    0  ]	 FULLCON_Input_Size ;
wire  [ PARA_WIDTH-1  :    0  ]	 FULLCON_Output_Size;
wire  [ PARA_WIDTH-1  :    0  ]	 scaler;
wire  [ PARA_WIDTH-1  :    0  ]	 scalel;
// Instantiation of Axi Bus Interface S00_AXI
	CNN_Control_v1_0_S00_AXI # ( 
		.CONV_KERNEL_SIZE   (CONV_KERNEL_SIZE   ),
		.CONV_KERNEL_NUM    (CONV_KERNEL_NUM    ),
		.POOL_KERNEL_SIZE   (POOL_KERNEL_SIZE   ),
		.POOL_KERNEL_NUM    (POOL_KERNEL_NUM    ),
		.FULLCON_INPUT_SIZE (FULLCON_INPUT_SIZE ),
		.FULLCON_OUTPUT_SIZE(FULLCON_OUTPUT_SIZE),
		.SCALE_RIGHT(SCALE_RIGHT),
		.SCALE_LEFT(SCALE_LEFT),
		.PARA_WIDTH         (PARA_WIDTH    ) ,
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) CNN_Control_v1_0_S00_AXI_inst (
		.Conv_Kernel_Size   ( Conv_Kernel_Size     ),
		.Conv_Kernel_Num    ( Conv_Kernel_Num      ),
		.Pool_Kernel_Size   ( Pool_Kernel_Size     ),
		.Pool_Kernel_Num    ( Pool_Kernel_Num      ),
		.FULLCON_Input_Size ( FULLCON_Input_Size   ),
		.FULLCON_Output_Size( FULLCON_Output_Size  ),
        .cnn_start          (  CNN_Start            ),
        .select_mode        (  Select_Mode          ),
        .scaler(scaler),
        .scalel(scalel),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);




CNN_Accelerator #(
    .DATA_WIDTH         (DATA_WIDTH              ),//数据位宽
    .PARA_WIDTH         (PARA_WIDTH    ) ,
    .RESULT_NUM        (RESULT_NUM), 
    .RESULT_DATA_WIDTH (RESULT_DATA_WIDTH), 
    .CONV_KERNEL_SIZE   (CONV_KERNEL_SIZE        ),//卷积核大小长
    .CONV_KERNEL_NUM    (CONV_KERNEL_NUM         ),//卷积核个数
    .POOL_KERNEL_SIZE   (POOL_KERNEL_SIZE        ),//池化核大小长
    .POOL_KERNEL_NUM    (POOL_KERNEL_NUM         ),//池化核个数
    .FULLCON_INPUT_SIZE (FULLCON_INPUT_SIZE      )    ,//全连接层输入大小
    .FULLCON_OUTPUT_SIZE(FULLCON_OUTPUT_SIZE     )    //全连接层输出大小
)CNN_Accelerator_0
(
    .clk            (s00_axi_aclk            ),
    .rstn           (s00_axi_aresetn         ),
    .cnn_start          (  CNN_Start            ),
    .select_mode    (Select_Mode             ),//00000 :idel  00001:conv 00010:relu 00100:pool 01000fullcon 10000:conv+relu
    .Conv_Kernel_Size   ( Conv_Kernel_Size     ),
	.Conv_Kernel_Num    ( Conv_Kernel_Num      ),
	.Pool_Kernel_Size   ( Pool_Kernel_Size     ),
	.Pool_Kernel_Num    ( Pool_Kernel_Num      ),
	.FULLCON_Input_Size ( FULLCON_Input_Size   ),
	.FULLCON_Output_Size( FULLCON_Output_Size  ),
	.scaler(scaler),
	.scalel(scalel),
    .image_tvalid   (image_tvalid            ),
    .image_tlast    (image_tlast             ),
    .image_tready   (image_tready            ),
    .image_tdata    (image_tdata             ),
    .image_tkeep    (image_tkeep             ),
    .image_tstrb    (image_tstrb             ), 

    .weight_tvalid  (weight_tvalid           ), 
    .weight_tlast   (weight_tlast            ),                      
    .weight_tready  (weight_tready           ),
    .weight_tdata   (weight_tdata            ),  
    .weight_tkeep   (weight_tkeep            ),
    .weight_tstrb   (weight_tstrb            ),   

    .weightfc_tvalid(weightfc_tvalid         ),
    .weightfc_tlast (weightfc_tlast          ),                      
    .weightfc_tready(weightfc_tready         ),
    .weightfc_tdata (weightfc_tdata          ),
    .weightfc_tkeep (weightfc_tkeep          ),
    .weightfc_tstrb (weightfc_tstrb          ),     

    .result_tready  (result_tready           ),
    .result_tvalid  (result_tvalid           ),
    .result_tdata   (result_tdata            ),
    .result_tkeep   (result_tkeep            ),
    .result_tstrb   (result_tstrb            ), 
    .result_tlast   (result_tlast           ),
    .cnn_done       (cnn_done                 ),
    .cnn_cnt        (cnn_cnt                 )       
);




	// Add user logic here

	// User logic ends

	endmodule

