`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/09/2025 02:26:50 PM
// Design Name: 
// Module Name: decode
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


module Decode (
    input  wire [31:0] instr,         // fetched instruction
    //input  wire        zero_flag,     // from ALU (for integer branches)
    //input  wire        fp_cc,         // FP condition-code flag (for FP branches)
    output wire [4:0]  rs, rt, rd,    // register specifiers
    output wire [4:0]  shamt,         // shift amount
    output wire [15:0] imm16,         // raw immediate
    output wire [31:0] imm_se,        // sign-extended immediate
    output wire [31:0] imm_ze,        // zero-extended immediate
    output wire [25:0] addr26,        // jump address
    // --- Control signals ---
    output reg         reg_dst, alu_src, mem_to_reg, reg_write,
                       mem_read, mem_write, branch_eq, branch_ne,
                       branch_gt, branch_gte, branch_lt, branch_lte,
                       branch_gtu, branch_ltu, jump, jump_reg, link,
    output reg [4:0]   alu_ctrl        // ALU main op code
    //output reg [2:0]   fp_op          // floating-point operation code
);
    wire [5:0] opcode = instr[31:26];
    wire [4:0] rs_f    = instr[25:21];
    wire [4:0] rt_f    = instr[20:16];
    wire [4:0] rd_f    = instr[15:11];
    wire [4:0] shamt_f = instr[10:6];
    wire [5:0] funct   = instr[5:0];
    wire [15:0] imm_f  = instr[15:0];
    wire [25:0] addr_f = instr[25:0];
    assign rs     = rs_f;
    assign rt     = rt_f;
    assign rd     = rd_f;
    assign shamt  = shamt_f;
    assign imm16  = imm_f;
    assign addr26 = addr_f;
    assign imm_se = {{16{imm_f[15]}}, imm_f};
    assign imm_ze = {16'b0, imm_f};
    always @(*) begin
        {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write,
         branch_eq, branch_ne, branch_gt, branch_gte, branch_lt, branch_lte,
         branch_gtu, branch_ltu, jump, jump_reg, link} = 0;
        alu_ctrl = 5'b00000;
        //fp_op  = 3'b000;
        case (opcode)
            // R-Type Integer Arithmetic & Logical (opcode=0)
            6'b000000: begin
                reg_dst   = 1;
                reg_write = 1;
                alu_ctrl    = 5'b00000; // use funct
                case (funct)
                    6'b100000: alu_ctrl = 5'b00001; // add
                    6'b100001: alu_ctrl = 5'b00010; // addu
                    6'b100010: alu_ctrl = 5'b00011; // sub
                    6'b100011: alu_ctrl = 5'b00100; // subu
                    6'b100100: alu_ctrl = 5'b00101; // and
                    6'b100101: alu_ctrl = 5'b00110; // or
                    6'b100110: alu_ctrl = 5'b00111; // xor
                    6'b101010: alu_ctrl = 5'b01000; // slt
                    6'b000000: alu_ctrl = 5'b01001; // sll
                    6'b000010: alu_ctrl = 5'b01010; // srl
                    6'b000011: alu_ctrl = 5'b01011; // sra
                    6'b011000: begin
                        alu_ctrl = 5'b01101; // mul lo, hi
                        reg_dst = 0;
                        reg_write = 0;
                    end
                    default: ;
                endcase
            end
            // I-Type Arithmetic/Logical
            6'b001000: begin // addi
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b00001; // ADDI
            end
            6'b001001: begin
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b00010; // ADDIU
            end
            6'b001100: begin // andi
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b00101; // ANDI
            end
            6'b001101: begin // ori
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b00110; // ORI
            end
            6'b001110: begin // xori
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b00111; // XORI
            end
            6'b001010: begin // slti
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b01000; // SLTI
            end
            6'b001111: begin // lui
                reg_dst    = 0;
                alu_src    = 1;
                reg_write  = 1;
                alu_ctrl     = 5'b01100; // LUI
            end
            // Data Transfer
            6'b100011: begin // lw
                reg_dst    = 0;
                alu_src    = 1;
                mem_to_reg = 1;
                reg_write  = 1;
                mem_read   = 1;
                alu_ctrl     = 5'b00001;
            end
            6'b101011: begin // sw
                alu_src    = 1;
                mem_write  = 1;
                alu_ctrl     = 5'b00001;
            end
            // Conditional Branches
            6'b000100: begin branch_eq  = 1;alu_ctrl = 5'b00011; end// beq
            6'b000101: begin branch_ne  = 1;alu_ctrl = 5'b00011; end // bne
            6'b111000: begin branch_gt  = 1;alu_ctrl = 5'b00011; end // bgt
            6'b001111: begin branch_gte = 1;alu_ctrl = 5'b00011; end // bgte
            6'b111001: begin branch_lt  = 1;alu_ctrl = 5'b00011; end // ble
            6'b111010: begin branch_lte = 1;alu_ctrl = 5'b00011; end // bleq
            6'b111011: begin branch_ltu = 1;alu_ctrl = 5'b00011; end // bleu
            6'b111100: begin branch_gtu = 1;alu_ctrl = 5'b00011; end // bgtu
            // Unconditional Branches
            6'b000010: jump = 1; // j
            6'b000011: begin // jal
                jump      = 1;
                link      = 1;
                reg_write = 1;
            end
            6'b000000: if (funct == 6'b001000) jump_reg = 1; // jr
            // Floating-Point Operations
//            6'b010001: begin
//                case (rs_f)
//                    5'b00000: begin reg_dst = 1; reg_write = 1; fp_op = 3'b000; end // mfcl
//                    5'b00100: fp_op = 3'b001; // mtc1
//                    5'b10000: fp_op = 3'b010; // add.s
//                    5'b10001: fp_op = 3'b011; // sub.s
//                    5'b11010: fp_op = 3'b100; // mov.s
//                    5'b11000: fp_op = 3'b101; // c.eq.s
//                    5'b11001: fp_op = 3'b110; // c.le.s
//                    5'b11100: fp_op = 3'b111; // c.lt.s
//                    default: ;
//                endcase
//            end
            default: ;
        endcase
    end
endmodule