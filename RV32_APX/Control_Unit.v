module Control_Unit 
(
  input wire reset,
  input wire [6:0] opcode,
  output reg branch,
  output reg mem_read,
  output reg mem_to_regs,
  output reg [3:0] alu_operation,
  output reg mem_write,
  output reg alu_src,
  output reg reg_write
);

always @(reset, opcode) begin
  if (reset == 1) begin
              alu_src <= 0;
              mem_to_regs <= 0;
              reg_write <= 0;
              mem_read <= 0;
              mem_write <= 0;
              branch <= 0;
              alu_operation <= 0;
  end
  if (reset == 0) begin
      case (opcode)
          'h33: begin
              alu_src <= 0;
              mem_to_regs <= 0;
              reg_write <= 1;
              mem_read <= 0;
              mem_write <= 0;
              branch <= 0;
              alu_operation <= 2;
          end
          'h3: begin
              alu_src <= 1;
              mem_to_regs <= 1;
              reg_write <= 1;
              mem_read <= 1;
              mem_write <= 0;
              branch <= 0;
              alu_operation <= 0;
          end
          'h23: begin
              alu_src <= 1;
              mem_to_regs <= 0;
              reg_write <= 0;
              mem_read <= 0;
              mem_write <= 1;
              branch <= 0;
              alu_operation <= 0;
          end
          'h63: begin
              alu_src <= 0;
              mem_to_regs <= 0;
              reg_write <= 0;
              mem_read <= 0;
              mem_write <= 0;
              branch <= 1;
              alu_operation <= 7;
          end
      endcase
  end
end
endmodule
