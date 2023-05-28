proc create_bd {constr_path} {
    set bd_name "design_1"
    
    #Add ZYNQ PS **********************************************************************************
    create_bd_design ${bd_name}
    set ps_ip [create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 "proc_sys"]
    #Configure ZYNQ
    set_property -dict [apply_preset ${ps_ip}] [get_bd_cells ${ps_ip}]; #From presets
    #External ZYNQ IOs
    apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {\
        make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" } \
    [get_bd_cells ${ps_ip}]
    save_bd_design
    

    #User code ************************************************************************************



    #Validate *************************************************************************************
    validate_bd_design
    save_bd_design

    #Make wrapper *********************************************************************************
    set wrapper_path [make_wrapper -fileset sources_1 -files [ get_files -norecurse ${bd_name}.bd] -top]
    add_files -norecurse -fileset sources_1 ${wrapper_path}
    return [file tail ${wrapper_path}]; #Return wrapper file name
}