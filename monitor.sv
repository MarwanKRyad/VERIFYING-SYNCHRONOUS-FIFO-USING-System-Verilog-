module monitor (interface_FIFO.monitor inter_type);
import FIFO_transaction_pack::*;
import FIFO_coverge_pack::*;
import FIFO_scoreboard_pack::*;
FIFO_transaction obj_trans=new(70,70);
FIFO_coverge obj_cover =new();
FIFO_scoreboard obj_board =new();

initial
begin
	
	forever 
	begin
		@(negedge inter_type.clk);
		obj_trans.rst_n=inter_type.rst_n;
		obj_trans.data_in=inter_type.data_in;
		obj_trans.rd_en=inter_type.rd_en;
		obj_trans.wr_en=inter_type.wr_en;
		obj_trans.data_out=inter_type.data_out;
		obj_trans.wr_ack=inter_type.wr_ack;
		obj_trans.overflow=inter_type.overflow;
		obj_trans.underflow=inter_type.underflow;
		obj_trans.full=inter_type.full;
		obj_trans.empty=inter_type.empty;
		obj_trans.almostfull=inter_type.almostfull;
		obj_trans.almostempty=inter_type.almostempty;
		fork
			begin
				obj_cover.sample_data(obj_trans);
			end

			begin
				obj_board.check_data(obj_trans);
			end

		join

	end
end

endmodule 