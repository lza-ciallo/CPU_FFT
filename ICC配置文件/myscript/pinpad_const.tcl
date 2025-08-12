#side 1:left,side 2: top 3:right 4:bottom
set_pin_physical_constraints -pin_name sys_clk   -layers {M5}  -side 4
set_pin_physical_constraints -pin_name rstn -layers {M5}  -side 4

set_pin_physical_constraints -pin_name load_en -layers {M5} -side 4
set_pin_physical_constraints -pin_name uart_rx -layers {M5} -side 4
set_pin_physical_constraints -pin_name uart_tx -layers {M5} -side 4
set_pin_physical_constraints -pin_name spi_rstn -layers {M5} -side 4
set_pin_physical_constraints -pin_name cs_n_ext -layers {M5} -side 4
set_pin_physical_constraints -pin_name sclk_ext -layers {M5} -side 4

set_pin_physical_constraints -pin_name cs_n -layers {M5} -side 4
set_pin_physical_constraints -pin_name sclk -layers {M5} -side 4
set_pin_physical_constraints -pin_name spi_do -layers {M5} -side 4

set_pin_physical_constraints -pin_name spi_di -layers {M5} -side 4
set_pin_physical_constraints -pin_name rx_dma_ack -layers {M5} -side 4
set_pin_physical_constraints -pin_name tx_dma_ack -layers {M5} -side 4
set_pin_physical_constraints -pin_name rx_dma_req -layers {M5} -side 4

set_pin_physical_constraints -pin_name tx_dma_req -layers {M5} -side 4
set_pin_physical_constraints -pin_name sda_ext -layers {M5} -side 4
set_pin_physical_constraints -pin_name scl_ext -layers {M5} -side 4
set_pin_physical_constraints -pin_name sda -layers {M5} -side 4
set_pin_physical_constraints -pin_name scl -layers {M5} -side 4

# add pin for inst_write, write_start, inst_wdata
set_pin_physical_constraints -pin_name inst_write -layers {M5} -side 4
set_pin_physical_constraints -pin_name write_start -layers {M5} -side 4
set_pin_physical_constraints -pin_name {inst_wdata[31]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[30]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[29]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[28]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[27]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[26]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[25]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[24]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[23]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[22]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[21]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[20]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[19]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[18]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[17]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[16]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[15]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[14]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[13]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[12]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[11]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[10]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[9]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[8]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[7]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[6]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[5]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[4]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[3]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[2]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[1]} -layers {M5} -side 2
set_pin_physical_constraints -pin_name {inst_wdata[0]} -layers {M5} -side 2
