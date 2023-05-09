module tb ();
	logic clk ,rst,INIT_SIGNAL ;
	logic [1:0] CONTROL_SIGNALS;
	logic [3:0] inital_value;
	logic [1:0] WHO;
	logic GAMEOVER;
	logic [3:0] counter;

	initial begin
		clk = 0;
		forever #1 clk = ~clk;
	end

	counter_module DUT(
					clk,
					rst,
					CONTROL_SIGNALS,
					inital_value,
					INIT_SIGNAL,
					counter,
					WHO,
					GAMEOVER
					);

	initial begin
      rst=1; 
      INIT_SIGNAL=0; 
      inital_value=4'b0000; 
      CONTROL_SIGNALS=2'b00;
      #2 //2
      //test case to make sure that it will ignore the values and set the reser values
      rst=1; 
      INIT_SIGNAL=0; 
      inital_value=4'b1111; 
      CONTROL_SIGNALS=2'b00;
      #2 //4
      //test case to load the min value in the couner & Count up by 1’s 
      rst=0; 
      INIT_SIGNAL=1; 
      inital_value=4'b0000; 
      CONTROL_SIGNALS=2'b00;
      #8  //12
      rst=0;
      INIT_SIGNAL=1;
      inital_value=4'b0010;
      CONTROL_SIGNALS=2'b00;
      #2 //14
      rst=0;
      INIT_SIGNAL=0;
      inital_value=4'b0000;
      CONTROL_SIGNALS=2'b00;
      #80  //94
      //test case to load max value in the counter Count down by 2’s   
      rst=0;
      INIT_SIGNAL=1;
      inital_value=4'b1111;
      CONTROL_SIGNALS=2'b11;
      #4  //98
      INIT_SIGNAL=0;
      #40 //138
      //test case to load the min value in the couner & Count down by 1’s 
      rst=0;
      INIT_SIGNAL=1;
      inital_value=4'b0000;
      CONTROL_SIGNALS=2'b10;
      #4 //142
      INIT_SIGNAL=0;
      #300  //442
      //test case to see that it will load odd value in the couner & Count up by 2’s
      rst=0;
      INIT_SIGNAL=1;
      inital_value=4'b0011;
      CONTROL_SIGNALS=2'b01;
      #4  //446
      INIT_SIGNAL=0;
      #80 //526
      //test case to see that it will load even value in the couner & Count up by 2’s
      rst=0;
      INIT_SIGNAL=1;
      inital_value=4'b1000;
      CONTROL_SIGNALS=2'b01;
      #4
      INIT_SIGNAL=0;
      #2000;
      $stop;
      
	end
    initial begin
      $dumpfile("test.vcd");
      $dumpvars;
  	end
	
endmodule 