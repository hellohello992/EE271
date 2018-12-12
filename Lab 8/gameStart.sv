module gameStart (clk, reset, in, out);
	input logic clk, reset, in;
	output logic out;
	
	logic ps, ns;
	
	always @(*)
		ns = ps | in;
	
	always_ff @(posedge clk)
		if (reset)
			ps <= 0;
		else
			ps <= ns;
			
	assign out = ps;
endmodule

module gameStart_testbench();
	logic clk, reset, in;
	logic out;
	
	gameStart dut (clk, reset, in, out);
	
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1;	    in <= 1;	@(posedge clk);
		                           @(posedge clk);
						    in <= 0; 	@(posedge clk);
		reset <= 0;					   @(posedge clk);
						    in <= 1;	@(posedge clk);
										   @(posedge clk);
										   @(posedge clk);
						    in <= 0;	@(posedge clk);
										   @(posedge clk);
										   @(posedge clk);
										   @(posedge clk);
										   @(posedge clk);
		$stop;
	end
endmodule
