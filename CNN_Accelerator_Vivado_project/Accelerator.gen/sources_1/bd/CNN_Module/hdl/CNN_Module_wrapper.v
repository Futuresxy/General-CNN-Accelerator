//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
//Date        : Sun Feb  9 15:31:51 2025
//Host        : DESKTOP-JO2RAF5 running 64-bit major release  (build 9200)
//Command     : generate_target CNN_Module_wrapper.bd
//Design      : CNN_Module_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module CNN_Module_wrapper
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
  input [7:0]AXI4_LITE_Control_Accelerator_araddr;
  input [2:0]AXI4_LITE_Control_Accelerator_arprot;
  output AXI4_LITE_Control_Accelerator_arready;
  input AXI4_LITE_Control_Accelerator_arvalid;
  input [7:0]AXI4_LITE_Control_Accelerator_awaddr;
  input [2:0]AXI4_LITE_Control_Accelerator_awprot;
  output AXI4_LITE_Control_Accelerator_awready;
  input AXI4_LITE_Control_Accelerator_awvalid;
  input AXI4_LITE_Control_Accelerator_bready;
  output [1:0]AXI4_LITE_Control_Accelerator_bresp;
  output AXI4_LITE_Control_Accelerator_bvalid;
  output [31:0]AXI4_LITE_Control_Accelerator_rdata;
  input AXI4_LITE_Control_Accelerator_rready;
  output [1:0]AXI4_LITE_Control_Accelerator_rresp;
  output AXI4_LITE_Control_Accelerator_rvalid;
  input [31:0]AXI4_LITE_Control_Accelerator_wdata;
  output AXI4_LITE_Control_Accelerator_wready;
  input [3:0]AXI4_LITE_Control_Accelerator_wstrb;
  input AXI4_LITE_Control_Accelerator_wvalid;
  input [4:0]AXI4_LITE_Control_Window_araddr;
  input [2:0]AXI4_LITE_Control_Window_arprot;
  output AXI4_LITE_Control_Window_arready;
  input AXI4_LITE_Control_Window_arvalid;
  input [4:0]AXI4_LITE_Control_Window_awaddr;
  input [2:0]AXI4_LITE_Control_Window_awprot;
  output AXI4_LITE_Control_Window_awready;
  input AXI4_LITE_Control_Window_awvalid;
  input AXI4_LITE_Control_Window_bready;
  output [1:0]AXI4_LITE_Control_Window_bresp;
  output AXI4_LITE_Control_Window_bvalid;
  output [31:0]AXI4_LITE_Control_Window_rdata;
  input AXI4_LITE_Control_Window_rready;
  output [1:0]AXI4_LITE_Control_Window_rresp;
  output AXI4_LITE_Control_Window_rvalid;
  input [31:0]AXI4_LITE_Control_Window_wdata;
  output AXI4_LITE_Control_Window_wready;
  input [3:0]AXI4_LITE_Control_Window_wstrb;
  input AXI4_LITE_Control_Window_wvalid;
  output [255:0]M_AXIS_tdata;
  output M_AXIS_tlast;
  input M_AXIS_tready;
  output M_AXIS_tvalid;
  input [63:0]S_AXIS1_tdata;
  input [7:0]S_AXIS1_tkeep;
  input S_AXIS1_tlast;
  output S_AXIS1_tready;
  input [7:0]S_AXIS1_tstrb;
  input S_AXIS1_tvalid;
  input [7:0]S_AXIS2_tdata;
  input [0:0]S_AXIS2_tkeep;
  input S_AXIS2_tlast;
  output S_AXIS2_tready;
  input S_AXIS2_tvalid;
  input [63:0]S_AXIS_tdata;
  input [7:0]S_AXIS_tkeep;
  input S_AXIS_tlast;
  output S_AXIS_tready;
  input [7:0]S_AXIS_tstrb;
  input S_AXIS_tvalid;
  output [3:0]cnn_cnt_0;
  output cnn_done;
  input s_axis_aclk;
  input s_axis_aresetn;

  wire [7:0]AXI4_LITE_Control_Accelerator_araddr;
  wire [2:0]AXI4_LITE_Control_Accelerator_arprot;
  wire AXI4_LITE_Control_Accelerator_arready;
  wire AXI4_LITE_Control_Accelerator_arvalid;
  wire [7:0]AXI4_LITE_Control_Accelerator_awaddr;
  wire [2:0]AXI4_LITE_Control_Accelerator_awprot;
  wire AXI4_LITE_Control_Accelerator_awready;
  wire AXI4_LITE_Control_Accelerator_awvalid;
  wire AXI4_LITE_Control_Accelerator_bready;
  wire [1:0]AXI4_LITE_Control_Accelerator_bresp;
  wire AXI4_LITE_Control_Accelerator_bvalid;
  wire [31:0]AXI4_LITE_Control_Accelerator_rdata;
  wire AXI4_LITE_Control_Accelerator_rready;
  wire [1:0]AXI4_LITE_Control_Accelerator_rresp;
  wire AXI4_LITE_Control_Accelerator_rvalid;
  wire [31:0]AXI4_LITE_Control_Accelerator_wdata;
  wire AXI4_LITE_Control_Accelerator_wready;
  wire [3:0]AXI4_LITE_Control_Accelerator_wstrb;
  wire AXI4_LITE_Control_Accelerator_wvalid;
  wire [4:0]AXI4_LITE_Control_Window_araddr;
  wire [2:0]AXI4_LITE_Control_Window_arprot;
  wire AXI4_LITE_Control_Window_arready;
  wire AXI4_LITE_Control_Window_arvalid;
  wire [4:0]AXI4_LITE_Control_Window_awaddr;
  wire [2:0]AXI4_LITE_Control_Window_awprot;
  wire AXI4_LITE_Control_Window_awready;
  wire AXI4_LITE_Control_Window_awvalid;
  wire AXI4_LITE_Control_Window_bready;
  wire [1:0]AXI4_LITE_Control_Window_bresp;
  wire AXI4_LITE_Control_Window_bvalid;
  wire [31:0]AXI4_LITE_Control_Window_rdata;
  wire AXI4_LITE_Control_Window_rready;
  wire [1:0]AXI4_LITE_Control_Window_rresp;
  wire AXI4_LITE_Control_Window_rvalid;
  wire [31:0]AXI4_LITE_Control_Window_wdata;
  wire AXI4_LITE_Control_Window_wready;
  wire [3:0]AXI4_LITE_Control_Window_wstrb;
  wire AXI4_LITE_Control_Window_wvalid;
  wire [255:0]M_AXIS_tdata;
  wire M_AXIS_tlast;
  wire M_AXIS_tready;
  wire M_AXIS_tvalid;
  wire [63:0]S_AXIS1_tdata;
  wire [7:0]S_AXIS1_tkeep;
  wire S_AXIS1_tlast;
  wire S_AXIS1_tready;
  wire [7:0]S_AXIS1_tstrb;
  wire S_AXIS1_tvalid;
  wire [7:0]S_AXIS2_tdata;
  wire [0:0]S_AXIS2_tkeep;
  wire S_AXIS2_tlast;
  wire S_AXIS2_tready;
  wire S_AXIS2_tvalid;
  wire [63:0]S_AXIS_tdata;
  wire [7:0]S_AXIS_tkeep;
  wire S_AXIS_tlast;
  wire S_AXIS_tready;
  wire [7:0]S_AXIS_tstrb;
  wire S_AXIS_tvalid;
  wire [3:0]cnn_cnt_0;
  wire cnn_done;
  wire s_axis_aclk;
  wire s_axis_aresetn;

  CNN_Module CNN_Module_i
       (.AXI4_LITE_Control_Accelerator_araddr(AXI4_LITE_Control_Accelerator_araddr),
        .AXI4_LITE_Control_Accelerator_arprot(AXI4_LITE_Control_Accelerator_arprot),
        .AXI4_LITE_Control_Accelerator_arready(AXI4_LITE_Control_Accelerator_arready),
        .AXI4_LITE_Control_Accelerator_arvalid(AXI4_LITE_Control_Accelerator_arvalid),
        .AXI4_LITE_Control_Accelerator_awaddr(AXI4_LITE_Control_Accelerator_awaddr),
        .AXI4_LITE_Control_Accelerator_awprot(AXI4_LITE_Control_Accelerator_awprot),
        .AXI4_LITE_Control_Accelerator_awready(AXI4_LITE_Control_Accelerator_awready),
        .AXI4_LITE_Control_Accelerator_awvalid(AXI4_LITE_Control_Accelerator_awvalid),
        .AXI4_LITE_Control_Accelerator_bready(AXI4_LITE_Control_Accelerator_bready),
        .AXI4_LITE_Control_Accelerator_bresp(AXI4_LITE_Control_Accelerator_bresp),
        .AXI4_LITE_Control_Accelerator_bvalid(AXI4_LITE_Control_Accelerator_bvalid),
        .AXI4_LITE_Control_Accelerator_rdata(AXI4_LITE_Control_Accelerator_rdata),
        .AXI4_LITE_Control_Accelerator_rready(AXI4_LITE_Control_Accelerator_rready),
        .AXI4_LITE_Control_Accelerator_rresp(AXI4_LITE_Control_Accelerator_rresp),
        .AXI4_LITE_Control_Accelerator_rvalid(AXI4_LITE_Control_Accelerator_rvalid),
        .AXI4_LITE_Control_Accelerator_wdata(AXI4_LITE_Control_Accelerator_wdata),
        .AXI4_LITE_Control_Accelerator_wready(AXI4_LITE_Control_Accelerator_wready),
        .AXI4_LITE_Control_Accelerator_wstrb(AXI4_LITE_Control_Accelerator_wstrb),
        .AXI4_LITE_Control_Accelerator_wvalid(AXI4_LITE_Control_Accelerator_wvalid),
        .AXI4_LITE_Control_Window_araddr(AXI4_LITE_Control_Window_araddr),
        .AXI4_LITE_Control_Window_arprot(AXI4_LITE_Control_Window_arprot),
        .AXI4_LITE_Control_Window_arready(AXI4_LITE_Control_Window_arready),
        .AXI4_LITE_Control_Window_arvalid(AXI4_LITE_Control_Window_arvalid),
        .AXI4_LITE_Control_Window_awaddr(AXI4_LITE_Control_Window_awaddr),
        .AXI4_LITE_Control_Window_awprot(AXI4_LITE_Control_Window_awprot),
        .AXI4_LITE_Control_Window_awready(AXI4_LITE_Control_Window_awready),
        .AXI4_LITE_Control_Window_awvalid(AXI4_LITE_Control_Window_awvalid),
        .AXI4_LITE_Control_Window_bready(AXI4_LITE_Control_Window_bready),
        .AXI4_LITE_Control_Window_bresp(AXI4_LITE_Control_Window_bresp),
        .AXI4_LITE_Control_Window_bvalid(AXI4_LITE_Control_Window_bvalid),
        .AXI4_LITE_Control_Window_rdata(AXI4_LITE_Control_Window_rdata),
        .AXI4_LITE_Control_Window_rready(AXI4_LITE_Control_Window_rready),
        .AXI4_LITE_Control_Window_rresp(AXI4_LITE_Control_Window_rresp),
        .AXI4_LITE_Control_Window_rvalid(AXI4_LITE_Control_Window_rvalid),
        .AXI4_LITE_Control_Window_wdata(AXI4_LITE_Control_Window_wdata),
        .AXI4_LITE_Control_Window_wready(AXI4_LITE_Control_Window_wready),
        .AXI4_LITE_Control_Window_wstrb(AXI4_LITE_Control_Window_wstrb),
        .AXI4_LITE_Control_Window_wvalid(AXI4_LITE_Control_Window_wvalid),
        .M_AXIS_tdata(M_AXIS_tdata),
        .M_AXIS_tlast(M_AXIS_tlast),
        .M_AXIS_tready(M_AXIS_tready),
        .M_AXIS_tvalid(M_AXIS_tvalid),
        .S_AXIS1_tdata(S_AXIS1_tdata),
        .S_AXIS1_tkeep(S_AXIS1_tkeep),
        .S_AXIS1_tlast(S_AXIS1_tlast),
        .S_AXIS1_tready(S_AXIS1_tready),
        .S_AXIS1_tstrb(S_AXIS1_tstrb),
        .S_AXIS1_tvalid(S_AXIS1_tvalid),
        .S_AXIS2_tdata(S_AXIS2_tdata),
        .S_AXIS2_tkeep(S_AXIS2_tkeep),
        .S_AXIS2_tlast(S_AXIS2_tlast),
        .S_AXIS2_tready(S_AXIS2_tready),
        .S_AXIS2_tvalid(S_AXIS2_tvalid),
        .S_AXIS_tdata(S_AXIS_tdata),
        .S_AXIS_tkeep(S_AXIS_tkeep),
        .S_AXIS_tlast(S_AXIS_tlast),
        .S_AXIS_tready(S_AXIS_tready),
        .S_AXIS_tstrb(S_AXIS_tstrb),
        .S_AXIS_tvalid(S_AXIS_tvalid),
        .cnn_cnt_0(cnn_cnt_0),
        .cnn_done(cnn_done),
        .s_axis_aclk(s_axis_aclk),
        .s_axis_aresetn(s_axis_aresetn));
endmodule
