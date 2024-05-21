#ip

source ../../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip_xilinx.tcl

adi_ip_create dma_tdd_sync
adi_ip_files dma_tdd_sync [list \ "dma_tdd_sync.v"]

adi_ip_properties_lite dma_tdd_sync

ipx::infer_bus_interface clk xilinx.com:signal:clock_rtl:1.0 [ipx::current_core]
ipx::infer_bus_interface rstn xilinx.com:signal:reset_rtl:1.0 [ipx::current_core]

ipx::save_core [ipx::current_core]
