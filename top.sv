module top ();
logic clk;

initial begin
	clk=0;
	forever 
	#1 clk=~clk;
end

interface_FIFO inter_type(clk);
FIFO DUT(inter_type);
tb The_TB (inter_type);
monitor the_monitor(inter_type);


endmodule 
