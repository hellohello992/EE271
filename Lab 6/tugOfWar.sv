module tugOfWar (clk, reset, L, R, lights, numbers);
   input logic clk, reset, L, R;
	output logic [9:1] lights;
	output logic [6:0] numbers;
	
	normalLight light9 (.clk, .reset, .L, .R, .NL(1'b0), .NR(lights[8]), .lighton(lights[9]) );  
   normalLight light8 (.clk, .reset, .L, .R, .NL(lights[9]), .NR(lights[7]), .lighton(lights[8]) );  
   normalLight light7 (.clk, .reset, .L, .R, .NL(lights[8]), .NR(lights[6]), .lighton(lights[7]) ); 
   normalLight light6 (.clk, .reset, .L, .R, .NL(lights[7]), .NR(lights[5]), .lighton(lights[6]) );  
   centerLight center (.clk, .reset, .L, .R, .NL(lights[6]), .NR(lights[4]), .lighton(lights[5]) );  
   normalLight light4 (.clk, .reset, .L, .R, .NL(lights[5]), .NR(lights[3]), .lighton(lights[4]) );  
   normalLight light3 (.clk, .reset, .L, .R, .NL(lights[4]), .NR(lights[2]), .lighton(lights[3]) );  
   normalLight light2 (.clk, .reset, .L, .R, .NL(lights[3]), .NR(lights[1]), .lighton(lights[2]) );  
   normalLight light1 (.clk, .reset, .L, .R, .NL(lights[2]), .NR(1'b0),    .lighton(lights[1]) );  

	winning REX (.clk, .reset, .leftest(lights[9]), .rightest(lights[1]), .L, .R, .numbers);
endmodule

module tugOfWar_testbench();
   logic clk, reset, L, R;
	logic [9:1] lights;
	logic [6:0] numbers;
   
	tugOfWar dut4 (.clk, .reset, .L, .R, .lights, .numbers);
	
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
	
	
	
	
	
	
	
	