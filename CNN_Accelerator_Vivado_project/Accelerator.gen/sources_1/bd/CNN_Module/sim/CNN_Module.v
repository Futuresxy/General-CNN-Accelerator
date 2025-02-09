//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Sun Feb  9 15:31:51 2025
//Host        : DESKTOP-JO2RAF5 running 64-bit major release  (build 9200)
//Command     : generate_target CNN_Module.bd
//Design      : CNN_Module
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "CNN_Module,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=CNN_Module,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=2,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "CNN_Module.hwdef" *) 
module CNN_Module
   (AXI4_LITE_Control_Accelerator_araddr,
    AXI4_LITE_Control_Accelerator_arprot,
    AXI4_LITE_Control_Accelerator_arready,
    AXI4_LITE_Control_Accelerator_arvalid,
    AXI4_LITE_Control_Accelerator_awaddr,
    AXI4_LITE_Control_Accelerator_awprot,
    AXI4_LITE_Control_Accelerator_awready,
    AXI4_LITE_Control_Accelerator_awvalid,
    AXI4_LITE_Control_Accelerator_bready,
    AXI4_LITE_Control_Accelerator_bresp,
    AXI4_LITE_Control_Accelerator_bvalid,
    AXI4_LITE_Control_Accelerator_rdata,
    AXI4_LITE_Control_Accelerator_rready,
    AXI4_LITE_Control_Accelerator_rresp,
    AXI4_LITE_Control_Accelerator_rvalid,
    AXI4_LITE_Control_Accelerator_wdata,
    AXI4_LITE_Control_Accelerator_wready,
    AXI4_LITE_Control_Accelerator_wstrb,
    AXI4_LITE_Control_Accelerator_wvalid,
    AXI4_LITE_Control_Window_araddr,
    AXI4_LITE_Control_Window_arprot,
    AXI4_LITE_Control_Window_arready,
    AXI4_LITE_Control_Window_arvalid,
    AXI4_LITE_Control_Window_awaddr,
    AXI4_LITE_Control_Window_awprot,
    AXI4_LITE_Control_Window_awready,
    AXI4_LITE_Control_Window_awvalid,
    AXI4_LITE_Control_Window_bready,
    AXI4_LITE_Control_Window_bresp,
    AXI4_LITE_Control_Window_bvalid,
    AXI4_LITE_Control_Window_rdata,
    AXI4_LITE_Control_Window_rready,
    AXI4_LITE_Control_Window_rresp,
    AXI4_LITE_Control_Window_rvalid,
    AXI4_LITE_Control_Window_wdata,
    AXI4_LITE_Control_Window_wready,
    AXI4_LITE_Control_Window_wstrb,
    AXI4_LITE_Control_Window_wvalid,
    M_AXIS_tdata,
    M_AXIS_tlast,
    M_AXIS_tready,
    M_AXIS_tvalid,
    S_AXIS1_tdata,
    S_AXIS1_tkeep,
    S_AXIS1_tlast,
    S_AXIS1_tready,
    S_AXIS1_tstrb,
    S_AXIS1_tvalid,
    S_AXIS2_tdata,
    S_AXIS2_tkeep,
    S_AXIS2_tlast,
    S_AXIS2_tready,
    S_AXIS2_tvalid,
    S_AXIS_tdata,
    S_AXIS_tkeep,
    S_AXIS_tlast,
    S_AXIS_tready,
    S_AXIS_tstrb,
    S_AXIS_tvalid,
    cnn_cnt_0,
    cnn_done,
    s_axis_aclk,
    s_axis_aresetn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME AXI4_LITE_Control_Accelerator, ADDR_WIDTH 31, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN CNN_Module_s_axis_aclk, DATA_WIDTH 32, FREQ_HZ 50000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [7:0]AXI4_LITE_Control_Accelerator_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator ARPROT" *) input [2:0]AXI4_LITE_Control_Accelerator_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator ARREADY" *) output AXI4_LITE_Control_Accelerator_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator ARVALID" *) input AXI4_LITE_Control_Accelerator_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator AWADDR" *) input [7:0]AXI4_LITE_Control_Accelerator_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator AWPROT" *) input [2:0]AXI4_LITE_Control_Accelerator_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator AWREADY" *) output AXI4_LITE_Control_Accelerator_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator AWVALID" *) input AXI4_LITE_Control_Accelerator_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator BREADY" *) input AXI4_LITE_Control_Accelerator_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator BRESP" *) output [1:0]AXI4_LITE_Control_Accelerator_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator BVALID" *) output AXI4_LITE_Control_Accelerator_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator RDATA" *) output [31:0]AXI4_LITE_Control_Accelerator_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator RREADY" *) input AXI4_LITE_Control_Accelerator_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator RRESP" *) output [1:0]AXI4_LITE_Control_Accelerator_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator RVALID" *) output AXI4_LITE_Control_Accelerator_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator WDATA" *) input [31:0]AXI4_LITE_Control_Accelerator_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator WREADY" *) output AXI4_LITE_Control_Accelerator_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator WSTRB" *) input [3:0]AXI4_LITE_Control_Accelerator_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Accelerator WVALID" *) input AXI4_LITE_Control_Accelerator_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window ARADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME AXI4_LITE_Control_Window, ADDR_WIDTH 31, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN CNN_Module_s_axis_aclk, DATA_WIDTH 32, FREQ_HZ 50000000, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 1, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 1, NUM_READ_OUTSTANDING 1, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 1, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4LITE, READ_WRITE_MODE READ_WRITE, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [4:0]AXI4_LITE_Control_Window_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window ARPROT" *) input [2:0]AXI4_LITE_Control_Window_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window ARREADY" *) output AXI4_LITE_Control_Window_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window ARVALID" *) input AXI4_LITE_Control_Window_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window AWADDR" *) input [4:0]AXI4_LITE_Control_Window_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window AWPROT" *) input [2:0]AXI4_LITE_Control_Window_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window AWREADY" *) output AXI4_LITE_Control_Window_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window AWVALID" *) input AXI4_LITE_Control_Window_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window BREADY" *) input AXI4_LITE_Control_Window_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window BRESP" *) output [1:0]AXI4_LITE_Control_Window_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window BVALID" *) output AXI4_LITE_Control_Window_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window RDATA" *) output [31:0]AXI4_LITE_Control_Window_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window RREADY" *) input AXI4_LITE_Control_Window_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window RRESP" *) output [1:0]AXI4_LITE_Control_Window_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window RVALID" *) output AXI4_LITE_Control_Window_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window WDATA" *) input [31:0]AXI4_LITE_Control_Window_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window WREADY" *) output AXI4_LITE_Control_Window_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window WSTRB" *) input [3:0]AXI4_LITE_Control_Window_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 AXI4_LITE_Control_Window WVALID" *) input AXI4_LITE_Control_Window_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M_AXIS, CLK_DOMAIN CNN_Module_s_axis_aclk, FREQ_HZ 50000000, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) output [255:0]M_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TLAST" *) output M_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TREADY" *) input M_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M_AXIS TVALID" *) output M_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS1, CLK_DOMAIN CNN_Module_s_axis_aclk, FREQ_HZ 50000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [63:0]S_AXIS1_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TKEEP" *) input [7:0]S_AXIS1_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TLAST" *) input S_AXIS1_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TREADY" *) output S_AXIS1_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TSTRB" *) input [7:0]S_AXIS1_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS1 TVALID" *) input S_AXIS1_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS2 TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS2, CLK_DOMAIN CNN_Module_s_axis_aclk, FREQ_HZ 50000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 0, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [7:0]S_AXIS2_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS2 TKEEP" *) input [0:0]S_AXIS2_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS2 TLAST" *) input S_AXIS2_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS2 TREADY" *) output S_AXIS2_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS2 TVALID" *) input S_AXIS2_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TDATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME S_AXIS, CLK_DOMAIN CNN_Module_s_axis_aclk, FREQ_HZ 50000000, HAS_TKEEP 1, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [63:0]S_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TKEEP" *) input [7:0]S_AXIS_tkeep;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TLAST" *) input S_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TREADY" *) output S_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TSTRB" *) input [7:0]S_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS TVALID" *) input S_AXIS_tvalid;
  output [3:0]cnn_cnt_0;
  output cnn_done;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.S_AXIS_ACLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.S_AXIS_ACLK, ASSOCIATED_BUSIF AXI4_LITE_Control_Accelerator:AXI4_LITE_Control_Window:M_AXIS:S_AXIS:S_AXIS1:S_AXIS2, ASSOCIATED_RESET s_axis_aresetn, CLK_DOMAIN CNN_Module_s_axis_aclk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input s_axis_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.S_AXIS_ARESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.S_AXIS_ARESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input s_axis_aresetn;

  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [255:0]CNN_Control_0_result_TDATA;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire CNN_Control_0_result_TLAST;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire CNN_Control_0_result_TREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire CNN_Control_0_result_TVALID;
  wire [3:0]CNN_Control_1_cnn_cnt;
  wire CNN_Control_1_cnn_done;
  wire [255:0]Conn1_TDATA;
  wire Conn1_TLAST;
  wire Conn1_TREADY;
  wire Conn1_TVALID;
  wire [7:0]Conn2_TDATA;
  wire [0:0]Conn2_TKEEP;
  wire Conn2_TLAST;
  wire Conn2_TREADY;
  wire Conn2_TVALID;
  wire [63:0]Conn4_TDATA;
  wire [7:0]Conn4_TKEEP;
  wire Conn4_TLAST;
  wire Conn4_TREADY;
  wire [7:0]Conn4_TSTRB;
  wire Conn4_TVALID;
  wire [63:0]Conn5_TDATA;
  wire [7:0]Conn5_TKEEP;
  wire Conn5_TLAST;
  wire Conn5_TREADY;
  wire [7:0]Conn5_TSTRB;
  wire Conn5_TVALID;
  wire [4:0]Conn6_ARADDR;
  wire [2:0]Conn6_ARPROT;
  wire Conn6_ARREADY;
  wire Conn6_ARVALID;
  wire [4:0]Conn6_AWADDR;
  wire [2:0]Conn6_AWPROT;
  wire Conn6_AWREADY;
  wire Conn6_AWVALID;
  wire Conn6_BREADY;
  wire [1:0]Conn6_BRESP;
  wire Conn6_BVALID;
  wire [31:0]Conn6_RDATA;
  wire Conn6_RREADY;
  wire [1:0]Conn6_RRESP;
  wire Conn6_RVALID;
  wire [31:0]Conn6_WDATA;
  wire Conn6_WREADY;
  wire [3:0]Conn6_WSTRB;
  wire Conn6_WVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [199:0]INACT_DATA_FIFO_M_AXIS_TDATA;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [24:0]INACT_DATA_FIFO_M_AXIS_TKEEP;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire INACT_DATA_FIFO_M_AXIS_TLAST;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire INACT_DATA_FIFO_M_AXIS_TREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [24:0]INACT_DATA_FIFO_M_AXIS_TSTRB;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire INACT_DATA_FIFO_M_AXIS_TVALID;
  wire [7:0]PICTURE_DATA_FIFO_M_AXIS_TDATA;
  wire PICTURE_DATA_FIFO_M_AXIS_TLAST;
  wire PICTURE_DATA_FIFO_M_AXIS_TREADY;
  wire PICTURE_DATA_FIFO_M_AXIS_TVALID;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [63:0]WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TDATA;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [7:0]WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TKEEP;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TLAST;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TREADY;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire [7:0]WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TSTRB;
  (* DEBUG = "true" *) (* MARK_DEBUG *) wire WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TVALID;
  wire [63:0]WEIGHT_FULLCON_FIFO_M_AXIS_TDATA;
  wire [7:0]WEIGHT_FULLCON_FIFO_M_AXIS_TKEEP;
  wire WEIGHT_FULLCON_FIFO_M_AXIS_TLAST;
  wire WEIGHT_FULLCON_FIFO_M_AXIS_TREADY;
  wire [7:0]WEIGHT_FULLCON_FIFO_M_AXIS_TSTRB;
  wire WEIGHT_FULLCON_FIFO_M_AXIS_TVALID;
  wire [199:0]Windows_Data_Convert_0_m00_axis_TDATA;
  wire [24:0]Windows_Data_Convert_0_m00_axis_TKEEP;
  wire Windows_Data_Convert_0_m00_axis_TLAST;
  wire Windows_Data_Convert_0_m00_axis_TREADY;
  wire [24:0]Windows_Data_Convert_0_m00_axis_TSTRB;
  wire Windows_Data_Convert_0_m00_axis_TVALID;
  wire [7:0]s00_axi_1_ARADDR;
  wire [2:0]s00_axi_1_ARPROT;
  wire s00_axi_1_ARREADY;
  wire s00_axi_1_ARVALID;
  wire [7:0]s00_axi_1_AWADDR;
  wire [2:0]s00_axi_1_AWPROT;
  wire s00_axi_1_AWREADY;
  wire s00_axi_1_AWVALID;
  wire s00_axi_1_BREADY;
  wire [1:0]s00_axi_1_BRESP;
  wire s00_axi_1_BVALID;
  wire [31:0]s00_axi_1_RDATA;
  wire s00_axi_1_RREADY;
  wire [1:0]s00_axi_1_RRESP;
  wire s00_axi_1_RVALID;
  wire [31:0]s00_axi_1_WDATA;
  wire s00_axi_1_WREADY;
  wire [3:0]s00_axi_1_WSTRB;
  wire s00_axi_1_WVALID;
  wire s_axis_aclk_1;
  wire s_axis_aresetn_1;

  assign AXI4_LITE_Control_Accelerator_arready = s00_axi_1_ARREADY;
  assign AXI4_LITE_Control_Accelerator_awready = s00_axi_1_AWREADY;
  assign AXI4_LITE_Control_Accelerator_bresp[1:0] = s00_axi_1_BRESP;
  assign AXI4_LITE_Control_Accelerator_bvalid = s00_axi_1_BVALID;
  assign AXI4_LITE_Control_Accelerator_rdata[31:0] = s00_axi_1_RDATA;
  assign AXI4_LITE_Control_Accelerator_rresp[1:0] = s00_axi_1_RRESP;
  assign AXI4_LITE_Control_Accelerator_rvalid = s00_axi_1_RVALID;
  assign AXI4_LITE_Control_Accelerator_wready = s00_axi_1_WREADY;
  assign AXI4_LITE_Control_Window_arready = Conn6_ARREADY;
  assign AXI4_LITE_Control_Window_awready = Conn6_AWREADY;
  assign AXI4_LITE_Control_Window_bresp[1:0] = Conn6_BRESP;
  assign AXI4_LITE_Control_Window_bvalid = Conn6_BVALID;
  assign AXI4_LITE_Control_Window_rdata[31:0] = Conn6_RDATA;
  assign AXI4_LITE_Control_Window_rresp[1:0] = Conn6_RRESP;
  assign AXI4_LITE_Control_Window_rvalid = Conn6_RVALID;
  assign AXI4_LITE_Control_Window_wready = Conn6_WREADY;
  assign Conn1_TREADY = M_AXIS_tready;
  assign Conn2_TDATA = S_AXIS2_tdata[7:0];
  assign Conn2_TKEEP = S_AXIS2_tkeep[0];
  assign Conn2_TLAST = S_AXIS2_tlast;
  assign Conn2_TVALID = S_AXIS2_tvalid;
  assign Conn4_TDATA = S_AXIS_tdata[63:0];
  assign Conn4_TKEEP = S_AXIS_tkeep[7:0];
  assign Conn4_TLAST = S_AXIS_tlast;
  assign Conn4_TSTRB = S_AXIS_tstrb[7:0];
  assign Conn4_TVALID = S_AXIS_tvalid;
  assign Conn5_TDATA = S_AXIS1_tdata[63:0];
  assign Conn5_TKEEP = S_AXIS1_tkeep[7:0];
  assign Conn5_TLAST = S_AXIS1_tlast;
  assign Conn5_TSTRB = S_AXIS1_tstrb[7:0];
  assign Conn5_TVALID = S_AXIS1_tvalid;
  assign Conn6_ARADDR = AXI4_LITE_Control_Window_araddr[4:0];
  assign Conn6_ARPROT = AXI4_LITE_Control_Window_arprot[2:0];
  assign Conn6_ARVALID = AXI4_LITE_Control_Window_arvalid;
  assign Conn6_AWADDR = AXI4_LITE_Control_Window_awaddr[4:0];
  assign Conn6_AWPROT = AXI4_LITE_Control_Window_awprot[2:0];
  assign Conn6_AWVALID = AXI4_LITE_Control_Window_awvalid;
  assign Conn6_BREADY = AXI4_LITE_Control_Window_bready;
  assign Conn6_RREADY = AXI4_LITE_Control_Window_rready;
  assign Conn6_WDATA = AXI4_LITE_Control_Window_wdata[31:0];
  assign Conn6_WSTRB = AXI4_LITE_Control_Window_wstrb[3:0];
  assign Conn6_WVALID = AXI4_LITE_Control_Window_wvalid;
  assign M_AXIS_tdata[255:0] = Conn1_TDATA;
  assign M_AXIS_tlast = Conn1_TLAST;
  assign M_AXIS_tvalid = Conn1_TVALID;
  assign S_AXIS1_tready = Conn5_TREADY;
  assign S_AXIS2_tready = Conn2_TREADY;
  assign S_AXIS_tready = Conn4_TREADY;
  assign cnn_cnt_0[3:0] = CNN_Control_1_cnn_cnt;
  assign cnn_done = CNN_Control_1_cnn_done;
  assign s00_axi_1_ARADDR = AXI4_LITE_Control_Accelerator_araddr[7:0];
  assign s00_axi_1_ARPROT = AXI4_LITE_Control_Accelerator_arprot[2:0];
  assign s00_axi_1_ARVALID = AXI4_LITE_Control_Accelerator_arvalid;
  assign s00_axi_1_AWADDR = AXI4_LITE_Control_Accelerator_awaddr[7:0];
  assign s00_axi_1_AWPROT = AXI4_LITE_Control_Accelerator_awprot[2:0];
  assign s00_axi_1_AWVALID = AXI4_LITE_Control_Accelerator_awvalid;
  assign s00_axi_1_BREADY = AXI4_LITE_Control_Accelerator_bready;
  assign s00_axi_1_RREADY = AXI4_LITE_Control_Accelerator_rready;
  assign s00_axi_1_WDATA = AXI4_LITE_Control_Accelerator_wdata[31:0];
  assign s00_axi_1_WSTRB = AXI4_LITE_Control_Accelerator_wstrb[3:0];
  assign s00_axi_1_WVALID = AXI4_LITE_Control_Accelerator_wvalid;
  assign s_axis_aclk_1 = s_axis_aclk;
  assign s_axis_aresetn_1 = s_axis_aresetn;
  CNN_Module_CNN_Control_1_0 CNN_Control_1
       (.cnn_cnt(CNN_Control_1_cnn_cnt),
        .cnn_done(CNN_Control_1_cnn_done),
        .image_tdata(INACT_DATA_FIFO_M_AXIS_TDATA),
        .image_tkeep(INACT_DATA_FIFO_M_AXIS_TKEEP),
        .image_tlast(INACT_DATA_FIFO_M_AXIS_TLAST),
        .image_tready(INACT_DATA_FIFO_M_AXIS_TREADY),
        .image_tstrb(INACT_DATA_FIFO_M_AXIS_TSTRB),
        .image_tvalid(INACT_DATA_FIFO_M_AXIS_TVALID),
        .result_tdata(CNN_Control_0_result_TDATA),
        .result_tlast(CNN_Control_0_result_TLAST),
        .result_tready(CNN_Control_0_result_TREADY),
        .result_tvalid(CNN_Control_0_result_TVALID),
        .s00_axi_aclk(s_axis_aclk_1),
        .s00_axi_araddr(s00_axi_1_ARADDR),
        .s00_axi_aresetn(s_axis_aresetn_1),
        .s00_axi_arprot(s00_axi_1_ARPROT),
        .s00_axi_arready(s00_axi_1_ARREADY),
        .s00_axi_arvalid(s00_axi_1_ARVALID),
        .s00_axi_awaddr(s00_axi_1_AWADDR),
        .s00_axi_awprot(s00_axi_1_AWPROT),
        .s00_axi_awready(s00_axi_1_AWREADY),
        .s00_axi_awvalid(s00_axi_1_AWVALID),
        .s00_axi_bready(s00_axi_1_BREADY),
        .s00_axi_bresp(s00_axi_1_BRESP),
        .s00_axi_bvalid(s00_axi_1_BVALID),
        .s00_axi_rdata(s00_axi_1_RDATA),
        .s00_axi_rready(s00_axi_1_RREADY),
        .s00_axi_rresp(s00_axi_1_RRESP),
        .s00_axi_rvalid(s00_axi_1_RVALID),
        .s00_axi_wdata(s00_axi_1_WDATA),
        .s00_axi_wready(s00_axi_1_WREADY),
        .s00_axi_wstrb(s00_axi_1_WSTRB),
        .s00_axi_wvalid(s00_axi_1_WVALID),
        .weight_tdata(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TDATA),
        .weight_tkeep(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TKEEP),
        .weight_tlast(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TLAST),
        .weight_tready(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TREADY),
        .weight_tstrb(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TSTRB),
        .weight_tvalid(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TVALID),
        .weightfc_tdata(WEIGHT_FULLCON_FIFO_M_AXIS_TDATA),
        .weightfc_tkeep(WEIGHT_FULLCON_FIFO_M_AXIS_TKEEP),
        .weightfc_tlast(WEIGHT_FULLCON_FIFO_M_AXIS_TLAST),
        .weightfc_tready(WEIGHT_FULLCON_FIFO_M_AXIS_TREADY),
        .weightfc_tstrb(WEIGHT_FULLCON_FIFO_M_AXIS_TSTRB),
        .weightfc_tvalid(WEIGHT_FULLCON_FIFO_M_AXIS_TVALID));
  CNN_Module_INACT_DATA_FIFO_0 INACT_DATA_FIFO
       (.m_axis_tdata(INACT_DATA_FIFO_M_AXIS_TDATA),
        .m_axis_tkeep(INACT_DATA_FIFO_M_AXIS_TKEEP),
        .m_axis_tlast(INACT_DATA_FIFO_M_AXIS_TLAST),
        .m_axis_tready(INACT_DATA_FIFO_M_AXIS_TREADY),
        .m_axis_tstrb(INACT_DATA_FIFO_M_AXIS_TSTRB),
        .m_axis_tvalid(INACT_DATA_FIFO_M_AXIS_TVALID),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(Windows_Data_Convert_0_m00_axis_TDATA),
        .s_axis_tkeep(Windows_Data_Convert_0_m00_axis_TKEEP),
        .s_axis_tlast(Windows_Data_Convert_0_m00_axis_TLAST),
        .s_axis_tready(Windows_Data_Convert_0_m00_axis_TREADY),
        .s_axis_tstrb(Windows_Data_Convert_0_m00_axis_TSTRB),
        .s_axis_tvalid(Windows_Data_Convert_0_m00_axis_TVALID));
  CNN_Module_PICTURE_DATA_FIFO_0 PICTURE_DATA_FIFO
       (.m_axis_tdata(PICTURE_DATA_FIFO_M_AXIS_TDATA),
        .m_axis_tlast(PICTURE_DATA_FIFO_M_AXIS_TLAST),
        .m_axis_tready(PICTURE_DATA_FIFO_M_AXIS_TREADY),
        .m_axis_tvalid(PICTURE_DATA_FIFO_M_AXIS_TVALID),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(Conn2_TDATA),
        .s_axis_tkeep(Conn2_TKEEP),
        .s_axis_tlast(Conn2_TLAST),
        .s_axis_tready(Conn2_TREADY),
        .s_axis_tvalid(Conn2_TVALID));
  CNN_Module_RESULT_DATA_FIFO1_0 RESULT_DATA_FIFO1
       (.m_axis_tdata(Conn1_TDATA),
        .m_axis_tlast(Conn1_TLAST),
        .m_axis_tready(Conn1_TREADY),
        .m_axis_tvalid(Conn1_TVALID),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(CNN_Control_0_result_TDATA),
        .s_axis_tlast(CNN_Control_0_result_TLAST),
        .s_axis_tready(CNN_Control_0_result_TREADY),
        .s_axis_tvalid(CNN_Control_0_result_TVALID));
  CNN_Module_WEIGHT_CONV_ACT_FULLCON_FIFO_0 WEIGHT_CONV_ACT_FULLCON_FIFO
       (.m_axis_tdata(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TDATA),
        .m_axis_tkeep(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TKEEP),
        .m_axis_tlast(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TLAST),
        .m_axis_tready(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TREADY),
        .m_axis_tstrb(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TSTRB),
        .m_axis_tvalid(WEIGHT_CONV_ACT_FULLCON_FIFO_M_AXIS_TVALID),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(Conn5_TDATA),
        .s_axis_tkeep(Conn5_TKEEP),
        .s_axis_tlast(Conn5_TLAST),
        .s_axis_tready(Conn5_TREADY),
        .s_axis_tstrb(Conn5_TSTRB),
        .s_axis_tvalid(Conn5_TVALID));
  CNN_Module_WEIGHT_FULLCON_FIFO_0 WEIGHT_FULLCON_FIFO
       (.m_axis_tdata(WEIGHT_FULLCON_FIFO_M_AXIS_TDATA),
        .m_axis_tkeep(WEIGHT_FULLCON_FIFO_M_AXIS_TKEEP),
        .m_axis_tlast(WEIGHT_FULLCON_FIFO_M_AXIS_TLAST),
        .m_axis_tready(WEIGHT_FULLCON_FIFO_M_AXIS_TREADY),
        .m_axis_tstrb(WEIGHT_FULLCON_FIFO_M_AXIS_TSTRB),
        .m_axis_tvalid(WEIGHT_FULLCON_FIFO_M_AXIS_TVALID),
        .s_axis_aclk(s_axis_aclk_1),
        .s_axis_aresetn(s_axis_aresetn_1),
        .s_axis_tdata(Conn4_TDATA),
        .s_axis_tkeep(Conn4_TKEEP),
        .s_axis_tlast(Conn4_TLAST),
        .s_axis_tready(Conn4_TREADY),
        .s_axis_tstrb(Conn4_TSTRB),
        .s_axis_tvalid(Conn4_TVALID));
  CNN_Module_Windows_Data_Convert_0_0 Windows_Data_Convert_0
       (.m00_axis_aclk(s_axis_aclk_1),
        .m00_axis_aresetn(s_axis_aresetn_1),
        .m00_axis_tdata(Windows_Data_Convert_0_m00_axis_TDATA),
        .m00_axis_tkeep(Windows_Data_Convert_0_m00_axis_TKEEP),
        .m00_axis_tlast(Windows_Data_Convert_0_m00_axis_TLAST),
        .m00_axis_tready(Windows_Data_Convert_0_m00_axis_TREADY),
        .m00_axis_tstrb(Windows_Data_Convert_0_m00_axis_TSTRB),
        .m00_axis_tvalid(Windows_Data_Convert_0_m00_axis_TVALID),
        .s00_axis_aclk(s_axis_aclk_1),
        .s00_axis_aresetn(s_axis_aresetn_1),
        .s00_axis_tdata(PICTURE_DATA_FIFO_M_AXIS_TDATA),
        .s00_axis_tlast(PICTURE_DATA_FIFO_M_AXIS_TLAST),
        .s00_axis_tready(PICTURE_DATA_FIFO_M_AXIS_TREADY),
        .s00_axis_tstrb(1'b1),
        .s00_axis_tvalid(PICTURE_DATA_FIFO_M_AXIS_TVALID),
        .s01_axi_aclk(s_axis_aclk_1),
        .s01_axi_araddr(Conn6_ARADDR),
        .s01_axi_aresetn(s_axis_aresetn_1),
        .s01_axi_arprot(Conn6_ARPROT),
        .s01_axi_arready(Conn6_ARREADY),
        .s01_axi_arvalid(Conn6_ARVALID),
        .s01_axi_awaddr(Conn6_AWADDR),
        .s01_axi_awprot(Conn6_AWPROT),
        .s01_axi_awready(Conn6_AWREADY),
        .s01_axi_awvalid(Conn6_AWVALID),
        .s01_axi_bready(Conn6_BREADY),
        .s01_axi_bresp(Conn6_BRESP),
        .s01_axi_bvalid(Conn6_BVALID),
        .s01_axi_rdata(Conn6_RDATA),
        .s01_axi_rready(Conn6_RREADY),
        .s01_axi_rresp(Conn6_RRESP),
        .s01_axi_rvalid(Conn6_RVALID),
        .s01_axi_wdata(Conn6_WDATA),
        .s01_axi_wready(Conn6_WREADY),
        .s01_axi_wstrb(Conn6_WSTRB),
        .s01_axi_wvalid(Conn6_WVALID));
endmodule
