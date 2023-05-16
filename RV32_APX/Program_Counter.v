module PC_Assign
(
      input reset, 
      input [31:0] pc,
      output reg [31:0] read_address
);
  always @(reset, pc) begin
    if(reset == 1) begin
      read_address <=0;
    end
    if (reset == 0) begin
      read_address <= pc;
    end
  end
endmodule

module PC_MUX
(
  input wire reset,
  output reg [31:0] pc,
  input wire [31:0] pc_address,
  input wire [31:0] jmp_address,  
  input wire pc_select
);

  always @(reset, pc_select, jmp_address, pc_address) begin
    if (reset == 1) begin
      pc <= 0;
    end 
    else begin
      if (pc_select) 
      begin
        pc <= jmp_address;
      end 
      else begin
        pc <= pc_address;
      end
    end
  end
endmodule

module PC_Adder
(
      input wire reset, 
      input wire step, 
      input wire [31:0] pc, 
      output reg [31:0] pc_address
);
  always @(posedge step, posedge reset) begin
    if (reset == 1) begin
      pc_address <= 0;
    end
    else begin
    if (reset == 0) begin
      pc_address <= pc + 1;
    end
    end
  end
endmodule

module JMP_Adder
(
    input wire reset,
    input wire [31:0] read_address,
    input wire [31:0] immediate_gen,
    output reg [31:0] jmp_address
);
always @(read_address, reset, immediate_gen) begin
  if (reset == 1) begin
    jmp_address <= 0;
  end   
  if (reset == 0) begin
      jmp_address = (read_address + immediate_gen);
  end
end
endmodule

module taken
(
      input wire [31:0] result,
      input wire branch,
      output reg pc_select
);
always @(branch, result) begin
    if (!result && branch)
        pc_select <= 1;
    else
        pc_select <= 0;
end
endmodule