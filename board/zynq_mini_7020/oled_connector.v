module oled_connector #(
    parameter integer NRST_PIN_NUM = 0,
    parameter integer DC_PIN_NUM  = 1  
) (

    //EMIO pins for reset and DC pin
    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 EMIO_IN TRI_T" *)
    (* X_INTERFACE_MODE = "Slave" *) 
    input  [1:0] emio_tri_t, // Tristate output enable signal (optional)
    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 EMIO_IN TRI_O" *)
    input  [1:0] emio_tri_o, // Tristate output signal (optional)
    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 EMIO_IN TRI_I" *)
    output [1:0] emiom_tri_i, // Tristate input signal (optional)

    //SPI from Zynq PS
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SCK_I" *)
    (* X_INTERFACE_MODE = "Slave" *)
    output sck_i, // SPI Clock Input (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SCK_O" *)
    input  sck_o, // SPI Clock Output (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SCK_T" *)
    input  sck_t, // SPI Clock Tri-State Control (required)

    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO0_I" *)
    output mosi_i, // IO0 Input Port (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO0_O" *)
    input  mosi_o, // IO0 Output Port (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO0_T" *)
    input  mosi_t, // IO0 Tri-State Control (required)

    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO1_I" *)
    output miso_i, // IO1 Input Port (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO1_O" *)
    input  miso_o, // IO1 Output Port (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN IO1_T" *)
    input  miso_t, // IO1 Tri-State Control (required)

    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SS_I" *)
    output ss_i, // Slave Select Input (optional)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SS_O" *)
    input  ss_o, // Slave Select Output (required)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SS_T" *)
    input  ss_t, // Slave Select Tri-State Control (required)

    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SS1_O" *)
    input  ss1_o, // Slave Select 1 Output (optional)
    (* X_INTERFACE_INFO = "xilinx.com:interface:spi:1.0 SPI_IN SS2_O" *)
    input  ss2_o, // Slave Select 2 Output (optional)

    //External connection for OLED
    (* X_INTERFACE_TYPE = "undef" *)
    output OLED_NRST,
    (* X_INTERFACE_TYPE = "undef" *)
    output OLED_DC,
    (* X_INTERFACE_TYPE = "undef" *)
    output [1:0] OLED_D //#D0 acts as SCLK, D1 acts as SDIN
);

//Check input parameters
initial begin
    if (NRST_PIN_NUM == DC_PIN_NUM) begin
        $finish("oled_connector: parameters NRST_PIN_NUM and DC_PIN_NUM cannot be equal");
    end
    if (NRST_PIN_NUM < 0 || NRST_PIN_NUM > 1) begin
        $finish("oled_connector: parameters NRST_PIN_NUM should be in range 0...1 but was set to %0d", NRST_PIN_NUM);
    end
    if (DC_PIN_NUM < 0 || DC_PIN_NUM > 1) begin
        $finish("oled_connector: parameters DC_PIN_NUM should be in range 0...1 but was set to %0d", DC_PIN_NUM);
    end
end

//Connect unused
assign sck_i = sck_o;
assign mosi_i = mosi_o;
assign miso_i = 'b0;
assign ss_i = 'b1;
assign emiom_tri_i = emio_tri_o;

//Connect OLED to the interfaces
assign OLED_NRST = emio_tri_o[NRST_PIN_NUM];
assign OLED_DC   = emio_tri_o[DC_PIN_NUM];
assign OLED_D[0] = sck_o;
assign OLED_D[1] = mosi_o;


endmodule