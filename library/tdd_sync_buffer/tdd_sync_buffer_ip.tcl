#ip

source ../../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create tdd_sync_buffer
adi_ip_files tdd_sync_buffer [list \ "tdd_sync_buffer.v"]

adi_ip_properties_lite tdd_sync_buffer

ipx::infer_bus_interface clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface rstn xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]

ipx::save_core [ipx::current_core]
