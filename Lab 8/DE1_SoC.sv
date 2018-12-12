module DE1_SoC(CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	input logic CLOCK_50; 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	output logic [35:0] GPIO_0;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	assign red_array[7][7:0] = 8'b00000000;
	assign red_array[6][7:0] = 8'b00000000;
	assign red_array[5][7:0] = 8'b00000000;
	assign red_array[4][7:0] = 8'b00000000;
	assign red_array[3][7:0] = 8'b00000000;
	assign red_array[2][7:0] = 8'b00000000;
	assign red_array[1][7:0] = 8'b00000000;
	
	logic on = 1, off = 0;					
	logic reset;
	assign reset = SW[9];
	logic [7:0][7:0] red_array, green_array;
	logic gameOver;
	
	wire [31:0] clk;
	parameter whichClock = 16;
	clock_divider cdiv (CLOCK_50, clk);
	wire dclk;								
	assign dclk = clk[whichClock];
	
	logic in;
	logic active;
	userInput ui (dclk, reset, ~KEY[0], in);
	gameStart gs (dclk, reset, in, active);
	
	
	logic [2:0] randomNumber; 
	randNum r4 (dclk, reset, active, randomNumber);
	
	pipeStarter pip0 (dclk, reset, active, gameOver, randomNumber, green_array[7][7:0]);
	pipeMover pip1 (dclk, reset, active, gameOver, green_array[7][7:0], green_array[6][7:0]);
	pipeMover pip2 (dclk, reset, active, gameOver, green_array[6][7:0], green_array[5][7:0]);
	pipeMover pip3 (dclk, reset, active, gameOver, green_array[5][7:0], green_array[4][7:0]);
	pipeMover pip4 (dclk, reset, active, gameOver, green_array[4][7:0], green_array[3][7:0]);
	pipeMover pip5 (dclk, reset, active, gameOver, green_array[3][7:0], green_array[2][7:0]);
	pipeMover pip6 (dclk, reset, active, gameOver, green_array[2][7:0], green_array[1][7:0]);
	pipeMover pip7 (dclk, reset, active, gameOver, green_array[1][7:0], green_array[0][7:0]);
	
	birdLight l0 (dclk, reset, active, gameOver, in, off, off, red_array[0][6], on, red_array[0][7]);
	birdLight l1 (dclk, reset, active, gameOver, in, off, red_array[0][7], red_array[0][5], off, red_array[0][6]);
	birdLight l2 (dclk, reset, active, gameOver, in, off, red_array[0][6], red_array[0][4], off, red_array[0][5]);
	birdLight l3 (dclk, reset, active, gameOver, in, on, red_array[0][5], red_array[0][3], off, red_array[0][4]);
	birdLight l4 (dclk, reset, active, gameOver, in, off, red_array[0][4], red_array[0][2], off, red_array[0][3]);
	birdLight l5 (dclk, reset, active, gameOver, in, off, red_array[0][3], red_array[0][1], off, red_array[0][2]);
	birdLight l6 (dclk, reset, active, gameOver, in, off, red_array[0][2], red_array[0][0], off, red_array[0][1]);
	birdLight l7 (dclk, reset, active, gameOver, in, off, red_array[0][1], off, off, red_array[0][0]);
	
	ledMatrixDriver mDriver (dclk, red_array, green_array, GPIO_0[27:20], GPIO_0[35:28], GPIO_0[19:12]);
	
	logic extraPoint;
	crashOrNot stat (dclk, reset, active, red_array[0], green_array[0], gameOver, extraPoint);
	
	logic pp0, pp1, pp2;
	hexs d0(dclk, reset, active, 7'b1000000, extraPoint, HEX0, pp0);
	hexs d1(dclk, reset, active, 7'b1111111, pp0, HEX1, pp1);
	hexs d2(dclk, reset, active, 7'b1111111, pp1, HEX2, pp2);
endmodule

module clock_divider (clock, divided_clocks); 
 	input clock; 
 	output reg [31:0] divided_clocks; 
 	
 	initial 
      divided_clocks = 0;
 
 	always_ff @(posedge clock) 
 	   divided_clocks <= divided_clocks + 1; 

endmodule 

module DE1_SoC_testbench();
	reg	clk;
	wire  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	wire  [9:0] LEDR;
	reg   [3:0] KEY;
	reg   [9:0] SW;
	wire	[35:0] GPIO_0;
	
	DE1_SoC dut (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	
	parameter CLOCK_PERIOD=100;
	initial clk=1;
	always begin
		#(CLOCK_PERIOD/2);
		clk = ~clk;
	end
	
	initial begin
		SW[9] <= 1;	KEY[0] <= 1;	@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;	@(posedge clk);										
											@(posedge clk);
		SW[9] <= 0;						@(posedge clk);
						KEY[0] <= 1;	@(posedge clk);
											@(posedge clk);
						KEY[0] <= 0;	@(posedge clk);
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

