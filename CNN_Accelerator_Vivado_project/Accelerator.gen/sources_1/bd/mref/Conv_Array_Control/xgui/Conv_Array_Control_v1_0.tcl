# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Conv_Kernel_Num" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Conv_Kernel_Size" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Data_width" -parent ${Page_0}


}

proc update_PARAM_VALUE.Conv_Kernel_Num { PARAM_VALUE.Conv_Kernel_Num } {
	# Procedure called to update Conv_Kernel_Num when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Conv_Kernel_Num { PARAM_VALUE.Conv_Kernel_Num } {
	# Procedure called to validate Conv_Kernel_Num
	return true
}

proc update_PARAM_VALUE.Conv_Kernel_Size { PARAM_VALUE.Conv_Kernel_Size } {
	# Procedure called to update Conv_Kernel_Size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Conv_Kernel_Size { PARAM_VALUE.Conv_Kernel_Size } {
	# Procedure called to validate Conv_Kernel_Size
	return true
}

proc update_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to update Data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to validate Data_width
	return true
}


proc update_MODELPARAM_VALUE.Data_width { MODELPARAM_VALUE.Data_width PARAM_VALUE.Data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_width}] ${MODELPARAM_VALUE.Data_width}
}

proc update_MODELPARAM_VALUE.Conv_Kernel_Size { MODELPARAM_VALUE.Conv_Kernel_Size PARAM_VALUE.Conv_Kernel_Size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Conv_Kernel_Size}] ${MODELPARAM_VALUE.Conv_Kernel_Size}
}

proc update_MODELPARAM_VALUE.Conv_Kernel_Num { MODELPARAM_VALUE.Conv_Kernel_Num PARAM_VALUE.Conv_Kernel_Num } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Conv_Kernel_Num}] ${MODELPARAM_VALUE.Conv_Kernel_Num}
}

