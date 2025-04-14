`timescale 1ns / 1ps

module main();
    PC pc(.clk(clk), .reset(reset), .next_pc(next_pc), .pc_out(pc_out));
    PC_update pc_update(.jump(jump), .branch_eq(branch_eq), .branch_neq(branch_neq), .branch_gt(branch_gt), .branch_gte(branch_gte), .branch_lt(branch_lt), .branch_lte(branch_lte), .branch_gtu(branch_gtu), .branch_ltu(branch_ltu), .instruction(instruction), .pc_in(pc_out), .bool_eq(bool_eq), .bool_gt(bool_gt), .bool_lt(bool_lt), .bool_gte(bool_gte), .bool_lte(bool_lte), .bool_gtu(bool_gtu), .bool_ltu(bool_ltu), .pc_out(next_pc));

    // dist_mem_gen_0 Instruction_memory (
    // .a(a),        // input wire [8 : 0] a
    // .d(d),        // input wire [31 : 0] d
    // .dpra(pc_out),  // input wire [8 : 0] dpra
    // .clk(clk),    // input wire clk
    // .we(we),      // input wire we
    // .dpo(instruction)    // output wire [31 : 0] dpo
    // );

    Instruction_memory instruction_memory(.a(pc_out), .d(d), .dpra(pc_out), .clk(clk), .we(we), .dpo(instruction));

    Fetch fetch(.addr(pc_out), .instruction(instruction));
    Decode decode(.instr(instruction), .rs(rs), .rt(rt), .rd(rd), .shamt(shamt), .imm16(imm16), .imm_se(imm_se), .imm_ze(imm_ze), .addr26(addr26), .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_write(reg_write), .mem_read(mem_read), .mem_write(mem_write), .branch_eq(branch_eq), .branch_ne(branch_ne), .branch_gt(branch_gt), .branch_gte(branch_gte), .branch_lt(branch_lt), .branch_lte(branch_lte), .branch_gtu(branch_gtu), .branch_ltu(branch_ltu), .jump(jump), .jump_reg(jump_reg), .link(link));

    Registers registers(.clk(clk), .reset(reset),.reg_dst(reg_dst), .reg_write(reg_write), .rs(rs), .rt(rt), .rd(rd), .write_data(write_data), .read_data1(read_data1), .read_data2(read_data2));
    ALU alu(.alu_ctrl(alu_ctrl), .data1(read_data1), .instruction(instruction), .read2(read_data2), .alu_src(alu_src), .alu_result(alu_result), .bool_eq(bool_eq), .bool_gt(bool_gt), .bool_lt(bool_lt), .bool_gte(bool_gte), .bool_lte(bool_lte), .bool_gtu(bool_gtu), .bool_ltu(bool_ltu));

    Data_memory data_memory(.alu_result(alu_result), .read_data(read_data), .write_data(write_data), .mem_read(mem_read), .mem_write(mem_write), .clk(clk), .reset(reset));

    // dist_mem_gen_0 Data_memory (
    // .a(a),        // input wire [8 : 0] a
    // .d(d),        // input wire [31 : 0] d
    // .dpra(alu_result),  // input wire [8 : 0] dpra
    // .clk(clk),    // input wire clk
    // .we(mem_write),      // input wire we
    // .dpo(dpo)    // output wire [31 : 0] dpo
    // );
endmodule