`timescale 1ns / 1ps

module PC(input clk, input reset, input [31:0] next_pc, output reg [31:0] pc_out);
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            pc_out = -4;
        end
        else begin
            pc_out <= next_pc;
        end
    end
endmodule