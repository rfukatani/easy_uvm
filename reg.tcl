set UVM_PATH C:/Users/rf/Documents/verilog/uvm-1.2/


vlib work
vlog -sv $UVM_PATH/src/uvm_pkg.sv +incdir+$UVM_PATH/src +define+UVM_HDL_NO_DPI+UVM_NO_DPI+UVM_CMDLINE_NO_DPI+UVM_REGEX_NO_DPI
vlog -sv tinyalu_pkg.sv +incdir+./tb_classes +incdir+$UVM_PATH/src
vlog -sv tinyalu_bfm.sv
vlog -sv tinyalu_vlog/tinyalu.sv
vlog -sv top.sv +incdir+./tb_classes +incdir+UVM_PATH/src/ +incdir+./tinyalu_dut

vsim -c -classdebug -onfinish stop top +UVM_OBJECTION_TRACE +UVM_CONFIG_DB_TRACE +UVM_NO_RELNOTES +UVM_MY_SEQ=reg_sequence +UVM_TESTNAME=reg_test +UVM_VERBOSITY=UVM_MEDIUM +UVM_DUMP_CMDLINE_ARGS  -do "add wave -position end  sim:/top/DUT/clk;


add wave -r /*
run -all;
quit -sim"
