`include "Definitions.v"
`include "Control_Unit.v"
`include "Register_File.v"
`include "Program_Counter.v"
`include "Immediate_Generator.v"
`include "ALU.v"
`include "Multiplier_Unit.v"
`include "Memories.v"

`timescale 1ns/100ps

module RV32_APX_CORE
(
      input wire clk,
      input wire reset
);
  wire pc_select;
  wire branch, mem_read, mem_to_regs, mem_write, alu_src, reg_write;
  wire [4:0] read_a_select, read_b_select, write_a_select;
  wire [31:0] write_a, read_a, read_b, read_x;
  wire [3:0] alu_operation;
  wire [6:0] opcode;
  wire [31:0] pc, result, read_data, shl;
  reg  [31:0] aux;
  wire [31:0] immediate_gen;
  wire [3:0] alu_decode;
  reg step;
  wire [31:0] read_address, instruction, pc_address, jmp_address;

    initial begin
      step <= 0;
    end
    
  Control_Unit control(reset, opcode, branch, mem_read, mem_to_regs, alu_operation, mem_write, alu_src, reg_write);
  
  Data_Memory dmem(reset, clk, result, mem_write, mem_read, read_b, read_data);
  Instruction_Memory imem(reset, read_address, instruction, read_a_select, read_b_select, write_a_select, opcode);
  
  ALU ALU_APX(reset, alu_decode, read_a, read_x, result);
  ALU_MUX ALU_APX_MUX(reset, alu_src, immediate_gen, read_a, read_x);
  ALU_Control ALU_APX_Control(reset, instruction, alu_operation, alu_decode);
  Multiplier mul(reset, clk, read_a, read_x,result);

  Register_File Reg_File(reset, clk, read_a_select, read_b_select, write_a_select, write_a, reg_write, read_a, read_b);
  
  PC_Adder pc_add(reset, step, pc, pc_address);
  JMP_Adder jmp_add(reset, read_address, immediate_gen, jmp_address);
  PC_MUX ProgramCounter_mux(reset, pc, pc_address, jmp_address, pc_select);
  PC_Assign next_pc(reset, pc, read_address);

  
  Write_MUX write(reset, write_a, mem_to_regs, result, read_data);
  Immediate_Generator imm_gen(reset, instruction, immediate_gen);
  taken tkn(result, branch, pc_select);

  always @(posedge clk)
  begin
  if (reset == 0)
    begin
      step <= ~step;
    end
  end
endmodule

module clock_generator(output reg clk);
  always #5 clk <= ~clk;
endmodule
