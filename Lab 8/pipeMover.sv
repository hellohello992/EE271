module pipeMover(clk, reset, active, gameOver, initialLine, pipes);
	input logic clk, reset, active, gameOver;
	input logic [7:0] initialLine;
	output logic [7:0] pipes;
	
	reg [7:0] count = '0;
	reg [7:0] ps, ns;
	
	always @(*)
		if(gameOver)
			ns = ps;
		else
			ns = initialLine;
		
	
	always_ff @(posedge clk)
		if (reset | ~active) begin
			ps[7:0] <= 8'b00000000;
			count <= 0;
		end
		else begin
			if (count == 0) ps[7:0] <= ns;
			count <= count + 8'b1;
		end
		
	assign pipes = ps;
endmodule


module pipeMover_testbench();
	logic clk, reset, active, gameOver;
	logic [7:0] initialLine;
	logic [7:0] pipes;
	
	pipeMover dut(clk, reset, active, gameOver, initialLine, pipes);
	
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		                                                      @(posedge clk);
		reset <= 1;	   active <= 0;	  gameOver <= 0;	      @(posedge clk);
		reset <= 0;													      @(posedge clk);
						   active <= 1;								   @(posedge clk);
											     gameOver <= 1;	      @(posedge clk);
						   active <= 0; 	                        @(posedge clk);
						                    gameOver <= 0;			@(posedge clk);
												                        @(posedge clk);
																				@(posedge clk);
																				@(posedge clk);
		$stop;
	end
endmodule

