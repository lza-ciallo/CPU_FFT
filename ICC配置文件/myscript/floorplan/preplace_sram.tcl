# TO DO: command for preplace sram
# 脚本：preplace_sram.tcl 
# unfix and unplace SRAM 
set_undoable_attribute [get_cells -all x_data_sram/i_sram_block ] is_fixed {0} 
set_undoable_attribute [get_cells -all x_data_sram/i_sram_block ] is_placed {0} 
# 将指令SRAM放置在指定坐标上，需要在setup中修改对应的参数以调整位置 
move_objects -x $DATA_SRAM_X -y $DATA_SRAM_Y x_data_sram/i_sram_block 
# 连接vdd，vss 
preroute_instances -connect_instances specified -cells x_data_sram/i_sram_block-select_net_by_type pg -target_directions four_sides -skip_bottom_side -primary_routing_layer specified -specified_horizontal_layer M3 -specified_vertical_layer M4 
# 宏模块之间和宏模块-边界之间不要放置标准单元，预留足够的布线通道  
set_keepout_margin -type hard -outer {$DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH} x_data_sram/i_sram_block