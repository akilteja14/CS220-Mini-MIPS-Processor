`timescale 1ns / 1ps

module main_tb;

    reg clk;
    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end

    main uut(clk);


endmodule