`timescale 1ns / 1ps

module TestBench();
    // Inputs
    reg clk;
    reg reset;
    reg [31:0] d;
    reg we;

    // Instantiate the Main module (no parameters needed)
    Main main();

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        d = 32'h00000000;
        we = 0;

        // Monitor key signals
        $monitor("Time: %0t | PC_Out: %h | Instruction: %h | ALU_Result: %h", 
                 $time, main.pc_out, main.instruction, main.alu_result);

        // Apply reset
        #10 reset = 0;

        // Test case 1: Simple instruction fetch
        #10 d = 32'h20080005; // Example instruction (e.g., addi $t0, $zero, 5)
        we = 1;
        #10 we = 0;

        // Test case 2: Branch instruction
        #20 d = 32'h11080003; // Example branch instruction (e.g., beq $t0, $t1, label)
        we = 1;
        #10 we = 0;

        // Test case 3: Jump instruction
        #20 d = 32'h08000004; // Example jump instruction (e.g., j label)
        we = 1;
        #10 we = 0;

        // Test case 4: ALU operation
        #20 d = 32'h01094020; // Example R-type instruction (e.g., add $t0, $t0, $t1)
        we = 1;
        #10 we = 0;

        // End simulation
        #50 $finish;
    end
endmodule