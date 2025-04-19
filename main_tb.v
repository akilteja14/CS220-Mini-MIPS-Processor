`timescale 1ns / 1ps

module main_tb;

    reg clk,reset;
    main uut(clk,reset);
    initial begin 
        reset = 1;
        #12 reset = 0;
    end
    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end
    initial #200 $finish;
    
endmodule