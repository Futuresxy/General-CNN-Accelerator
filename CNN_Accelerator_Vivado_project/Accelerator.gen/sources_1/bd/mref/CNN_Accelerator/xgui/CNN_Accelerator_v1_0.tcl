# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CONV_KERNEL_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CONV_KERNEL_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FULLCON_INPUT_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FULLCON_OUTPUT_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POOL_KERNEL_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "POOL_KERNEL_SIZE" -parent ${Page_0}


}

proc update_PARAM_VALUE.CONV_KERNEL_NUM { PARAM_VALUE.CONV_KERNEL_NUM } {
	# Procedure called to update CONV_KERNEL_NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CONV_KERNEL_NUM { PARAM_VALUE.CONV_KERNEL_NUM } {
	# Procedure called to validate CONV_KERNEL_NUM
	return true
}

proc update_PARAM_VALUE.CONV_KERNEL_SIZE { PARAM_VALUE.CONV_KERNEL_SIZE } {
	# Procedure called to update CONV_KERNEL_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CONV_KERNEL_SIZE { PARAM_VALUE.CONV_KERNEL_SIZE } {
	# Procedure called to validate CONV_KERNEL_SIZE
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.FULLCON_INPUT_SIZE { PARAM_VALUE.FULLCON_INPUT_SIZE } {
	# Procedure called to update FULLCON_INPUT_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FULLCON_INPUT_SIZE { PARAM_VALUE.FULLCON_INPUT_SIZE } {
	# Procedure called to validate FULLCON_INPUT_SIZE
	return true
}

proc update_PARAM_VALUE.FULLCON_OUTPUT_SIZE { PARAM_VALUE.FULLCON_OUTPUT_SIZE } {
	# Procedure called to update FULLCON_OUTPUT_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FULLCON_OUTPUT_SIZE { PARAM_VALUE.FULLCON_OUTPUT_SIZE } {
	# Procedure called to validate FULLCON_OUTPUT_SIZE
	return true
}

proc update_PARAM_VALUE.POOL_KERNEL_NUM { PARAM_VALUE.POOL_KERNEL_NUM } {
	# Procedure called to update POOL_KERNEL_NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POOL_KERNEL_NUM { PARAM_VALUE.POOL_KERNEL_NUM } {
	# Procedure called to validate POOL_KERNEL_NUM
	return true
}

proc update_PARAM_VALUE.POOL_KERNEL_SIZE { PARAM_VALUE.POOL_KERNEL_SIZE } {
	# Procedure called to update POOL_KERNEL_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.POOL_KERNEL_SIZE { PARAM_VALUE.POOL_KERNEL_SIZE } {
	# Procedure called to validate POOL_KERNEL_SIZE
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.CONV_KERNEL_SIZE { MODELPARAM_VALUE.CONV_KERNEL_SIZE PARAM_VALUE.CONV_KERNEL_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CONV_KERNEL_SIZE}] ${MODELPARAM_VALUE.CONV_KERNEL_SIZE}
}

proc update_MODELPARAM_VALUE.CONV_KERNEL_NUM { MODELPARAM_VALUE.CONV_KERNEL_NUM PARAM_VALUE.CONV_KERNEL_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CONV_KERNEL_NUM}] ${MODELPARAM_VALUE.CONV_KERNEL_NUM}
}

proc update_MODELPARAM_VALUE.POOL_KERNEL_SIZE { MODELPARAM_VALUE.POOL_KERNEL_SIZE PARAM_VALUE.POOL_KERNEL_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POOL_KERNEL_SIZE}] ${MODELPARAM_VALUE.POOL_KERNEL_SIZE}
}

proc update_MODELPARAM_VALUE.POOL_KERNEL_NUM { MODELPARAM_VALUE.POOL_KERNEL_NUM PARAM_VALUE.POOL_KERNEL_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.POOL_KERNEL_NUM}] ${MODELPARAM_VALUE.POOL_KERNEL_NUM}
}

proc update_MODELPARAM_VALUE.FULLCON_INPUT_SIZE { MODELPARAM_VALUE.FULLCON_INPUT_SIZE PARAM_VALUE.FULLCON_INPUT_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FULLCON_INPUT_SIZE}] ${MODELPARAM_VALUE.FULLCON_INPUT_SIZE}
}

proc update_MODELPARAM_VALUE.FULLCON_OUTPUT_SIZE { MODELPARAM_VALUE.FULLCON_OUTPUT_SIZE PARAM_VALUE.FULLCON_OUTPUT_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FULLCON_OUTPUT_SIZE}] ${MODELPARAM_VALUE.FULLCON_OUTPUT_SIZE}
}

