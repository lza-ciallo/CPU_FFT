# CPU+FFT Project #

## 进度安排 ##

- [x] 整理文件结构 ......8.8
- [x] 跑通 gcc 编译链 ......8.9
- [x] 重新设计 FFT8 ......8.10
- [x] 本地 Vivado 跑通单周期 CPU+FFT8 ......8.10
- [x] 调整 gcc 适应流水线 FFT8 ......8.10
- [x] 虚拟机内跑通行为级仿真 ......8.10
- [x] DC ......8.11
- [ ] ICC ......8.1
- [ ] PT
- [ ] 写 FFT16 汇编代码

### soc_ahblite 文件结构 ###

``` tcl
soc_ahblite
├── sub_system
│   └── ibex_core
│       ├── prim_clock_gating
│       ├── ibex_if_stage
│       │   ├── ibex_icache
│       │   │   ├── prim_secded_28_22_enc
│       │   │   ├── prim_secded_72_64_enc
│       │   │   ├── prim_ram_1p *2
│       │   │   ├── prim_secded_28_22_dec
│       │   │   └── prim_secded_72_64_dec
│       │   ├── ibex_prefetch_buffer
│       │   │   └── ibex_fetch_fifo
│       │   ├── ibex_dummy_instr
│       │   │   └── prim_lfsr
│       │   ├── ibex_branch_predict
│       │   └── ibex_compressed_decoder
│       ├── ibex_id_stage
│       │   ├── ibex_decoder
│       │   └── ibex_controller
│       ├── ibex_ex_block
│       │   ├── ibex_alu
│       │   ├── ibex_muldiv_slow
│       │   └── ibex_muldiv_fast
│       ├── ibex_load_store_unit
│       ├── ibex_wb_stage
│       ├── prim_secded_39_32_ecc
│       ├── prim_secded_39_32_dec *2
│       ├── ibex_register_file_ff
│       ├── ibex_register_file_fpga
│       ├── ibex_register_file_latch
│       ├── ibex_cs_registers
│       │   └── ibex_csr *21
│       └── ibex_pmp
├── ahblite
│   └── decoder
├── data_sram
├── fft8_top
│   └── <...>
├── inst_sram
└── rom
    └── rom_32x64
```

### VCS 前仿 ###

``` tcl
1.  配置 filelist
2.  make vcs_run
3.  make verdi (以上两步 = make all)
4.  'Get Signals' 添加波形
```

### DC 综合 ###

``` tcl
1.  修改 rtl_source_files.tcl, 加入除库文件以外的 filelist
2.  修改 compile.tcl 的 DESIGN_NAME, stdCell_path, link_library
3.  sh clean; sh compile.sh
4.  检查 soc_ahblite.rpt
```

### ICC 版图布局 ###

``` tcl
1.  关联 DC 综合结果
2.  修改 tcl 文件
3.  make outputs_icc
4.  检查 reports
```

``` tcl
# common_setup.tcl

set DESIGN_NAME                   "soc_ahblite"  ;#  The name of the top-level design

set DESIGN_REF_DATA_PATH          "/home/master/Project"  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path  
                                       #  to the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical 
                                       #  reference methodology flow.
```

``` tcl
# icc_setup.tcl

## TO DO: Set your own height/width/io2core/ring_w/ring_p
set CORE_WIDTH 450
set CORE_HEIGHT 800
set IO2CORE 40
set POWER_RING_WIDTH 10
set POWER_RING_PITCH 5
set POS_START 265
set POS_L 591
set POS_H 871


## TO DO: Set your Macro Pos
## e.g. set DATA_SRAM_X 45
set DATA_SRAM_X 60
set DATA_SRAM_Y 610
set INST_SRAM_X 290
set INST_SRAM_Y 610

## TO DO: Set Macro Keepout width
## e.g. set DATA_SRAM_KEEPOUT_WIDTH 0.5
set DATA_SRAM_KEEPOUT_WIDTH 0.5
set INST_SRAM_KEEPOUT_WIDTH 0.5

## TO DO: Set Block Pos for Macro
## revise BLOCK_X0,BLOCK_Y0,...
set BLOCK_X0 50
set BLOCK_Y0 600 
set BLOCK_X1 480
set BLOCK_Y1 840 
```

``` tcl
# blockage.tcl

# TO DO: Command for create blockage
# blockage.tcl 
# blockage under power straps. Otherwise routing problem may occur under power straps 
# 创建Blockage，目的基本与上同 
create_placement_blockage -type hard -bbox [list $BLOCK_X0 $BLOCK_Y0 [expr $IO2CORE + $CORE_WIDTH] [expr $IO2CORE + $CORE_HEIGHT]]
create_placement_blockage -type hard -bbox [list $BLOCK_X1 $BLOCK_Y1 [expr $IO2CORE + $CORE_WIDTH] [expr $IO2CORE + $CORE_HEIGHT]]
```

``` tcl
# preplace_sram.tcl

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
```

``` tcl
# vdd_vss_rings_straps.tcl
# Wenxun: disable this rule check to ensure rings and connection will be made
set_preroute_drc_strategy -ignore_discrete_metal_width_rule

create_rectangular_rings -around core -nets GND_SOC -left_segment_layer M4 -right_segment_layer M4 -bottom_segment_layer M3 -top_segment_layer M3 -left_segment_width $POWER_RING_WIDTH -right_segment_width $POWER_RING_WIDTH -bottom_segment_width $POWER_RING_WIDTH -top_segment_width $POWER_RING_WIDTH -left_offset $POWER_RING_PITCH -right_offset $POWER_RING_PITCH -bottom_offset $POWER_RING_PITCH -top_offset $POWER_RING_PITCH -offsets absolute

create_rectangular_rings -around core -nets VDD_SOC -left_segment_layer M4 -right_segment_layer M4 -bottom_segment_layer M3 -top_segment_layer M3 -left_segment_width $POWER_RING_WIDTH -right_segment_width $POWER_RING_WIDTH -bottom_segment_width $POWER_RING_WIDTH -top_segment_width $POWER_RING_WIDTH -left_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -right_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -bottom_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -top_offset [expr 2*$POWER_RING_PITCH + $POWER_RING_WIDTH] -offsets absolute

# TO DO: Create your Ring and Straps, must exists rings and straps both.
# e.g. create_power_straps -nets {xxx} -direction vertical -start_at [$POS] -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate [$POS1] -start_high_ends coordinate -start_high_ends_coordinate [$POS2] -layer M4 -extend_low_ends off -extend_high_ends off
create_power_straps -nets VDD_SOC -direction vertical -start_at $POS_START -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate $POS_L -start_high_ends coordinate -start_high_ends_coordinate $POS_H -layer M4 -extend_low_ends off -extend_high_ends off

create_power_straps -nets GND_SOC -direction vertical -start_at $POS_START -width 5 -num_placement_strap 1 -start_low_ends coordinate -start_low_ends_coordinate $POS_L -start_high_ends coordinate -start_high_ends_coordinate $POS_H -layer M4 -extend_low_ends off -extend_high_ends off
```
