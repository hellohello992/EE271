module randNum(clk, reset, active, out);
	input logic clk, reset, active;
	output logic [2:0] out;
	
	reg [2:0] ps, ns;
	reg [8:0] count = '0;
	
	// uses lfsr's to generate random 3 bits
	logic seed;
	xnor g (seed, ns[2], ns[1]);
	LFSR a1(clk, reset, seed, ns[0]);
	LFSR a2(clk, reset, ns[0], ns[1]);
	LFSR a3(clk, reset, ns[1], ns[2]);
	
	always_ff @(posedge clk)
		if (reset | ~active) begin
			out <= 3'b000;
			count <= 0;
		end
		else begin
			if (count == 1) out <= ns;
			count <= count + 9'b1;
		end
endmodule

module randNum_testbench();
	logic clk, reset, active;
	logic [2:0] out;
	
	randNum dut(clk, reset, active, out);

	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		reset <= 1; active <= 0;	@(posedge clk);
		                           @(posedge clk);
		            active <= 1;   @(posedge clk);
						               @(posedge clk);
		reset <= 0;						@(posedge clk);
		                           @(posedge clk);
						active <= 0;	@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);
											@(posedge clk);

		$stop;
	end
endmodule

