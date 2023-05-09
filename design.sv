module counter_module(
					input logic clk,
					input logic rst,
					input logic [1:0] CONTROL_SIGNALS,
					input logic [3:0] inital_value,
					input logic INIT_SIGNAL,
					output logic [3:0] counter,
					output logic [1:0] WHO,
					output logic GAMEOVER
					);
	
	logic  WINNER_FLAG;
	logic  LOSER_FLAG;
	logic clear;

	logic [3:0] Number_of_lose_counter , Number_of_win_counter;
	
	always @(posedge clk ) begin
		if(rst || clear) begin //@sync rst
			if(CONTROL_SIGNALS == 2'b10 || CONTROL_SIGNALS == 2'b11) 
				counter <= 4'b1111;//cound down
			else
				counter <= 0;//cound up
			
			Number_of_lose_counter <= 0;
			Number_of_win_counter <= 0;
			WHO <=2'b00;
			GAMEOVER <=0;

		end
		else begin
			if(INIT_SIGNAL) begin
				counter <= inital_value;
			end
			else begin
				case (CONTROL_SIGNALS)
					2'b00: counter <= counter + 1;
					2'b01: counter <= counter + 2;
					2'b10: counter <= counter - 1;
					2'b11: counter <= counter - 2;
				endcase
			end
		end
	end

	always @(counter) begin
			if((counter == 15))WINNER_FLAG <=1;
			else WINNER_FLAG <=0;
			if((counter == 0))LOSER_FLAG <=1;
			else LOSER_FLAG <=0;
			#2 begin 
				WINNER_FLAG<=0;
				LOSER_FLAG<=0;
			end

	end


	always @(WINNER_FLAG , LOSER_FLAG) begin
		if(!rst || !clear) begin 
			if(WINNER_FLAG)
				Number_of_win_counter <= Number_of_win_counter + 1;
			else if(LOSER_FLAG)
				Number_of_lose_counter  <= Number_of_lose_counter + 1;
		end
	end

	always @(Number_of_win_counter,Number_of_lose_counter)begin
		if(Number_of_win_counter == 15)begin
			WHO <=2'b10;
			GAMEOVER <=1;
		end
		else if(Number_of_lose_counter == 15)begin
			WHO <=2'b01;
			GAMEOVER <=1;
		end
		else begin
			WHO <=2'b00;
			GAMEOVER <=0;
		end
	end

	always @(GAMEOVER)begin
		if (GAMEOVER==1) begin
			#1 clear <=1;
			#1 clear <=0;
		end
	end

endmodule 