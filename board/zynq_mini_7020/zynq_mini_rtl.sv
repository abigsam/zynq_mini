

module zynq_mini_rtl (
    //Input clock 50 MHz
    input  logic PL_CLK_50M,
    //Onboard LEDs andbuttons
    output logic [3:0] PL_LED_tri_o,
    input  logic [1:0] PL_KEY_tri_i,
    //OLED
    output logic OLED_NRST,
    output logic OLED_DC,
    output logic [1:0] OLED_D,
    //EEPROM
    inout  wire EEPROM_scl_io,
    inout  wire EEPROM_sda_io
);

//Default output states
always_comb PL_LED_tri_o <= '0;
always_comb OLED_NRST <= '1;
always_comb OLED_D <= '0;

assign EEPROM_scl_io = 'z;
assign EEPROM_sda_io = 'z;

endmodule