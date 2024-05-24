# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S01_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S01_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_HORIZONTAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_VERTICAL" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KERNEL_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PARA_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STRIDE" -parent ${Page_0}


}

proc update_PARAM_VALUE.AXIS_TDATA_WIDTH { PARAM_VALUE.AXIS_TDATA_WIDTH } {
	# Procedure called to update AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.AXIS_TDATA_WIDTH { PARAM_VALUE.AXIS_TDATA_WIDTH } {
	# Procedure called to validate AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S01_AXI_ADDR_WIDTH { PARAM_VALUE.C_S01_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S01_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S01_AXI_ADDR_WIDTH { PARAM_VALUE.C_S01_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S01_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S01_AXI_DATA_WIDTH { PARAM_VALUE.C_S01_AXI_DATA_WIDTH } {
	# Procedure called to update C_S01_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S01_AXI_DATA_WIDTH { PARAM_VALUE.C_S01_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S01_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_HORIZONTAL { PARAM_VALUE.DATA_HORIZONTAL } {
	# Procedure called to update DATA_HORIZONTAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_HORIZONTAL { PARAM_VALUE.DATA_HORIZONTAL } {
	# Procedure called to validate DATA_HORIZONTAL
	return true
}

proc update_PARAM_VALUE.DATA_VERTICAL { PARAM_VALUE.DATA_VERTICAL } {
	# Procedure called to update DATA_VERTICAL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_VERTICAL { PARAM_VALUE.DATA_VERTICAL } {
	# Procedure called to validate DATA_VERTICAL
	return true
}

proc update_PARAM_VALUE.KERNEL_SIZE { PARAM_VALUE.KERNEL_SIZE } {
	# Procedure called to update KERNEL_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.KERNEL_SIZE { PARAM_VALUE.KERNEL_SIZE } {
	# Procedure called to validate KERNEL_SIZE
	return true
}

proc update_PARAM_VALUE.PARA_DATA_WIDTH { PARAM_VALUE.PARA_DATA_WIDTH } {
	# Procedure called to update PARA_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PARA_DATA_WIDTH { PARAM_VALUE.PARA_DATA_WIDTH } {
	# Procedure called to validate PARA_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.STRIDE { PARAM_VALUE.STRIDE } {
	# Procedure called to update STRIDE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STRIDE { PARAM_VALUE.STRIDE } {
	# Procedure called to validate STRIDE
	return true
}


proc update_MODELPARAM_VALUE.KERNEL_SIZE { MODELPARAM_VALUE.KERNEL_SIZE PARAM_VALUE.KERNEL_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KERNEL_SIZE}] ${MODELPARAM_VALUE.KERNEL_SIZE}
}

proc update_MODELPARAM_VALUE.DATA_HORIZONTAL { MODELPARAM_VALUE.DATA_HORIZONTAL PARAM_VALUE.DATA_HORIZONTAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_HORIZONTAL}] ${MODELPARAM_VALUE.DATA_HORIZONTAL}
}

proc update_MODELPARAM_VALUE.DATA_VERTICAL { MODELPARAM_VALUE.DATA_VERTICAL PARAM_VALUE.DATA_VERTICAL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_VERTICAL}] ${MODELPARAM_VALUE.DATA_VERTICAL}
}

proc update_MODELPARAM_VALUE.STRIDE { MODELPARAM_VALUE.STRIDE PARAM_VALUE.STRIDE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STRIDE}] ${MODELPARAM_VALUE.STRIDE}
}

proc update_MODELPARAM_VALUE.PARA_DATA_WIDTH { MODELPARAM_VALUE.PARA_DATA_WIDTH PARAM_VALUE.PARA_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PARA_DATA_WIDTH}] ${MODELPARAM_VALUE.PARA_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S01_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S01_AXI_DATA_WIDTH PARAM_VALUE.C_S01_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S01_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S01_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S01_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S01_AXI_ADDR_WIDTH PARAM_VALUE.C_S01_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S01_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S01_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.AXIS_TDATA_WIDTH { MODELPARAM_VALUE.AXIS_TDATA_WIDTH PARAM_VALUE.AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.AXIS_TDATA_WIDTH}
}

