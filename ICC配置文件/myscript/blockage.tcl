# TO DO: Command for create blockage
# blockage.tcl 
# blockage under power straps. Otherwise routing problem may occur under power straps 
# 创建Blockage，目的基本与上同 
create_placement_blockage -type hard -bbox [list $BLOCK_X0 $BLOCK_Y0 [expr $IO2CORE + $CORE_WIDTH] [expr $IO2CORE + $CORE_HEIGHT]]