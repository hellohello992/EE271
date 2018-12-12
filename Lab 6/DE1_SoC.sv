module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
   input logic CLOCK_50;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	
	//logic [31:0] clk;   
	//parameter whichClock = 25;   
	//clock_divider cdiv (CLOCK_50, clk);
	
	logic L, R;
	   assign HEX1 = 7'b1111111; 
   	assign HEX2 = 7'b1111111; 
   	assign HEX3 = 7'b1111111; 
   	assign HEX4 = 7'b1111111; 
   	assign HEX5 = 7'b1111111; 
  
   inputDeal KEYS(.clk(CLOCK_50), .reset(SW[9]), .L(~KEY[3]), .R(~KEY[0]), .newL(L), .newR(R));
   tugOfWar war(.clk(CLOCK_50), .reset(SW[9]), .L(L), .R(R), .lights(LEDR[9:1]), .numbers(HEX0));
	
endmodule

//module clock_divider (clock, divided_clocks);   
  // input  logic          clock;   
	//output logic  [31:0]  divided_clocks;      
	
//	initial    
	//   divided_clocks <= 0;       
		
//	always_ff @(posedge clock)    
	//   divided_clocks <= divided_clocks + 1;  
//endmodule 	

module DE1_SoC_testbench();
   logic CLOCK_50;
	logic [3:0] KEY;
	logic [9:0] SW, LEDR;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic clk;
	
	DE1_SoC dut7 (.CLOCK_50(clk), .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin					      	 
 											                     @(posedge clk); 
 		SW[9]  <= 1; 					 	                  @(posedge clk); 
 		SW[9]  <= 0; 					 	                  @(posedge clk); 
 		               KEY[3] <= 0;  KEY[0] <= 0;    	@(posedge clk); 
 		                             KEY[0] <= 1;       @(posedge clk);
							KEY[3] <= 1;                     @(posedge clk);
	                                KEY[0] <= 0;       @(posedge clk);
							                                 @(posedge clk);				  
			
 		$stop; 
	end
endmodule


		

	
	
	

