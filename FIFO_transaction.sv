package FIFO_transaction_pack;
	class FIFO_transaction;
		parameter FIFO_WIDTH = 16;
		int RD_EN_ON_DIST,WR_EN_ON_DIST;
		 rand logic  rst_n, wr_en, rd_en;
		 rand logic [FIFO_WIDTH-1:0] data_in;
		 logic wr_ack, overflow,underflow,full, empty, almostfull, almostempty;
		 logic [FIFO_WIDTH-1:0] data_out;
		constraint reset_const {rst_n dist {1:/98 , 0:/2};};
		constraint write_en_const {wr_en dist {1:/WR_EN_ON_DIST , 0:/100-WR_EN_ON_DIST};};
		constraint read_en_const {rd_en dist {1:/RD_EN_ON_DIST , 0:/100-RD_EN_ON_DIST};};
		 

	function new(int RD_ON=30,int WR_ON=70);
	RD_EN_ON_DIST=RD_ON;
	WR_EN_ON_DIST=WR_ON;
	endfunction 

	endclass

endpackage 