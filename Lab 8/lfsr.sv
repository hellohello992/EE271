module LFSR(clk, reset, inp, outp);
	input logic clk, reset, inp;
	output logic outp;
	logic ps;
	
	assign outp = ps;
	
	always @(posedge clk)
		if (reset)
			ps <= 1'b0;
		else
			ps <= inp;
endmodule

module LFSR_testbench();
	logic clk, reset, inp;
	logic outp;
	
	LFSR dut (clk, reset, inp, outp);
	
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
									@(posedge clk);
		reset <= 1;	inp <= 0;	@(posedge clk);
		                     @(posedge clk);
						inp <= 1;	@(posedge clk);
						         @(posedge clk);
		reset <= 0;	inp <= 0;	@(posedge clk);
		                     @(posedge clk);
						inp <= 1;	@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		$stop;
	end
endmodule

