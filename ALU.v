`timescale 1ns / 1ps

module ALU(input [4:0] alu_ctrl,input [31:0] data1,input [31:0] instruction,input [31:0] data2,output reg[31:0] lo, output reg[31:0] hi, output reg[31:0] alu_result,output reg bool_eq,output reg bool_gt,output reg bool_lt,output reg bool_gte,output reg bool_lte,output reg bool_gtu,output reg bool_ltu);

    always @(alu_ctrl,data1,data2) begin
        case(alu_ctrl)
            5'b00001: alu_result = data1 + data2;// signed , check overflow and send to EPC
            5'b00010: alu_result = data1 + data2;
            5'b00011: alu_result = data1 - data2;// signed , check overflow and send to EPC
            5'b00100: alu_result = data1 - data2;
            5'b00101: alu_result = data1 & data2;
            5'b00110: alu_result = data1 | data2;
            5'b00111: alu_result = data1 ^ data2;
            5'b01000: alu_result = data1 < data2 ? 1 : 0;
            5'b01001: alu_result = data2 << instruction[10:6];
            5'b01010: alu_result = data2 >> instruction[10:6];
            5'b01011: alu_result = data2 >>> instruction[10:6];
            5'b01100: alu_result = {instruction[15:0],16'b0};// lui
            5'b01101: {hi, lo} = data1*data2;
            
        endcase 
    end

    always @(data1,data2,alu_result) begin
        bool_eq = (alu_result == 0) ? 1 : 0;
        bool_gt = (alu_result > 0) ? 1 : 0;
        bool_lt = (alu_result < 0) ? 1 : 0;
        bool_gte = (alu_result >= 0) ? 1 : 0;
        bool_lte = (alu_result <= 0) ? 1 : 0;
        bool_gtu = (alu_result > 0) ? 1 : 0;
        bool_ltu = (alu_result < 0) ? 1 : 0;
    end
    
endmodule