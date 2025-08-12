# Wenxun: disable this rule check to ensure rings and connection will be made
set_preroute_drc_strategy -ignore_discrete_metal_width_rule

create_rectangular_rings -around core -nets GND_SOC -left_segment_layer M4 -right_segment_layer M4 -bottom_segment_layer M3 -top_segment_layer M3 -left_segment_width $POWER_RING_WIDTH -right_segment_width $POWER_RING_WIDTH -bottom_segment_width $POWER_RING_WIDTH -top_segment_width $POWER_RING_WIDTH -left_offset $POWER_RING_PITCH -right_offset $POWER_RING_PITCH -bottom_offset $POWER_RING_PITCH -top_offset $POWER_RING_PITCH -offsets absolute

create_rectangular_rings -around core -nets VDD_SOC -left_segment_layer M4 -right_segment_layer M4 -bottom_segment_layer M3 -top_segment_layer M3 -left_segment_width $POWER_RING_WIDTH -right_segment_width $POWER_RING_WIDTH -bottom_segment_width $POWER_RING_WIDTH -top_segment_width $POWER_RING_WIDTH -left_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -right_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -bottom_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -top_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -offsets absolute

# TO DO: Create your Ring and Straps, must exists rings and straps both.
# e.g. create_power_straps -nets {xxx} -direction vertical -start_at [$POS] -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate [$POS1] -start_high_ends coordinate -start_high_ends_coordinate [$POS2] -layer M4 -extend_low_ends off -extend_high_ends off
create_power_straps -nets VDD_SOC -direction vertical -start_at $POS_START -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate $POS_L -start_high_ends coordinate -start_high_ends_coordinate $POS_H -layer M4 -extend_low_ends off -extend_high_ends off

create_power_straps -nets GND_SOC -direction vertical -start_at $POS_START -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate $POS_L -start_high_ends coordinate -start_high_ends_coordinate $POS_H -layer M4 -extend_low_ends off -extend_high_ends off
