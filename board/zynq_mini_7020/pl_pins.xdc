# # Clock Signal for PL (50 MHz)
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K17 } [get_ports PL_CLK_50M ]; #IO_L12P_T1_MRCC_35 Sch=PL_CLK_50M
# create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports PL_CLK_50M];


#LED (active high)
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T12 } [get_ports PL_LED_tri_o[0]]; #IO_L2P_T0_34 Sch=FPGA_PL_LED1
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U12 } [get_ports PL_LED_tri_o[1]]; #IO_L2N_T0_34 Sch=FPGA_PL_LED2
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V12 } [get_ports PL_LED_tri_o[2]]; #IO_L4P_T0_34 Sch=FPGA_PL_LED3
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W13 } [get_ports PL_LED_tri_o[3]]; #IO_L4N_T0_34 Sch=FPGA_PL_LED4


#Button (active low)
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M20 } [get_ports PL_KEY_tri_i[0]]; #IO_L7N_T1_AD2N_35 Sch=FPGA_PL_KEY1
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M19 } [get_ports PL_KEY_tri_i[1]]; #IO_L7P_T1_AD2P_35 Sch=FPGA_PL_KEY2


#OLED OLED12864
#Size: 0.96"
#128x64 Dot Matrix
#Built-in controller SSD1306 (https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf)
#BS[2:0] = 3'b000, configured as 4-wire Serial interface
#D0 acts as SCLK, D1 acts as SDIN
#OLED_DC is for D/#C pin: low level for "write command", high level for "write data"
#SDIN is shifted into an 8-bit shift register on every rising edge of SCLK
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F17 } [get_ports OLED_NRST]; #IO_L6N_T0_VREF_35 Sch=OLED_RST
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F16 } [get_ports OLED_DC]; #IO_L6P_T0_35 Sch=OLED_DC
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E18 } [get_ports OLED_D[0]]; #IO_L5P_T0_AD9P_35 Sch=OLED_D0
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E19 } [get_ports OLED_D[1]]; #IO_L5N_T0_AD9N_35 Sch=OLED_D1


#I2C EEPROM
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F19 } [get_ports EEPROM_scl_io]; #IO_L15P_T2_DQS_AD12P_35 Sch=FPGA_I2C_SCL2
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F20 } [get_ports EEPROM_sda_io]; #IO_L15N_T2_DQS_AD12N_35 Sch=FPGA_I2C_SDA2


##----------------------------------------------------------------------------------+------------------+-----+
## CAM1 (BANK34, 3V3)                                                               |        Net       | Pin |
##----------------------------------------------------------------------------------+------------------+-----+
# #                                                                                   # GND              |   1 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U15} [get_ports CAM[0]];       # FPGA_GPIO_11N_34 |   2 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W15} [get_ports CAM[1]];       # FPGA_GPIO_10N_34 |   3 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U17} [get_ports CAM[2]];       # FPGA_GPIO_9N_34  |   4 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V18} [get_ports CAM[3]];       # FPGA_GPIO_21N_34 |   5 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W18} [get_ports CAM[4]];       # FPGA_GPIO_22P_34 |   6 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U19} [get_ports CAM[5]];       # FPGA_GPIO_12N_34 |   7 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U14} [get_ports CAM[6]];       # FPGA_GPIO_11P_34 |   8 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN Y14} [get_ports CAM[7]];       # FPGA_GPIO_8N_34  |   9 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V16} [get_ports CAM[8]];       # FPGA_GPIO_18P_34 |  10 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U18} [get_ports CAM[9]];       # FPGA_GPIO_12P_34 |  11 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T17} [get_ports CAM[10]];      # FPGA_GPIO_20P_34 |  12 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R17} [get_ports CAM[11]];      # FPGA_GPIO_19N_34 |  13 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W20} [get_ports CAM[12]];      # FPGA_GPIO_16N_34 |  14 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V20} [get_ports CAM[13]];      # FPGA_GPIO_16P_34 |  15 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U20} [get_ports CAM[14]];      # FPGA_GPIO_15N_34 |  16 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T20} [get_ports CAM[15]];      # FPGA_GPIO_15P_34 |  17 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P20} [get_ports CAM[16]];      # FPGA_GPIO_14N_34 |  18 |
# #                                                                                   # GND              |  19 |
# #                                                                                   # VCC_3V3          |  20 |
# #
# #                                                                                   # VCC5.0           |  40 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P15} [get_ports CAM[33]];      # FPGA_GPIO_24P_34 |  39 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V15} [get_ports CAM[32]];      # FPGA_GPIO_10P_34 |  38 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V17} [get_ports CAM[31]];      # FPGA_GPIO_21P_34 |  37 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN Y18} [get_ports CAM[30]];      # FPGA_GPIO_17P_34 |  36 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN Y19} [get_ports CAM[29]];      # FPGA_GPIO_17N_34 |  35 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W19} [get_ports CAM[28]];      # FPGA_GPIO_22N_34 |  34 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N17} [get_ports CAM[27]];      # FPGA_GPIO_23P_34 |  33 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W14} [get_ports CAM[26]];      # FPGA_GPIO_8P_34  |  32 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P16} [get_ports CAM[25]];      # FPGA_GPIO_24N_34 |  31 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R16} [get_ports CAM[24]];      # FPGA_GPIO_19P_34 |  30 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T16} [get_ports CAM[23]];      # FPGA_GPIO_9P_34  |  29 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W16} [get_ports CAM[22]];      # FPGA_GPIO_18N_34 |  28 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R18} [get_ports CAM[21]];      # FPGA_GPIO_20N_34 |  27 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P19} [get_ports CAM[20]];      # FPGA_GPIO_13N_34 |  26 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P18} [get_ports CAM[19]];      # FPGA_GPIO_23N_34 |  25 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N18} [get_ports CAM[18]];      # FPGA_GPIO_13P_34 |  24 |
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N20} [get_ports CAM[17]];      # FPGA_GPIO_14P_34 |  23 |
# #                                                                                   # GND              |  22 |
# #                                                                                   # VCC_3V3          |  21 |


