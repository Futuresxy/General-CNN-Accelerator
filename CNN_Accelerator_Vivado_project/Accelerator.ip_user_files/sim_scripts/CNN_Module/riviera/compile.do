vlib work
vlib riviera

vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xil_defaultlib
vlib riviera/axis_infrastructure_v1_1_0
vlib riviera/axis_data_fifo_v2_0_8

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib
vmap axis_infrastructure_v1_1_0 riviera/axis_infrastructure_v1_1_0
vmap axis_data_fifo_v2_0_8 riviera/axis_data_fifo_v2_0_8

vlog -work xilinx_vip  -sv2k12 "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"F:/Xilinx/Vivado/2022.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -sv2k12 "+incdir+../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl" "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"F:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"F:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"F:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"F:/Xilinx/Vivado/2022.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl" "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/CNN_Module/ip/CNN_Module_CNN_Control_1_0/sim/CNN_Module_CNN_Control_1_0.v" \

vlog -work axis_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl" "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl/axis_infrastructure_v1_1_vl_rfs.v" \

vlog -work axis_data_fifo_v2_0_8  -v2k5 "+incdir+../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl" "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/0bd2/hdl/axis_data_fifo_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Accelerator.gen/sources_1/bd/CNN_Module/ipshared/8713/hdl" "+incdir+F:/Xilinx/Vivado/2022.1/data/xilinx_vip/include" \
"../../../bd/CNN_Module/ip/CNN_Module_INACT_DATA_FIFO_0/sim/CNN_Module_INACT_DATA_FIFO_0.v" \
"../../../bd/CNN_Module/ip/CNN_Module_PICTURE_DATA_FIFO_0/sim/CNN_Module_PICTURE_DATA_FIFO_0.v" \
"../../../bd/CNN_Module/ip/CNN_Module_RESULT_DATA_FIFO1_0/sim/CNN_Module_RESULT_DATA_FIFO1_0.v" \
"../../../bd/CNN_Module/ip/CNN_Module_WEIGHT_CONV_ACT_FULLCON_FIFO_0/sim/CNN_Module_WEIGHT_CONV_ACT_FULLCON_FIFO_0.v" \
"../../../bd/CNN_Module/ip/CNN_Module_WEIGHT_FULLCON_FIFO_0/sim/CNN_Module_WEIGHT_FULLCON_FIFO_0.v" \
"../../../bd/CNN_Module/ip/CNN_Module_Windows_Data_Convert_0_0/sim/CNN_Module_Windows_Data_Convert_0_0.v" \
"../../../bd/CNN_Module/sim/CNN_Module.v" \

vlog -work xil_defaultlib \
"glbl.v"

