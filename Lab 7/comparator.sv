module comparator(A, B, out); 

	input logic [9:0] A, B;
	output logic out;

   always_comb begin
	   if (A > B) out = 1;
		else out = 0;
   end

endmodule
 
module comparator_testbench();
   logic [9:0] A, B;
	logic out;
   
	comparator dut10 (.A, .B, .out);
	
	integer i;
	initial begin
	                              #100;
	   A = 10'd128; B = 10'd34;   #100;
		                           #100;
		A = 10'd34;  B = 10'd128;  #100;
		                           #100;
      A = 10'd34;  B = 10'd34;   #100;
		                           #100;
		                          
   end	
endmodule	

