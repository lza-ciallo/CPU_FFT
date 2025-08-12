# Wenxun: to do
# un-fix and un-place sram
set_undoable_attribute [get_cells -all x_data_sram/i_sram_block ] is_fixed {0}
set_undoable_attribute [get_cells -all x_data_sram/i_sram_block ] is_placed {0}
set_undoable_attribute [get_cells -all x_isram_ahbl/i_sram_block] is_fixed {0}
set_undoable_attribute [get_cells -all x_isram_ahbl/i_sram_block] is_placed {0}

# move
# Wenxun : to do
move_objects -x $DATA_SRAM_X -y $DATA_SRAM_Y x_data_sram/i_sram_block
move_objects -x $INST_SRAM_X -y $INST_SRAM_Y x_isram_ahbl/i_sram_block

# connect vdd,vss
preroute_instances -connect_instances specified -cells x_data_sram/i_sram_block -select_net_by_type pg -target_directions four_sides -skip_bottom_side -primary_routing_layer specified -specified_horizontal_layer M3 -specified_vertical_layer M4

preroute_instances -connect_instances specified -cells x_isram_ahbl/i_sram_block -select_net_by_type pg -target_directions four_sides -skip_bottom_side -primary_routing_layer specified -specified_horizontal_layer M3 -specified_vertical_layer M4

# sram padding
set_keepout_margin -type hard -outer {$DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH $DATA_SRAM_KEEPOUT_WIDTH} x_data_sram/i_sram_block

set_keepout_margin -type hard -outer {$INST_SRAM_KEEPOUT_WIDTH $INST_SRAM_KEEPOUT_WIDTH $INST_SRAM_KEEPOUT_WIDTH $INST_SRAM_KEEPOUT_WIDTH} x_isram_ahbl/i_sram_block

