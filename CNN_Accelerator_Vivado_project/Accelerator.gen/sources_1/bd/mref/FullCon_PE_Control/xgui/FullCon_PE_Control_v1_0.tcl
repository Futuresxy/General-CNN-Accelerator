# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "Data_horizontal" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Data_vertical" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Data_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OutData_width" -parent ${Page_0}
  ipgui::add_param $IPINST -name "Output_channel" -parent ${Page_0}


}

proc update_PARAM_VALUE.Data_horizontal { PARAM_VALUE.Data_horizontal } {
	# Procedure called to update Data_horizontal when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_horizontal { PARAM_VALUE.Data_horizontal } {
	# Procedure called to validate Data_horizontal
	return true
}

proc update_PARAM_VALUE.Data_vertical { PARAM_VALUE.Data_vertical } {
	# Procedure called to update Data_vertical when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_vertical { PARAM_VALUE.Data_vertical } {
	# Procedure called to validate Data_vertical
	return true
}

proc update_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to update Data_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Data_width { PARAM_VALUE.Data_width } {
	# Procedure called to validate Data_width
	return true
}

proc update_PARAM_VALUE.OutData_width { PARAM_VALUE.OutData_width } {
	# Procedure called to update OutData_width when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OutData_width { PARAM_VALUE.OutData_width } {
	# Procedure called to validate OutData_width
	return true
}

proc update_PARAM_VALUE.Output_channel { PARAM_VALUE.Output_channel } {
	# Procedure called to update Output_channel when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.Output_channel { PARAM_VALUE.Output_channel } {
	# Procedure called to validate Output_channel
	return true
}


proc update_MODELPARAM_VALUE.Data_width { MODELPARAM_VALUE.Data_width PARAM_VALUE.Data_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_width}] ${MODELPARAM_VALUE.Data_width}
}

proc update_MODELPARAM_VALUE.OutData_width { MODELPARAM_VALUE.OutData_width PARAM_VALUE.OutData_width } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OutData_width}] ${MODELPARAM_VALUE.OutData_width}
}

proc update_MODELPARAM_VALUE.Data_horizontal { MODELPARAM_VALUE.Data_horizontal PARAM_VALUE.Data_horizontal } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_horizontal}] ${MODELPARAM_VALUE.Data_horizontal}
}

proc update_MODELPARAM_VALUE.Data_vertical { MODELPARAM_VALUE.Data_vertical PARAM_VALUE.Data_vertical } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Data_vertical}] ${MODELPARAM_VALUE.Data_vertical}
}

proc update_MODELPARAM_VALUE.Output_channel { MODELPARAM_VALUE.Output_channel PARAM_VALUE.Output_channel } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.Output_channel}] ${MODELPARAM_VALUE.Output_channel}
}

