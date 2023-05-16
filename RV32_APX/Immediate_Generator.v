module Immediate_Generator
(
  input wire reset,
  input wire [31:0] instruction,
  output reg [31:0] immediate_gen
);

  reg [19:0] high_bit;

  always @(reset, instruction) 
  begin
    if(reset == 1) 
    begin
      immediate_gen <= 0;
    end

    if (reset == 0) 
    begin
      if (instruction[6:0] == `ITYPE) begin
        immediate_gen[12-1:0] <= instruction[31:20];
      end 
      else if (instruction[6:0] == `STYPE) begin
        immediate_gen[11:5] <= instruction[31:25];
        immediate_gen[4:0] <= instruction[11:7];
      end 
      else if (instruction[6:0] == `JTYPE) begin
        immediate_gen[12] <= instruction[31];
        immediate_gen[10:5] <= instruction[30:25];
        immediate_gen[11] <= instruction[7];
        immediate_gen[5-1:1] <= instruction[11:8];
        immediate_gen[0] <= 0;
      end
      if (instruction[31] == 0) begin
        high_bit <= 0;
        immediate_gen[31:12] <= high_bit;
      end 
      else begin
        high_bit = 20'hfffff;
        immediate_gen[31:12] <= high_bit;
      end
    end
  end

endmodule