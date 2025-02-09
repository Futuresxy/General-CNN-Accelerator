// (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:CNN_Control:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module CNN_Module_CNN_Control_1_0 (
  s00_axi_aclk,
  s00_axi_aresetn,
  s00_axi_awaddr,
  s00_axi_awprot,
  s00_axi_awvalid,
  s00_axi_awready,
  s00_axi_wdata,
  s00_axi_wstrb,
  s00_axi_wvalid,
  s00_axi_wready,
  s00_axi_bresp,
  s00_axi_bvalid,
  s00_axi_bready,
  s00_axi_araddr,
  s00_axi_arprot,
  s00_axi_arvalid,
  s00_axi_arready,
  s00_axi_rdata,
  s00_axi_rresp,
  s00_axi_rvalid,
  s00_axi_rready,
  image_tvalid,
  image_tlast,
  image_tready,
  image_tdata,
  image_tkeep,
  image_tstrb,
  weight_tvalid,
  weight_tlast,
  weight_tready,
  weight_tdata,
  weight_tkeep,
  weight_tstrb,
  weightfc_tvalid,
  weightfc_tlast,
  weightfc_tready,
  weightfc_tdata,
  weightfc_tkeep,
  weightfc_tstrb,
  result_tready,
  result_tvalid,
  result_tlast,
  result_tdata,
  result_tkeep,
  result_tstrb,
  cnn_done,
  cnn_cnt
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axi_aclk, ASSOCIATED_BUSIF s00_axi, ASSOCIATED_RESET s00_axi_aresetn, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN CNN_Module_s_axis_aclk, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s00_axi_aclk CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s00_axi_aresetn RST" *)
input wire s00_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWADDR" *)
input wire [7 : 0] s00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWPROT" *)
input wire [2 : 0] s00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWVALID" *)
input wire s00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi AWREADY" *)
output wire s00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WDATA" *)
input wire [31 : 0] s00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WSTRB" *)
input wire [3 : 0] s00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WVALID" *)
input wire s00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi WREADY" *)
output wire s00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BRESP" *)
output wire [1 : 0] s00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BVALID" *)
output wire s00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi BREADY" *)
input wire s00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARADDR" *)
input wire [7 : 0] s00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARPROT" *)
input wire [2 : 0] s00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARVALID" *)
input wire s00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi ARREADY" *)
output wire s00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RDATA" *)
output wire [31 : 0] s00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RRESP" *)
output wire [1 : 0] s00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RVALID" *)
output wire s00_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s00_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 50000000, ID_WIDTH 0, ADDR_WIDTH 8, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 1, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN CNN_Module_s_axis_aclk, NUM_READ_THREADS 1, NUM_WRITE_THREAD\
S 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s00_axi RREADY" *)
input wire s00_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TVALID" *)
input wire image_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TLAST" *)
input wire image_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TREADY" *)
output wire image_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TDATA" *)
input wire [199 : 0] image_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TKEEP" *)
input wire [24 : 0] image_tkeep;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME image, TDATA_NUM_BYTES 25, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 50000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 image TSTRB" *)
input wire [24 : 0] image_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TVALID" *)
input wire weight_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TLAST" *)
input wire weight_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TREADY" *)
output wire weight_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TDATA" *)
input wire [63 : 0] weight_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TKEEP" *)
input wire [7 : 0] weight_tkeep;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME weight, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 50000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weight TSTRB" *)
input wire [7 : 0] weight_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TVALID" *)
input wire weightfc_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TLAST" *)
input wire weightfc_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TREADY" *)
output wire weightfc_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TDATA" *)
input wire [63 : 0] weightfc_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TKEEP" *)
input wire [7 : 0] weightfc_tkeep;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME weightfc, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 50000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 weightfc TSTRB" *)
input wire [7 : 0] weightfc_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TREADY" *)
input wire result_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TVALID" *)
output wire result_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TLAST" *)
output wire result_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TDATA" *)
output wire [255 : 0] result_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TKEEP" *)
output wire [31 : 0] result_tkeep;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME result, TDATA_NUM_BYTES 32, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 1, HAS_TKEEP 1, HAS_TLAST 1, FREQ_HZ 50000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 result TSTRB" *)
output wire [31 : 0] result_tstrb;
output wire cnn_done;
output wire [3 : 0] cnn_cnt;

  CNN_Control #(
    .DATA_WIDTH(8),
    .PARA_WIDTH(8),
    .RESULT_NUM(8),
    .RESULT_DATA_WIDTH(32),
    .CONV_KERNEL_SIZE(5),
    .CONV_KERNEL_NUM(8),
    .POOL_KERNEL_SIZE(2),
    .POOL_KERNEL_NUM(1),
    .FULLCON_INPUT_SIZE(192),
    .FULLCON_OUTPUT_SIZE(8),
    .SCALE_RIGHT(0),
    .SCALE_LEFT(0),
    .C_S00_AXI_DATA_WIDTH(32),
    .C_S00_AXI_ADDR_WIDTH(8)
  ) inst (
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn),
    .s00_axi_awaddr(s00_axi_awaddr),
    .s00_axi_awprot(s00_axi_awprot),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata(s00_axi_wdata),
    .s00_axi_wstrb(s00_axi_wstrb),
    .s00_axi_wvalid(s00_axi_wvalid),
    .s00_axi_wready(s00_axi_wready),
    .s00_axi_bresp(s00_axi_bresp),
    .s00_axi_bvalid(s00_axi_bvalid),
    .s00_axi_bready(s00_axi_bready),
    .s00_axi_araddr(s00_axi_araddr),
    .s00_axi_arprot(s00_axi_arprot),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata(s00_axi_rdata),
    .s00_axi_rresp(s00_axi_rresp),
    .s00_axi_rvalid(s00_axi_rvalid),
    .s00_axi_rready(s00_axi_rready),
    .image_tvalid(image_tvalid),
    .image_tlast(image_tlast),
    .image_tready(image_tready),
    .image_tdata(image_tdata),
    .image_tkeep(image_tkeep),
    .image_tstrb(image_tstrb),
    .weight_tvalid(weight_tvalid),
    .weight_tlast(weight_tlast),
    .weight_tready(weight_tready),
    .weight_tdata(weight_tdata),
    .weight_tkeep(weight_tkeep),
    .weight_tstrb(weight_tstrb),
    .weightfc_tvalid(weightfc_tvalid),
    .weightfc_tlast(weightfc_tlast),
    .weightfc_tready(weightfc_tready),
    .weightfc_tdata(weightfc_tdata),
    .weightfc_tkeep(weightfc_tkeep),
    .weightfc_tstrb(weightfc_tstrb),
    .result_tready(result_tready),
    .result_tvalid(result_tvalid),
    .result_tlast(result_tlast),
    .result_tdata(result_tdata),
    .result_tkeep(result_tkeep),
    .result_tstrb(result_tstrb),
    .cnn_done(cnn_done),
    .cnn_cnt(cnn_cnt)
  );
endmodule
