module key (clk, reset, Key, out);
   input logic clk, reset, Key;
	output logic out;
	
	parameter on = 1'b01, off = 1'b00;
	logic ns, oldKey;
	
	always_comb
	   case (out)
		   on: ns = off;
			off: if ((Key == on) & (Key != oldKey)) ns = on;
			     else ns = off;
			default: ns = off;
		endcase
	
	always @(posedge clk)
	   if (reset)
		   begin out <= off;
			      oldKey <= off;
			end
		else begin
		   out <= ns;
			oldKey <= Key;
		end
		
endmodule

module key_testbench();
   logic clk, reset, Key;
	logic out;
   
	key dut5 (.clk, .reset, .Key, .out);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin
	                                     @(posedge clk);
	   reset <= 1;                       @(posedge clk);
	   reset <= 0;    Key <= 0;          @(posedge clk);
	                                     @(posedge clk);
	                  Key <= 1;          @(posedge clk);
				   			                @(posedge clk);
		reset <= 1;                       @(posedge clk);
	   reset <= 0;    Key <= 0;          @(posedge clk);
	                                     @(posedge clk);
	                  Key <= 1;          @(posedge clk);
				   			                @(posedge clk);
								            			   		
		$stop;
   end	
endmodule
