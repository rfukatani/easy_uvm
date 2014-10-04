/*
   Copyright 2013 Ryousuke Fukatani

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
   
   Add write/read function and some sequence by Ryousuke Fukatani
*/

module tinyalu(A,B,clk,op,reset_n,start,done,result);

	input [7:0] A,B;
	input clk,reset_n;
	input [2:0] op;
	input start;
	output reg done;
	output reg [15:0] result;
	
	reg [2:0] count;
	reg[7:0] reg_map[4];

	always @(posedge clk or negedge reset_n) begin
		if(!reset_n)
			done <= 1'b1;
		else if(!done)
			case(op)
				3'd1,3'd1,3'd2,3'd3:done <= (count == 3'd1);//add
				3'd4:done <= (count == 3'd2);//and
				default:done <= 1'b1;
			endcase
		else if(start)
			done <= 1'b0;
	end
	
	always @* begin
		case(op)
			3'd1:result = A + B;
			3'd5:result = 15'd0; //assign write op
			3'd6:result = reg_map[B]; //assign read op
			default:result = 15'd0;
		endcase
	end
	
	
	always @(posedge clk or negedge reset_n) begin
		if(!reset_n) begin
			reg_map[0] <= 8'd0;
			reg_map[1] <= 8'd0;
			reg_map[2] <= 8'd0;
			reg_map[3] <= 8'd0;
		end else if(op == 3'd5) begin
			reg_map[B] <= A;
		end else
			reg_map <= reg_map;
	end
	
	always @(posedge clk or negedge reset_n) begin
		if(!reset_n)
			count <= 3'd0;
		else if(done)
			count <= 3'd0;
		else if(start)
			count <= 3'd1;
		else if(count != 3'd0)
			count <= count + 3'd1;
	end
	
endmodule