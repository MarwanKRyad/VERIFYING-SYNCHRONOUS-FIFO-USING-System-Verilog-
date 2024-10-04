package FIFO_scoreboard_pack;
	import FIFO_transaction_pack::*;
	import shared_pkg::*;
	class  FIFO_scoreboard;
		parameter FIFO_WIDTH = 16;
		logic [FIFO_WIDTH-1:0] data_out_ref;
		reg[15:0] fifo [$];
		int q_size_before;
		function check_data (FIFO_transaction rec_trans);
			golden_model(rec_trans);
			if(rec_trans.data_out!=data_out_ref)
				begin
					error_count=error_count+1;
					$display("error");
				end
			else
				begin
					correct_count=correct_count+1;
				end
			if(finished_signal==1)
				begin
					$display("correct_count=%d , error_count=%d",correct_count,error_count);
					$stop;
				end

				
		endfunction 

		function void golden_model(FIFO_transaction input_trans);
			q_size_before=fifo.size();
			if(input_trans.rst_n==0)
			begin
			data_out_ref=0;
			for(int i=0 ; i<q_size_before;i++)
			fifo.pop_front();
			end
	
			else 
			begin
			case({input_trans.wr_en,input_trans.rd_en})
			2'b00:
			begin
				data_out_ref=0;
			end
			2'b10:
			begin 
				if(fifo.size()!=8)
					fifo.push_back(input_trans.data_in);
					data_out_ref=0;
			end
			2'b01:
			begin 
				if(fifo.size()!=0)
					data_out_ref=fifo.pop_front();
				else 
					data_out_ref=0;
			end
			2'b11:
			begin
			if(fifo.size()==0)
				begin
					fifo.push_back(input_trans.data_in);
					data_out_ref=0;
				end
			
			else if (fifo.size()==8)
					data_out_ref=fifo.pop_front();
			
			else
				begin
					fifo.push_back(input_trans.data_in);
					data_out_ref=fifo.pop_front();
				end
			end
			endcase 
			end
		endfunction 
		
	endclass
endpackage 