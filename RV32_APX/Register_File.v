module Register_File
(
  input wire reset,
  input wire clk,
  input wire [4:0] read_a_select,
  input wire [4:0] read_b_select,
  input wire [4:0] write_a_select,
  input wire [31:0] write_a,
  input wire write_flag,
  output reg [31:0] read_a,
  output reg [31:0] read_b
);

  reg [31:0] registers [0:31];

  integer i,file;
  always @(reset, read_b_select, read_a_select, registers[i]) 
  begin

    if(reset == 1) begin
      read_a <= 0;
      read_b <= 0;
      for(i = 0; i < 32; i = i + 1) 
      begin
        registers[i]<=1;
      end     
      end

    if (reset == 0) begin
      if (read_a_select != 0) begin
        read_a <= registers[read_a_select];
      end
      if (read_b_select != 0) begin
        read_b <= registers[read_b_select];
      end
    end

  end
  
  always @(posedge clk) begin
    if (reset == 0) begin
      if (write_flag && (write_a_select > 0)) 
      begin
         registers[write_a_select] <= write_a;
         file = $fopen("C:/Users/ASUS/OneDrive/Desktop/Project Proposal/RV32_APX/output.txt", "a");
         $fwrite(file, "%d\n", write_a);
      end
    end
  end
endmodule

module Write_MUX 
(
  input wire reset,
  output reg [31:0] write_a,
  input wire mem_to_regs,
  input wire [31:0] result,
  input wire [31:0] read_data
);
always @(reset, mem_to_regs, read_data, result) begin
  if (reset == 1) 
  begin
      write_a <= 0;
  end
  if (reset == 0) 
  begin
    if (mem_to_regs)
      write_a <= read_data;
    else
      write_a <= result;
  end
end
endmodule