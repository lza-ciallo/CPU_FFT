# set clock period (ns)
# 800MHz
# set T_CLKV_PER 1.25
# set T_CLKV_PER 0.5
# set T_CLKV_PER 0.4
# set T_CLKV_PER 0.25
set T_CLKV_PER 2

# set the time of the rising edge
set T_CLKV_RISE 0
# set the time of the falling edge
set T_CLKV_FALL [expr $T_CLKV_PER/2]

# create clock
# 'clk' is the name of clock port in your top module
create_clock -name clk1 -period $T_CLKV_PER -waveform [list $T_CLKV_RISE $T_CLKV_FALL] sys_clk

# set input/output delay
set_input_delay [expr 0.2 * $T_CLKV_PER] -clock clk1 -max [all_inputs]
set_input_delay [expr 0.1 * $T_CLKV_PER] -clock clk1 -min [all_inputs]
set_output_delay [expr 0.2 * $T_CLKV_PER] -clock clk1 -max [all_outputs]
set_output_delay [expr 0.1 * $T_CLKV_PER] -clock clk1 -min [all_outputs]
