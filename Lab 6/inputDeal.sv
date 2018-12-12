module inputDeal (clk, reset, L, R, newL, newR);
   input logic clk, reset, L, R;
	output logic newL, newR;
	
	key LEFT(.clk, .reset, .key(L), .out(newL));
	key RIGHT(.clk, .reset, .key(R), .out(newR));
	
endmodule

module inputDeal_testbench();
   logic clk, reset, L, R;
	logic newL, newR;
   
	inputDeal dut6 (.clk, .reset, .L, .R, .newL, .newR);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                                     @(posedge clk);
	   reset <= 1;                       @(posedge clk);
	   reset <= 0; L <= 0; R <= 0;       @(posedge clk);
	                       R <= 1;       @(posedge clk);
	               L <= 1;               @(posedge clk);
				   			  R <= 0;       @(posedge clk);
								                @(posedge clk);
					   		
		$stop;
   end	
endmodule