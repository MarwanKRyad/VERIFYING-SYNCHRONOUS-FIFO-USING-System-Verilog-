import FIFO_transaction_pack::*;
import FIFO_coverge_pack::*;
import FIFO_scoreboard_pack::*;
import shared_pkg::*;


module tb (interface_FIFO.TB inter_type);
FIFO_transaction obj=new(70,70);
FIFO_coverge obj2=new();
FIFO_scoreboard obj3=new();
reg[15:0] fifo [$];
reg[15:0 ] expected_output;




initial
begin
	inter_type.data_in=0;
	inter_type.rst_n=0;
	inter_type.wr_en=1;
	inter_type.rd_en=0;
	@(negedge inter_type.clk);
	#0;

	for (int i = 0; i < 100000; i++) begin
		assert(obj.randomize());
		
		inter_type.data_in=obj.data_in;
		inter_type.rst_n=obj.rst_n;
		inter_type.wr_en=obj.wr_en;
		inter_type.rd_en=obj.rd_en;
		@(negedge inter_type.clk);
		#0;
		
/*


		
		if(expected_output!=inter_type.data_out)
			begin
				error_count++;
				$display("wr_en=%d,rd_en=%d,data_in=%d,rst_n=%d,data_out=%d,expected_output=%d , queue_size=%d",inter_type.wr_en,inter_type.rd_en,inter_type.data_in,inter_type.rst_n,inter_type.data_out,expected_output,fifo.size());
				
			end
			
		else 
			correct_count++;
*/		

	end
	finished_signal=1;

	

end

endmodule 