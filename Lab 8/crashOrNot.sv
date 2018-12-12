module crashOrNot (clk, reset, active, player, pipes, gameOver, extraPoint);
	input clk, reset, active;
	input [7:0] player, pipes;
	output gameOver, extraPoint;
	
	reg psgameOver, nsgameOver;
	reg [7:0] pspipes, nspipes;
	
	always @(*) begin
		nsgameOver = player[0] | player[7] & pipes[7] | player[6] & pipes[6] | player[5] & pipes[5]
				   | player[4] & pipes[4] | player[3] & pipes[3] | player[2] & pipes[2] | player[1] & pipes[1];
		nspipes = pipes;
	end
			
	always_ff @(posedge clk)
		if(reset | ~active) begin
			psgameOver <= 1'b0;
			pspipes <= 8'b00000000;
		end
		else begin
			psgameOver <= nsgameOver;
			pspipes <= nspipes;
		end
		
	assign gameOver = psgameOver;
	assign extraPoint = ~(pspipes == 8'b00000000) & (pipes == 8'b00000000);
endmodule
