# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Data_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Relu_Num" -parent ${Page_0}


}

proc update_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to update Data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to validate Data_width
	return true
}

proc update_PARAM_VALUE.Relu_Num { PARAM_VALUE.Relu_Num } {
	# Procedure called to update Relu_Num when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Relu_Num { PARAM_VALUE.Relu_Num } {
	# Procedure called to validate Relu_Num
	return true
}


proc update_MODELPARAM_VALUE.Data_width { MODELPARAM_VALUE.Data_width PARAM_VALUE.Data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_width}] ${MODELPARAM_VALUE.Data_width}
}

proc update_MODELPARAM_VALUE.Relu_Num { MODELPARAM_VALUE.Relu_Num PARAM_VALUE.Relu_Num } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Relu_Num}] ${MODELPARAM_VALUE.Relu_Num}
}

