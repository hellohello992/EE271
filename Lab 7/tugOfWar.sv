module tugOfWar (clk, reset, L, R, lights, numbershuman, numberscyber);
   input logic clk, reset, L, R;
	output logic [9:1] lights;
	output logic [6:0] numbershuman, numberscyber;

	logic relative;
	
	playfield field(.clk, .reset, .L, .R, .relative, .lights);
	counting REX (.clk, .reset, .leftest(lights[9]), .rightest(lights[1]), .L, .R, .numbershuman, .numberscyber, .relative);
endmodule

module tugOfWar_testbench();
   logic clk, reset, L, R;
	logic [9:1] lights;
	logic [6:0] numbershuman, numberscyber;
   
	tugOfWar dut4 (.clk, .reset, .L, .R, .lights, .numbershuman, .numberscyber);
	
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
	
	
	
	
	
	
	
	