# CPU+FFT Project #

## 进度安排 ##

- [x] 整理文件结构 ......8.8
- [x] 跑通 gcc 编译链 ......8.9
- [ ] 重新设计 FFT
- [ ] 本地 Vivado 跑通单周期 CPU+FFT
- [ ] 调整 gcc 适应流水线 FFT
- [ ] 虚拟机内跑通行为级仿真
- [ ] DC
- [ ] ICC
- [ ] PT

### 文件结构 ###

``` .
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
