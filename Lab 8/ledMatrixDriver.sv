module ledMatrixDriver (clk, red_array, green_array, red_driver, green_driver, row_sink);
	input clk;
	input [7:0][7:0] red_array, green_array;
	output reg [7:0] red_driver, green_driver, row_sink;
	
	reg [2:0] count = 3'b000;
	
	always @(*)
		case(count)
			3'b000:	row_sink = 8'b11111110;
			3'b001:	row_sink = 8'b11111101;
			3'b010:	row_sink = 8'b11111011;
			3'b011:	row_sink = 8'b11110111;
			3'b100:	row_sink = 8'b11101111;
			3'b101:	row_sink = 8'b11011111;
			3'b110:	row_sink = 8'b10111111;
			3'b111:	row_sink = 8'b01111111;
			default:	row_sink = 8'bX;
		endcase
	
	assign red_driver[7:0] = red_array[count];
	assign green_driver[7:0] = green_array[count];
	
	always_ff @(posedge clk)
		count <= count + 3'b001;
endmodule
