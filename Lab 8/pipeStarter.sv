module pipeStarter (clk, reset, active, gameOver, randomNumber, result);
	input logic clk, reset, active, gameOver;
	input logic [2:0] randomNumber;
	output logic [7:0] result;
	
	reg [8:0] count = '0;
	reg gap = 1'b0;
	logic [7:0] ps, ns;
	
	always @(*)
		if (gameOver)
			ns = result;
		else
			if (gap == 0)
				case(randomNumber)
					3'b000:	ns = 8'b10011111;
					3'b001:	ns = 8'b11001111;
					3'b010:	ns = 8'b11100111;
					3'b011:	ns = 8'b11110011;
					3'b100:	ns = 8'b11111001;
					3'b101:	ns = 8'b11001111;
					3'b110:	ns = 8'b11100111;
					default:	ns = 8'b00000000;
				endcase
			else
				ns = 8'b00000000;
		
	always_ff @(posedge clk)
		if (reset | ~active) begin
			ps <= 8'b00000000;
			count <= 0;
			gap <= 1'b0;
		end
		else begin
			if (count == 0) begin
				ps <= ns;
				gap <= gap + 1'b1;
			end
			count <= count + 1'b1;
		end
		
	assign result = ps;
endmodule


module pipeStarter_testbench();
	logic clk, reset, active, gameOver;
	logic [2:0] randomNumber;
	logic [7:0] result;
	
	pipeStarter (clk, reset, active, gameOver, randomNumber, result);
	
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
	                                                              @(posedge clk);
		reset <= 1;	   active <= 0;	            	              @(posedge clk);
		reset <= 0;											                 @(posedge clk);
						   active <= 1;						                 @(posedge clk);
											    randomNumber <= 3'b000;	  @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
											    randomNumber <= 3'b001;	  @(posedge clk);
															                	  @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
											    randomNumber <= 3'b011;	  @(posedge clk);
															                    @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
											    randomNumber <= 3'b010;	  @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);
																                 @(posedge clk);

		$stop;
	end
endmodule