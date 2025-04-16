`timescale 1ns / 1ps

module Instruction_memory(
    input wire [9:0] a,        // Address input
    input wire [31:0] d,      // Data input
    input wire [9:0] dpra,    // Address for read operation
    input wire clk,           // Clock signal
    input wire we,            // Write enable signal
    output wire [31:0] dpo    // Data output
);

    parameter INSTR_MEM_HEIGHT = 1024;
    reg [31:0] instr_mem[INSTR_MEM_HEIGHT-1:0]; // 1024 x 32-bit instruction memory

    // always @(posedge clk) begin
    //     if (we) begin
    //         instr_mem[a] <= d; // Write data to instruction memory at address a
    //     end
    // end
    
    integer i;
    initial begin
        instr_mem[0] = 32'b001000_00000_00001_0000000000001010; // addi $1, $0, 10
        instr_mem[1] = 32'b001000_00001_00010_0000000000010100; // addi $2, $1, 20
        instr_mem[2] = 32'b000000_00001_00010_0000000000011000; // mul $1, $2 -> result in lo and hi
        instr_mem[3] = 32'b000000_00001_00010_00011_00000_100000;   // add $3, $1, $2;
        instr_mem[4] = 32'b101011_00000_00011_0000000000000100; // sw $3, 4($0)
        
        //instr_mem[5] = 32'b100011_00000_00100_0000000000000100; // lw $4, 4($0)
        // to put an instruction to trigger the end of simulation when the code has finished executing
        
        
        // for (i = 0; i < INSTR_MEM_HEIGHT; i = i + 1) begin
        //     instr_mem[i] = 32'b11111100000000000000000000000000;
        // end

        // instr_mem[0] = 32'b001000_10001_10001_0000000000001001; //addi $s1, $s1, 9 (10 is the size of the array)
        // instr_mem[1] = 32'b001000_00000_01000_0000000000000000; //addi $t0, $zero, 0 ($t0 is i)
        // //outer loop begins here 
        // instr_mem[2] = 32'b001000_00000_01001_0000000000000000; //addi $t1, $zero, 0 ($t1 is j)
        // instr_mem[3] = 32'b001000_10000_10010_0000000000000000; //addi $s2, $s0, 0  (s2 is the address of the array)
        // instr_mem[4] = 32'b000000_10001_01000_10111_00000_100010; //sub $s7, $s1, $t0 (s7 = n - 1 - i)
        // instr_mem[5] = 32'b100011_10010_01010_0000000000000000; //lw $t2, 0($s2) (store arr[j] in t2)
        // instr_mem[6] = 32'b100011_10010_01011_0000000000000001; //lw $t3, 1($s2) (store arr[j + 1] in t3)
        // instr_mem[7] = 32'b000000_01011_01010_01100_00000_101010; //slt $t4, $t2, $t3 (if arr[j] < arr[j + 1] then t4 = 1)
        // instr_mem[8] = 32'b000100_01100_00000_0000000000000010; //beq $t4, $zero, outer_loop, if not equal then swap
        // //swap begins here
        // instr_mem[9] = 32'b101011_10010_01010_0000000000000001; //sw $t2, 1($s2)
        // instr_mem[10] = 32'b101011_10010_01011_0000000000000000; //sw $t3, 0($s2)
        // //swap ends here
        // instr_mem[11] = 32'b001000_10010_10010_0000000000000001; //addi $s2, $s2, 1 (s2 = s2 + 1)
        // instr_mem[12] = 32'b001000_01001_01001_0000000000000001; //addi $t1, $t1, 1 (j = j + 1)
        // instr_mem[13] = 32'b000101_01001_10111_1111111111110111; //bne $t1, $s7, outer_loop (if j != n - 1 - i then go to outer_loop)
        // instr_mem[14] = 32'b001000_01000_01000_0000000000000001; //addi $t0, $t0, 1 (i = i + 1)
        // instr_mem[15] = 32'b000101_01000_10001_1111111111110010; //bne $t0, $s7, outer_loop (if i != n - 1 then go to outer_loop)
        // //outer loop ends here

    // instruction = 32'b11111100000000000000000000000000;
    end

    assign dpo = instr_mem[dpra >> 2]; // Read data from instruction memory at address dpra


endmodule