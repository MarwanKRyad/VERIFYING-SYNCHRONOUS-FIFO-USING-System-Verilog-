package FIFO_coverge_pack;
	import FIFO_transaction_pack::*;
	
	class FIFO_coverge ;
	FIFO_transaction F_cvg_txn;
	covergroup cg;

	write:coverpoint F_cvg_txn.wr_en 
	{
		bins write_0={0};
		bins write_1={1};
	}

	read:coverpoint F_cvg_txn.rd_en 
	{
		bins read_0={0};
		bins read_1={1};
	}


	full:coverpoint F_cvg_txn.full 
	{
		bins full_0={0};
		bins full_1={1};
	}


	empty:coverpoint F_cvg_txn.empty
	{
		bins empty_0={0};
		bins empty_1={1};
	}


	almostfull:coverpoint F_cvg_txn.almostfull 
	{
		bins almostfull_0={0};
		bins almostfull_1={1};
	}


	almostempty:coverpoint F_cvg_txn.almostempty
	{
		bins almostempty_0={0};
		bins almostempty_1={1};
	}

	overflow:coverpoint F_cvg_txn.overflow
	{
		bins overflow_0={0};
		bins overflow_1={1};
	}

	underflow:coverpoint F_cvg_txn.underflow
	{
		bins underflow_0={0};
		bins underflow_1={1};
	}
	
	wr_ack:coverpoint F_cvg_txn.wr_ack
	{
		bins wr_ack_0={0};
		bins wr_ack_1={1};
	}

	cross_full:cross write,read,full
	{
		illegal_bins f_111=binsof(write.write_1)&&binsof(read.read_1)&&binsof(full.full_1);
		illegal_bins f_011=binsof(write.write_0)&&binsof(read.read_1)&&binsof(full.full_1);
	}
	cross_empty:cross write,read,F_cvg_txn.empty;	

	cross_almostfull:cross write,read,almostfull;	

	cross_almostempty:cross write,read,almostempty;

	cross_overflow:cross write,read,overflow
	{
		illegal_bins ov_001=binsof(write.write_0)&&binsof(read.read_0)&&binsof(overflow.overflow_1);
		illegal_bins ov_011=binsof(write.write_0)&&binsof(read.read_1)&&binsof(overflow.overflow_1);
	}
	
	cross_underflow:cross write,read,underflow
	{
		illegal_bins uv_101=binsof(write.write_1)&&binsof(read.read_0)&&binsof(underflow.underflow_1);
		illegal_bins uv_001=binsof(write.write_0)&&binsof(read.read_0)&&binsof(underflow.underflow_1);
	}

	cross_wr_ack:cross write,read,wr_ack
	{
		illegal_bins wack_001=binsof(write.write_0)&&binsof(read.read_0)&&binsof(wr_ack.wr_ack_1);
		illegal_bins wack_011=binsof(write.write_0)&&binsof(read.read_1)&&binsof(wr_ack.wr_ack_1);
	}

	endgroup 

	function void sample_data(FIFO_transaction F_txn);
		F_cvg_txn=F_txn;
		cg.sample();
	endfunction 
	function new();
		cg=new();
	endfunction 
	endclass 
endpackage 