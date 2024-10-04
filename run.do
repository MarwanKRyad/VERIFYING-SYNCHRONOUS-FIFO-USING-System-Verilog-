vlib work
vlog shared_pkg.sv interface.sv FIFO_transaction.sv FIFO_scoreboard.sv FIFO.sv FIFO_coverge.sv tb.sv monitor.sv top.sv +define+SIM +cover -covercells
vsim -voptargs=+acc work.top -cover
add wave /top/clk
add wave /top/inter_type/data_out
add wave /top/the_monitor/obj_board
run -all