#HDMI
#BANK35 VCC=3.3V
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN Р17} [get_ports HDMI_CLK_N];    #IO_L13N_T2_MRCC_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN H16} [get_ports HDMI_CLK_P];    #IO_L13N_T2_MRCC_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN D20} [get_ports HDMI_DATA0_N];  #IO_L4N_T0_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN D19} [get_ports HDMI_DATA0_P];  #IO_L4P_T0_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN B20} [get_ports HDMI_DATA1_N];  #IO_L1N_T0_AD0N_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN C20} [get_ports HDMI_DATA1_P];  #IO_L1P_T0_AD0P_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN A20} [get_ports HDMI_DATA2_N];  #IO_L2N_T0_AD8N_35
# set_property -dict {IOSTANDART TMDS_33 PACKAGE_PIN B19} [get_ports HDMI_DATA2_P];  #IO_L2P_T0_AD8P_35
# #Control +5V output in HDMI connector
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H18} [get_ports HDMI_OUT_EN]; #IO_L14N_T2_AD4N_SRCC_35, HIGH enabled, LOW/HiZ disabled

#Ethernet PHY (RTL8211E-VB)
#BANK35 VCC=3.3V
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L20} [get_ports PHY_RXD0_PL];      #IO_L9N_T1_DQS_AD3N_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K19} [get_ports PHY_RXD1_PL];      #IO_L10P_T1_AD11P_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J19} [get_ports PHY_TXD1_PL];      #IO_L10N_T1_AD11N_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L16} [get_ports PHY_RX_CLK_PL];    #IO_L11P_T1_SRCC_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L17} [get_ports PHY_RXCTL_PL];     #IO_L11N_T1_SRCC_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J18} [get_ports PHY_RXD2_PL];      #IO_L14P_T2_AD4P_SRCC_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G17} [get_ports PHY_nRST_PL];      #IO_L16P_T2_35, LOW reset, HIGH/HiZ normal
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G18} [get_ports PHY_MDC_PL];       #IO_L16N_T2_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J20} [get_ports PHY_RXD3_PL];      #IO_L17P_T2_AD5P_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H20} [get_ports PHY_TXD2_PL];      #IO_L17N_T2_AD5N_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G19} [get_ports PHY_MDIO_PL];      #IO_L18P_T2_AD13P_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K14} [get_ports PHY_TXCTL_PL];     #IO_L20P_T3_AD6P_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J14} [get_ports PHY_TX_CLK_PL];    #IO_L20N_T3_AD6N_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N15} [get_ports PHY_TXD3_PL];      #IO_L21P_T3_DQS_AD14P_35
# set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N16} [get_ports PHY_TXD0_PL];      #IO_L21N_T3_DQS_AD14N_35





