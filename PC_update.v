`timescale 1ns / 1ps

module PC_update(input jump,input branch_eq,input branch_neq,input branch_gt,input branch_gte,input branch_lt,input branch_lte,input branch_gtu,input branch_ltu,input[31:0] instruction,input[31:0] pc_in,input bool_eq,input bool_gt,input bool_lt,input bool_gte,input bool_lte,input bool_gtu,input bool_ltu,output reg[31:0] pc_out,output reg[31:0] next_pc);
    always @(*) begin
        if (jump) begin
            next_pc = instruction[25:0] << 2;
        end else if (branch_eq && bool_eq) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_neq && !bool_eq) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_gt && bool_gt) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_gte && bool_gte) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_lt && bool_lt) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_lte && bool_lte) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_gtu && bool_gtu) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else if (branch_ltu && bool_ltu) begin
            next_pc = pc_in + 4 + (instruction << 2);
        end else begin
            next_pc = pc_in + 4;
        end
        
        pc_out = next_pc;
    end
endmodule