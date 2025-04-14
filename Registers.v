`timescale 1ns / 1ps

module Registers(input reg_dst,input [4:0] rs,input [4:0] rt,input [4:0] rd,output [31:0] read_data1,output [31:0] read_data2,input [31:0] write_data,input reg_write,input clk,input reset);
    reg [31:0] registers [0:31];
    reg [31:0] read_data1,read_data2;
    reg [31:0] write_data;

    assign read_data1 = registers[rs];
    assign read_data2 = registers[rt];

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            registers[0] <= 32'b0;
            registers[1] <= 32'b0;
            registers[2] <= 32'b0;
            registers[3] <= 32'b0;
            registers[4] <= 32'b0;
            registers[5] <= 32'b0;
            registers[6] <= 32'b0;
            registers[7] <= 32'b0;
            registers[8] <= 32'b0;
            registers[9] <= 32'b0;
            registers[10] <= 32'b0;
            registers[11] <= 32'b0;
            registers[12] <= 32'b0;
            registers[13] <= 32'b0;
            registers[14] <= 32'b0;
            registers[15] <= 32'b0;
            registers[16] <= 32'b0;
            registers[17] <= 32'b0;
            registers[18] <= 32'b0;
            registers[19] <= 32'b0;
            registers[20] <= 32'b0;
            registers[21] <= 32'b0;
            registers[22] <= 32'b0;
            registers[23] <= 32'b0;
            registers[24] <= 32'b0;
            registers[25] <= 32'b0;
            registers[26] <= 32'b0;
            registers[27] <= 32'b0;
            registers[28] <= 32'b0;
            registers[29] <= 32'b0;
            registers[30] <= 32'b0;
            registers[31] <= 32'b0;
        end
        else if(reg_write) begin
            if(reg_dst) begin
                registers[rd] <= write_data; // write to rd
            end
            else begin
                registers[rt] <= write_data; // write to rt
            end
        end
    end
endmodule 