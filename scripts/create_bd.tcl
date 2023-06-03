proc create_bd {board_path} {
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
    #Set AXI variables
    set ps_axi_clk_config "${ps_ip}/FCLK_CLK0 (100 MHz)"
    set ps_axi_mst_name   "${ps_ip}/M_AXI_GP0"
    save_bd_design
    

    #User code ************************************************************************************
    #Add AXI GPIO to control onboard LEDs and buttons
    set gpio_pl_ip [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_pl]
    set_property -dict [list \
        CONFIG.C_GPIO_WIDTH {4} \
        CONFIG.C_GPIO2_WIDTH {2} \
        CONFIG.C_IS_DUAL {1} \
        CONFIG.C_ALL_INPUTS_2 {1} \
        CONFIG.C_ALL_OUTPUTS {1} \
    ] [get_bd_cells ${gpio_pl_ip}]
    #Connect LEDs and buttons
    connect_bd_intf_net [get_bd_intf_pins ${gpio_pl_ip}/GPIO] [get_bd_intf_ports [create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_LED]]
    connect_bd_intf_net [get_bd_intf_pins ${gpio_pl_ip}/GPIO2] [get_bd_intf_ports [create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 PL_KEY]]
    save_bd_design

    #Connect PS IIC to the onboard EEPROM
    connect_bd_intf_net [get_bd_intf_pins ${ps_ip}/IIC_0] [get_bd_intf_ports [create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 EEPROM]]
    save_bd_design

    #Connect PS SPI and EMIO to control onboard OLED
    add_files -norecurse ${board_path}/oled_connector.v
    update_compile_order -fileset sources_1
    set oled_conn_ip [create_bd_cell -type module -reference oled_connector oled_connector]
    connect_bd_intf_net [get_bd_intf_pins ${oled_conn_ip}/SPI_IN]  [get_bd_intf_pins ${ps_ip}/SPI_0]
    connect_bd_intf_net [get_bd_intf_pins ${oled_conn_ip}/EMIO_IN] [get_bd_intf_pins ${ps_ip}/GPIO_0]
    #Connect
    connect_bd_net [get_bd_pins ${oled_conn_ip}/OLED_NRST] [get_bd_ports [create_bd_port -dir O -type rst OLED_NRST]]
    connect_bd_net [get_bd_pins ${oled_conn_ip}/OLED_DC]   [get_bd_ports [create_bd_port -dir O OLED_DC]]
    connect_bd_net [get_bd_pins ${oled_conn_ip}/OLED_D]    [get_bd_ports [create_bd_port -dir O -from 1 -to 0 OLED_D]]
    save_bd_design

    #Connect AXI lite slaves
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config "\
        Clk_master {${ps_axi_clk_config}} \
        Clk_slave {${ps_axi_clk_config}} \
        Clk_xbar {${ps_axi_clk_config}} \
        Master {${ps_axi_mst_name}} \
        Slave {${gpio_pl_ip}/S_AXI} \
        ddr_seg {Auto} \
        intc_ip {New AXI Interconnect} \
        master_apm {0}"\
    [get_bd_intf_pins ${gpio_pl_ip}/S_AXI]
    save_bd_design



    #Validate *************************************************************************************
    validate_bd_design
    save_bd_design

    #Make wrapper *********************************************************************************
    set wrapper_path [make_wrapper -fileset sources_1 -files [ get_files -norecurse ${bd_name}.bd] -top]
    add_files -norecurse -fileset sources_1 ${wrapper_path}
    return [file tail ${wrapper_path}]; #Return wrapper file name
}