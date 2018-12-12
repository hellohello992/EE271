module LFSR(reset, clk, out);
   input logic reset, clk;
	output logic [9:0] out;
	logic change;
	
	assign change = (out[9] ^ ~out[6]);
	always @(posedge clk)
	   if (reset)
		   out <= '0;
		else begin
         out <= {out[8:0], change};
		end
endmodule

module LFSR_testbench ();
	reg clk, reset;
	wire [9:0] out;

	LFSR randomNumber (.clk, .reset, .out);

	parameter CLOCK_PERIOD = 100;
	initial clk = 1;
	always begin
		#(CLOCK_PERIOD / 2);
		clk = ~clk;
	end 

	initial begin	
									@(posedge clk);
		reset <= 1;				@(posedge clk);
		reset <= 0; 			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		$stop;
	end
endmodule