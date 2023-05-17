module Instruction_Memory
(
  input wire reset,
  input wire [31:0] read_address,
  output reg [31:0] instruction,
  output reg [4:0] read_a_select,
  output reg [4:0] read_b_select,
  output reg [4:0] write_a_select,
  output reg [6:0] opcode
);

  reg [31:0] inst_ram [0:1048576-1];
  
  initial begin
    $readmemb("C:/Users/ASUS/OneDrive/Desktop/Project Proposal/RV32_APX/imem.txt", inst_ram);
  end
  
  always @(reset, read_address, inst_ram[read_address]) 
  begin

    if (reset == 1) 
    begin
      instruction <= 0;
      write_a_select <= 0;
      read_a_select <= 0;
      read_b_select <= 0;
      opcode <= 0;
    end

    if (reset == 0) 
    begin
      instruction <= inst_ram[read_address];
      case (inst_ram[read_address][6:0])
        `RTYPE: begin
          read_a_select <= inst_ram[read_address][19:15];
          read_b_select <= inst_ram[read_address][24:20];
          opcode <= inst_ram[read_address][6:0];
          write_a_select <= inst_ram[read_address][11:7];
        end
        `ITYPE: begin
          read_a_select <= inst_ram[read_address][19:15];
          opcode <= inst_ram[read_address][6:0];
          write_a_select <= inst_ram[read_address][11:7];
        end
        `STYPE: begin
          read_a_select <= inst_ram[read_address][19:15];
          read_b_select <= inst_ram[read_address][24:20];
          opcode <= inst_ram[read_address][6:0];
          write_a_select <= inst_ram[read_address][24:20];
        end
        `JTYPE: begin
          read_a_select <= inst_ram[read_address][19:15];
          read_b_select <= inst_ram[read_address][24:20];
          opcode <= inst_ram[read_address][6:0];
        end
      endcase
    end
  end
  
endmodule

module Data_Memory
(
    input wire reset,
    input wire clk,
    input wire [31:0] result,
    input wire mem_write,
    input wire mem_read,
    input wire [31:0] read_b,
    output reg [31:0] read_data
);
    reg [31:0] data_ram[0:2048-1]; 
    
    initial begin
        $readmemb("C:/Users/ASUS/OneDrive/Desktop/Project Proposal/RV32_APX/dmem.txt", data_ram);
    end
    
    always @(reset) 
    begin
      if (reset == 1) 
      begin
        read_data <= 0;
      end
    end

    always @(posedge clk) 
    begin
        if (reset == 1) 
        begin
          read_data <=0 ;
        end
        if (reset == 0) 
        begin
            if (mem_write) begin
                data_ram[result] <= read_b;
            end
            else if (mem_read) begin
                read_data <= data_ram[result];
            end
        end
    end
endmodule
