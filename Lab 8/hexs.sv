module hexs(clk, reset, active, dv, incre, display, ncy);
	input clk, reset, active, incre;
	input [6:0] dv;
	output ncy;
	output [6:0] display;
	
	parameter	zero	= 7'b1000000,
					one	= 7'b1111001,
					two	= 7'b0100100,
					three	= 7'b0110000,
					four	= 7'b0011001,
					five	= 7'b0010010,
					six	= 7'b0000010,
					seven	= 7'b1111000,
					eight	= 7'b0000000,
					nine	= 7'b0010000;
	
	logic [6:0] ps, ns;
	
	always @(*)
		if(incre)
			case(ps)
				zero:		ns = one;
				one:		ns = two;
				two:		ns = three;
				three:	ns = four;
				four:		ns = five;
				five:		ns = six;
				six:		ns = seven;
				seven:	ns = eight;
				eight:	ns = nine;
				nine:		ns = zero;
				default:	ns = one;
			endcase
		else
			ns = ps;
	
	assign display[6:0] = ps[6:0];
	assign ncy = (ps[6:0] == nine) & incre;
	
	always_ff @(posedge clk)
		if(reset | ~active)
			ps <= dv;
		else
			ps <= ns;
endmodule
