module REXNUM(in, numbers);
   input logic [2:0] in;
	output logic [6:0] numbers;
	
	parameter zero = 3'b000, one = 3'b001, two = 3'b010, three = 3'b011, four = 3'b100, five = 3'b101, six = 3'b110, seven = 3'b111;
	logic [6:0] ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, NONE;
	
   assign ZERO = 7'b1000000; 
   assign ONE  = 7'b1111001; 
   assign TWO  = 7'b0100100; 
   assign THREE= 7'b0110000; 
  	assign FOUR = 7'b0011001; 
 	assign FIVE = 7'b0010010; 
 	assign SIX  = 7'b0000010; 
 	assign SEVEN= 7'b1111000; 
	assign NONE = 7'b1111111;

	always_comb
	   case (in)
		   zero: numbers = ZERO;
			one: numbers = ONE;
			two: numbers = TWO;
			three: numbers = THREE;
			four: numbers = FOUR;
			five: numbers = FIVE;
			six: numbers = SIX;
			seven: numbers = SEVEN;
			default: numbers = NONE;
		endcase
		
endmodule

