module counting (clk, reset, leftest, rightest, L, R, numbershuman, numberscyber, relative);
   input logic clk, reset, leftest, rightest, L, R;
	output logic [6:0] numbershuman, numberscyber;
	output logic relative;
	
	parameter zero = 3'b000, one = 3'b001, two = 3'b010, three = 3'b011, four = 3'b100, five = 3'b101, six = 3'b110, seven = 3'b111;
	
	logic [2:0] pshuman, nshuman, pscyber, nscyber;

	always_comb
	   if ((pscyber != seven) & (leftest & L & ~R))
		   begin
			   relative = 1'b1;
			   nshuman = pshuman;
				nscyber = pscyber + one;
			end
		else if ((pshuman != seven) & (rightest & R & ~L))
		   begin
			   relative = 1'b1;
			   nshuman = pshuman + one;
				nscyber = pscyber;
			end
		else if ((pshuman == seven) | (pscyber == seven))
		   begin 
			   relative = 1'b1;
			   nshuman = pshuman;
				nscyber = pscyber;
			end
		else begin
		relative = 1'b0;
		   nshuman = pshuman;
			nscyber = pscyber;
		end
	
   REXNUM numhuman (.in(pshuman), .numbers(numbershuman));
	REXNUM numcyber (.in(pscyber), .numbers(numberscyber));
	
	always @(posedge clk)
	   if (reset)
		   begin
		      pshuman <= zero;
				pscyber <= zero;
			end
		else begin
		   pshuman <= nshuman;
			pscyber <= nscyber;
		end
			
endmodule

module counting_testbench();
   logic clk, reset, leftest, rightest, L, R;
	logic relative;
	logic [6:0] numbershuman, numberscyber;
	
	counting dut3 (.clk, .reset, .leftest, .rightest, .L, .R);
	
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   clk <= 0;    
		forever #(CLOCK_PERIOD/2) clk <= ~clk; 
	end 
	
	initial begin   
                                                        	             @(posedge clk);
	   reset <= 1;                                                     @(posedge clk);
	   reset <= 0; L <= 0; R <= 0; leftest <= 0;  rightest <= 0;       @(posedge clk);
	                                              rightest <= 1;       @(posedge clk);
	                               leftest <= 1;                       @(posedge clk);
				   						                rightest <= 0;       @(posedge clk);
					   		  R <= 1;                                     @(posedge clk);
	                                              rightest <= 1;       @(posedge clk);
							   			 leftest <= 0;                       @(posedge clk);
								   		                rightest <= 0;       @(posedge clk);
			   	   L <= 1;                                             @(posedge clk);
				   	                               rightest <= 1;       @(posedge clk);
					   					 leftest <= 1;                       @(posedge clk);
						   	                         rightest <= 0;       @(posedge clk);
			   				  R <= 0;		                               @(posedge clk);
				   	                               rightest <= 1;       @(posedge clk);
					   					 leftest <= 0;                       @(posedge clk);
						   				                rightest <= 0;       @(posedge clk);
							   						                            @(posedge clk);
		reset <= 1;                                                     @(posedge clk);
		$stop;
	end
endmodule

	
	
	
	
	
	