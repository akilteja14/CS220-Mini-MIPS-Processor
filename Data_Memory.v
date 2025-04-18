`timescale 1ns / 1ps

module Data_memory(
    input wire clk,
    input wire [31:0] address,
    input wire [31:0] write_data,
    input wire mem_write,
    input wire mem_read,
    output reg [31:0] read_data
);
    reg [31:0] memory [0:1023]; // 4KB memory

    always @(posedge clk) begin
        if (mem_write) begin
            memory[address[11:2]] <= write_data; // Store data in memory
        end
    end

    always @(*) begin
        if (mem_read) begin
            read_data <= memory[address[11:2]]; // Read data from memory
        end
    end
endmodule