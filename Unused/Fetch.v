`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2025 04:19:41 PM
// Design Name: 
// Module Name: fetch
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module fetch(state, program_counter, instruction);
    
    
//	input [2:0] state;
	
//	output [2:0] program_counter;
//	output [31:0] instruction;
	
//	reg [2:0] program_counter;
//	reg [31:0] instruction;
	
//	reg [31:0] instruction_mem [0:6];
	
//	initial begin
//	   	program_counter = 0;
//		instruction = 0;
		
//		instruction_mem[0] = 32'b001001_00000_00001_0000000000101101;
//		instruction_mem[1] = 32'b001001_00000_00010_1111111111101100;
//		instruction_mem[2] = 32'b001001_00000_00011_1111111111000100;
//		instruction_mem[3] = 32'b001001_00000_00100_0000000000011110;
//		instruction_mem[4] = 32'b000000_00001_00010_00101_00000_100001;
//		instruction_mem[5] = 32'b000000_00011_00100_00110_00000_100001;
//		instruction_mem[6] = 32'b000000_00101_00110_00101_00000_100011;
//	end
	
////	always @ (posedge clk) begin
////	   	if (state == `STATE_IF) begin
////		   	instruction <= instruction_mem[program_counter];
////			program_counter <= program_counter + 1;
////		end
////	end
// endmodule

module Fetch(addr, instruction);
input [9:0] addr;
output [31:0] instruction;
wire clk;
wire we = 0;

// memory_wrapper mem(a,d,addr,clk,we,instruction);

endmodule

