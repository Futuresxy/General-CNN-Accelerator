
`timescale 1 ns / 1 ps

	module Windows_Data_Convert_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		parameter KERNEL_SIZE    = 4          ,//卷积核心的大小
		parameter DATA_HORIZONTAL= 28          ,//输入数据的横向长
		parameter DATA_VERTICAL  = 28          ,//输入数据的纵向长
		parameter STRIDE         = 1          , //卷积操作窗滑动的步长
		parameter  PARA_DATA_WIDTH	= 8   ,
		// Parameters of Axi Slave Bus Interface S01_AXI
		//PRAMETER DATA WIDTH
		parameter integer C_S01_AXI_DATA_WIDTH	= 32,
		parameter integer C_S01_AXI_ADDR_WIDTH	= 5,

		// Parameters of Axi Slave Bus Interface S00_AXIS  MOO_AXIS
		parameter integer       AXIS_TDATA_WIDTH	= 8
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S01_AXI
		input wire  s01_axi_aclk,
		input wire  s01_axi_aresetn,
		input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
		input wire [2 : 0] s01_axi_awprot,
		input wire  s01_axi_awvalid,
		output wire  s01_axi_awready,
		input wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
		input wire [(C_S01_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
		input wire  s01_axi_wvalid,
		output wire  s01_axi_wready,
		output wire [1 : 0] s01_axi_bresp,
		output wire  s01_axi_bvalid,
		input wire  s01_axi_bready,
		input wire [C_S01_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
		input wire [2 : 0] s01_axi_arprot,
		input wire  s01_axi_arvalid,
		output wire  s01_axi_arready,
		output wire [C_S01_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
		output wire [1 : 0] s01_axi_rresp,
		output wire  s01_axi_rvalid,
		input wire  s01_axi_rready,

		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
		input wire [(AXIS_TDATA_WIDTH/8)-1 : 0] s00_axis_tstrb,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1 : 0] m00_axis_tdata,
		output wire [(AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE/8)-1 : 0] m00_axis_tstrb,
		output wire [(AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE/8)-1 : 0] m00_axis_tkeep,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
	);
	wire [PARA_DATA_WIDTH-1:0]	Data_horizontal;
	wire [PARA_DATA_WIDTH-1:0]	Data_vertical;
	wire [PARA_DATA_WIDTH-1:0]	Kernel_size;
	wire [PARA_DATA_WIDTH-1:0]	Stride;
	wire                            Refresh;
	//wire                            Start_Window;
	
	
// Instantiation of Axi Bus Interface S01_AXI
	Windows_Data_Convert_v1_0_S01_AXI # ( 
	    .KERNEL_SIZE    (   KERNEL_SIZE       ),
	    .DATA_HORIZONTAL(   DATA_HORIZONTAL   ),
	    .DATA_VERTICAL  (   DATA_VERTICAL     ),
	    .STRIDE         (   STRIDE            ),
	    .PARA_DATA_WIDTH(  PARA_DATA_WIDTH      ),
		.C_S_AXI_DATA_WIDTH(C_S01_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S01_AXI_ADDR_WIDTH)
	) Windows_Data_Convert_v1_0_S01_AXI_inst (
	    .Data_horizontal(Data_horizontal),
	    .Data_vertical  (Data_vertical  ),
	    .Kernel_size    (Kernel_size    ),
	    .Stride         (Stride         ),
	    .Refresh         (Refresh       ),
	   // .Start_Window    (Start_Window),
		.S_AXI_ACLK(s01_axi_aclk),
		.S_AXI_ARESETN(s01_axi_aresetn),
		.S_AXI_AWADDR(s01_axi_awaddr),
		.S_AXI_AWPROT(s01_axi_awprot),
		.S_AXI_AWVALID(s01_axi_awvalid),
		.S_AXI_AWREADY(s01_axi_awready),
		.S_AXI_WDATA(s01_axi_wdata),
		.S_AXI_WSTRB(s01_axi_wstrb),
		.S_AXI_WVALID(s01_axi_wvalid),
		.S_AXI_WREADY(s01_axi_wready),
		.S_AXI_BRESP(s01_axi_bresp),
		.S_AXI_BVALID(s01_axi_bvalid),
		.S_AXI_BREADY(s01_axi_bready),
		.S_AXI_ARADDR(s01_axi_araddr),
		.S_AXI_ARPROT(s01_axi_arprot),
		.S_AXI_ARVALID(s01_axi_arvalid),
		.S_AXI_ARREADY(s01_axi_arready),
		.S_AXI_RDATA(s01_axi_rdata),
		.S_AXI_RRESP(s01_axi_rresp),
		.S_AXI_RVALID(s01_axi_rvalid),
		.S_AXI_RREADY(s01_axi_rready)
	);
		wire [AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE-1:0] OUT_WINDOW_DATA;
		wire                                                     OUT_DATA_VALID;
		wire                                                     OUT_DATA_LAST;
// Instantiation of Axi Bus Interface S00_AXIS
	Windows_Data_Convert_v1_0_S00_AXIS # (
		.KERNEL_SIZE    (   KERNEL_SIZE       ),
	    .DATA_HORIZONTAL(   DATA_HORIZONTAL   ),
	    .DATA_VERTICAL  (   DATA_VERTICAL     ),
	    .STRIDE         (   STRIDE            ), 
	    .C_S_AXIS_PARA_DATA_WIDTH( PARA_DATA_WIDTH  ),
		.C_S_AXIS_TDATA_WIDTH    ( AXIS_TDATA_WIDTH      )
	) Windows_Data_Convert_v1_0_S00_AXIS_inst (
		.Data_horizontal(Data_horizontal),
	    .Data_vertical  (Data_vertical  ),
	    .Kernel_size    (Kernel_size    ),
	    .Stride         (Stride         ),
	    .Refresh        (Refresh        ),
	  //  .Start_Window   (Start_Window),
	    .OUT_DATA_LAST  (OUT_DATA_LAST ),
	    .OUT_WINDOW_DATA(OUT_WINDOW_DATA),
	    .OUT_DATA_VALID (OUT_DATA_VALID),
		.S_AXIS_ACLK(s00_axis_aclk),
		.S_AXIS_ARESETN(s00_axis_aresetn),
		.S_AXIS_TREADY(s00_axis_tready),
		.S_AXIS_TDATA(s00_axis_tdata),
		.S_AXIS_TSTRB(s00_axis_tstrb),
		.S_AXIS_TLAST(s00_axis_tlast),
		.S_AXIS_TVALID(s00_axis_tvalid)
	);

// Instantiation of Axi Bus Interface M00_AXIS
	Windows_Data_Convert_v1_0_M00_AXIS # ( 
	    .KERNEL_SIZE(KERNEL_SIZE),
	    .C_M_AXIS_PARA_DATA_WIDTH( PARA_DATA_WIDTH  ),
		.C_M_AXIS_TDATA_WIDTH(AXIS_TDATA_WIDTH*KERNEL_SIZE*KERNEL_SIZE)
	) Windows_Data_Convert_v1_0_M00_AXIS_inst (
	    .Kernel_size(Kernel_size),
	    .OUT_WINDOW_DATA(OUT_WINDOW_DATA),
	    .OUT_DATA_VALID (OUT_DATA_VALID),
	    .OUT_DATA_LAST  (OUT_DATA_LAST),
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TKEEP( m00_axis_tkeep),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);

	// Add user logic here

	// User logic ends

	endmodule
