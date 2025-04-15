`timescale 1ns / 1ps

module Instruction_memory(
    input wire [9:0] a,        // Address input
    input wire [31:0] d,      // Data input
    input wire [9:0] dpra,    // Address for read operation
    input wire clk,           // Clock signal
    input wire we,            // Write enable signal
    output wire [31:0] dpo    // Data output
);

    reg [31:0] memory [1023:0]; // 1024 x 32-bit memory

    always @(posedge clk) begin
        if (we) begin
            memory[a] <= d; // Write data to memory at address a
        end
    end

    assign dpo = memory[dpra]; // Read data from memory at address dpra
endmodule