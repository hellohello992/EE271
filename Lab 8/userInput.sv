module userInput (clk, reset, in, newin);
	input logic clk, reset, in;
	output logic newin;
	
	logic ps, ns;
	
	always @(*)
		ns = in;
	
	always_ff @(posedge clk)
		if (reset)
			ps <= 1'b0;
		else
			ps <= ns;
			
	assign newin = ps;
endmodule

module userInput_testbench();
	logic clk, reset, in;
   logic newin;
	
	userInput dut(clk, reset, in, newin);
	
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