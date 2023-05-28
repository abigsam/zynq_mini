# Clock Signal for PL (50 MHz)
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K17 } [get_ports PL_CLK_50M ]; #IO_L12P_T1_MRCC_35 Sch=PL_CLK_50M
create_clock -add -name sys_clk_pin -period 20.00 -waveform {0 10} [get_ports PL_CLK_50M];


#LED (active high)
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T12 } [get_ports PL_LED[0]]; #IO_L2P_T0_34 Sch=FPGA_PL_LED1
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U12 } [get_ports PL_LED[1]]; #IO_L2N_T0_34 Sch=FPGA_PL_LED2
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V12 } [get_ports PL_LED[2]]; #IO_L4P_T0_34 Sch=FPGA_PL_LED3
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W13 } [get_ports PL_LED[3]]; #IO_L4N_T0_34 Sch=FPGA_PL_LED4


#Button (active low)
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M20 } [get_ports PL_KEY[0]]; #IO_L7N_T1_AD2N_35 Sch=FPGA_PL_KEY1
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M19 } [get_ports PL_KEY[1]]; #IO_L7P_T1_AD2P_35 Sch=FPGA_PL_KEY2


#OLED OLED12864
#Size: 0.96"
#128x64 Dot Matrix
#Built-in controller SSD1306 (https://cdn-shop.adafruit.com/datasheets/SSD1306.pdf)
#BS[2:0] = 3'b000, configured as 4-wire Serial interface
#D0 acts as SCLK, D1 acts as SDIN
#OLED_DC is for D/#C pin: low level for "write command", high level for "write data"
#SDIN is shifted into an 8-bit shift register on every rising edge of SCLK
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F17 } [get_ports OLED_RST]; #IO_L6N_T0_VREF_35 Sch=OLED_RST
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F16 } [get_ports OLED_DC]; #IO_L6P_T0_35 Sch=OLED_DC
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E18 } [get_ports OLED_D[0]]; #IO_L5P_T0_AD9P_35 Sch=OLED_D0
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E19 } [get_ports OLED_D[1]]; #IO_L5N_T0_AD9N_35 Sch=OLED_D1


#I2C EEPROM
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F19 } [get_ports EEPROM_SCL]; #IO_L15P_T2_DQS_AD12P_35 Sch=FPGA_I2C_SCL2
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F20 } [get_ports EEPROM_SDA]; #IO_L15N_T2_DQS_AD12N_35 Sch=FPGA_I2C_SDA2


##--------------------------------------------------------------------------------------+-----------+---------+
## CAM1 (BANK34, 3V3)                                                                   |     Net   |  Conn.  |
##--------------------------------------------------------------------------------------+-----------+---------+
#TBD

#HDMI
#TBD

#Ethernet PHY (RTL8211E-VB)
#TBD
