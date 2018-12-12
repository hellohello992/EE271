module playfield(clk, reset, L, R, relative, lights);
   input logic clk, reset, relative, L, R;
	output logic [9:1] lights;
	
	logic [8:0] ns;
	
	always_comb
		if (R & ~L) 
			ns = lights >> 1;
		else if (L & ~R)  
			ns = lights << 1;
		else
			ns = lights;
	
	always @(posedge clk)
    	if (reset | relative)
         lights <= 9'b000010000;
      else 
         lights <= ns;
endmodule

module playfield_testbench();
   logic clk, reset, relative, L, R;
	logic [9:1] lights;
	
	playfield dut3 (.clk, .reset, .L, .R, .relative, .lights);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin   
                                                       @(posedge clk);
	   reset <= 1;                                      @(posedge clk);
	   reset <= 0; L <= 0; R <= 0; relative <= 0;       @(posedge clk);
	                                                    @(posedge clk);
	                               relative <= 1;       @(posedge clk);
				   						                      @(posedge clk);
					   		  R <= 1;                      @(posedge clk);
								                               @(posedge clk);
	                               relative <= 0;       @(posedge clk);
							   			                      @(posedge clk);
			   	   L <= 1;                              @(posedge clk);
						                                     @(posedge clk);
				   	                relative <= 1;       @(posedge clk);
                                                       @(posedge clk);
					   		R <= 0;                        @(posedge clk);
						   	                               @(posedge clk);
					   					 relative <= 0;       @(posedge clk);
						   				                      @(posedge clk);


		$stop;
	end
endmodule