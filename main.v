`timescale 1ns / 1ps

module main(input clk, input reset);
    wire [31:0] d;// Ensure d is declared as a 32-bit signal
    wire we;
    wire [31:0] pc_out; // Ensure pc_out is declared as a 32-bit signal
    wire [31:0] next_pc;
    wire [31:0] instruction;
    wire [31:0] read_data1, read_data2, write_data1, alu_result, read_data, data1, data2;
    wire [4:0] rs, rt, rd, shamt;
    wire [31:0] lo, hi;
    wire [15:0] imm16;
    wire [31:0] imm_se, imm_ze;
    wire [25:0] addr26;
    wire [4:0] alu_ctrl;
    wire reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write;
    wire branch_eq, branch_ne, branch_gt, branch_gte, branch_lt, branch_lte, branch_gtu, branch_ltu;
    wire jump, jump_reg, link;
    wire bool_eq, bool_gt, bool_lt, bool_gte, bool_lte, bool_gtu, bool_ltu;

    PC pc(.clk(clk), .reset(reset), .next_pc(next_pc), .pc_out(pc_out));

    // dist_mem_gen_0 Instruction_memory (
    // .a(a),        // input wire [8 : 0] a
    // .d(d),        // input wire [31 : 0] d
    // .dpra(pc_out),  // input wire [8 : 0] dpra
    // .clk(clk),    // input wire clk
    // .we(we),      // input wire we
    // .dpo(instruction)    // output wire [31 : 0] dpo
    // );

    Instruction_memory instruction_memory(.a(pc_out[9:0]), .d(d), .dpra(pc_out[9:0]), .clk(clk), .we(we), .dpo(instruction));

    //Fetch fetch(.addr(pc_out), .instruction(instruction));
    Decode decode(.instr(instruction), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt), .imm16(imm16), .imm_se(imm_se), .imm_ze(imm_ze), .addr26(addr26), .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_write(reg_write), .mem_read(mem_read), .mem_write(mem_write), .branch_eq(branch_eq), .branch_ne(branch_ne), .branch_gt(branch_gt), .branch_gte(branch_gte), .branch_lt(branch_lt), .branch_lte(branch_lte), .branch_gtu(branch_gtu), .branch_ltu(branch_ltu), .jump(jump), .jump_reg(jump_reg), .link(link), .alu_ctrl(alu_ctrl));

    PC_update pc_update(.jump(jump), .branch_eq(branch_eq), .branch_neq(branch_neq), .branch_gt(branch_gt), .branch_gte(branch_gte), .branch_lt(branch_lt), .branch_lte(branch_lte), .branch_gtu(branch_gtu), .branch_ltu(branch_ltu), .instruction(instruction), .pc_in(pc_out), .bool_eq(bool_eq), .bool_gt(bool_gt), .bool_lt(bool_lt), .bool_gte(bool_gte), .bool_lte(bool_lte), .bool_gtu(bool_gtu), .bool_ltu(bool_ltu), .pc_out(next_pc));

    assign write_data1 = mem_to_reg ? read_data : alu_result;

    //assign rd = reg_dst ? rd : rt;

    Registers registers(.clk(clk), .reg_dst(reg_dst), .reg_write(reg_write), .rs(rs), .rt(rt), .rd(rd), .write_data(write_data1), .read_data1(read_data1), .read_data2(read_data2));

    assign data1 = read_data1; // Use imm_se for ALU source 1 if alu_src is 1, otherwise use read_data1
    assign data2 = alu_src ? imm_se : read_data2; 

    ALU alu(.alu_ctrl(alu_ctrl), .data1(data1), .instruction(instruction),.hi(hi), .lo(lo), .data2(data2), .alu_result(alu_result), .bool_eq(bool_eq), .bool_gt(bool_gt), .bool_lt(bool_lt), .bool_gte(bool_gte), .bool_lte(bool_lte), .bool_gtu(bool_gtu), .bool_ltu(bool_ltu));

    Data_memory data_memory(.address(alu_result), .read_data(read_data), .write_data(read_data2), .mem_read(mem_read), .mem_write(mem_write), .clk(clk));
    // dist_mem_gen_0 Data_memory (
    // .a(a),        // input wire [8 : 0] a
    // .d(d),        // input wire [31 : 0] d
    // .dpra(alu_result),  // input wire [8 : 0] dpra
    // .clk(clk),    // input wire clk
    // .we(mem_write),      // input wire we
    // .dpo(dpo)    // output wire [31 : 0] dpo
    // );
endmodule