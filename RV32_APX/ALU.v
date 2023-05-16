module ALU 
(
    input wire reset, 
    input wire [4:0]  alu_decode, 
    input wire [31:0] read_a, 
    input wire [31:0] read_x, 
    output reg [31:0] result
);
    always @(reset, alu_decode, read_a, read_x) begin
        if (reset==1) begin
          result <= 0;
        end
        if (reset == 0) begin
            case (alu_decode)
                `ALU_OP_AND: result <= read_a & read_x;
                `ALU_OP_OR:  result <= read_a | read_x;
                `ALU_OP_ADD: result <= read_a + read_x;
                `ALU_OP_ApproxAdd: begin //GeAr(32,2,6)
                    result[7:0]   <= (read_a[7:0] ^ read_x[7:0]) + ((read_a[7:0] & read_x[7:0]) << 1);
                    result[9:8]   <= (read_a[9:8] ^ read_x[9:8]) + ((read_a[9:8] & read_x[9:8]) << 1);
                    result[11:10] <= (read_a[11:10] ^ read_x[11:10]) + ((read_a[11:10] & read_x[11:10]) << 1);
                    result[13:12] <= (read_a[13:12] ^ read_x[13:12]) + ((read_a[13:12] & read_x[13:12]) << 1);
                    result[15:14] <= (read_a[15:14] ^ read_x[15:14]) + ((read_a[15:14] & read_x[15:14]) << 1);
                    result[17:16] <= (read_a[17:16] ^ read_x[17:16]) + ((read_a[17:16] & read_x[17:16]) << 1);
                    result[19:18] <= (read_a[19:18] ^ read_x[19:18]) + ((read_a[19:18] & read_x[19:18]) << 1);
                    result[21:20] <= (read_a[21:20] ^ read_x[21:20]) + ((read_a[21:20] & read_x[21:20]) << 1);
                    result[23:22] <= (read_a[23:22] ^ read_x[23:22]) + ((read_a[23:22] & read_x[23:22]) << 1);
                    result[25:24] <= (read_a[25:24] ^ read_x[25:24]) + ((read_a[25:24] & read_x[25:24]) << 1);
                    result[27:26] <= (read_a[27:26] ^ read_x[27:26]) + ((read_a[27:26] & read_x[27:26]) << 1);
                    result[29:28] <= (read_a[29:28] ^ read_x[29:28]) + ((read_a[29:28] & read_x[29:28]) << 1);
                    result[31:30] <= (read_a[31:30] ^ read_x[31:30]) + ((read_a[31:30] & read_x[31:30]) << 1);
                    end
                `ALU_OP_XOR:  result <= read_a ^ read_x;
                `ALU_OP_SLL:  result <= read_a << read_x;
                `ALU_OP_SRL:  result <= read_a >> read_x;
                `ALU_OP_SLT:  result <= (read_a < read_x) ? 1 : 0;
                `ALU_OP_SLTU: result <= (read_a < read_x) ? 1 : 0;
                `ALU_OP_SRA:  result <= (read_a[31] == 1) ? (read_a >> read_x) | ((1 << (32 - read_x)) - 1) : (read_a >> read_x);
                default:      result <= 0;
            endcase
        end
    end  
endmodule

module ALU_Control
(
  input wire reset,
  input wire [31:0] instruction,
  input wire [3:0] alu_operation,
  output reg [3:0] alu_decode
);
  always @(instruction, reset, alu_operation) 
  begin
    if(reset == 1) begin
      alu_decode<=0;
    end
    if (reset == 0) begin
      if (alu_operation == 2) 
      begin
        if (instruction[31:25] == 0) 
        begin
          if (instruction[14:12] == 0) begin
            alu_decode <= `ADD;
          end else if (instruction[14:12] == 1) begin
            alu_decode <= `SLL;
          end else if (instruction[14:12] == 2) begin
            alu_decode <= `SLT;
          end else if (instruction[14:12] == 3) begin
            alu_decode <= `SLTU;
          end else if (instruction[14:12] == 4) begin
            alu_decode<= `XOR;
          end else if (instruction[14:12] == 5) begin
            alu_decode <= `SRL;
          end else if (instruction[14:12] == 6) begin
            alu_decode <= `OR;
          end else if (instruction[14:12] == 7) begin
            alu_decode <= `AND;
          end
        end 
        else if (instruction[31:25] == 32) begin
          if (instruction[14:12] == 0) begin
            alu_decode <= `SUB;
          end else if (instruction[14:12] == 5) begin
            alu_decode <= `SRA;
          end
        end
      end 
      else if (alu_operation == 0) begin
        alu_decode <= `ADD;
      end 
      else if (alu_operation == 7) begin
        if (instruction[14:12] == 0) 
        begin
          alu_decode <= `XOR;
        end
      end
    end
  end
endmodule

module ALU_MUX 
(
     input wire reset,
     input wire alu_src,
     input wire [31:0] immediate_gen,
     input wire [31:0] read_b,
     output reg [31:0] read_x    
);
      always @(reset, immediate_gen, alu_src, read_b) 
      begin
        if (reset == 1) begin
          read_x <= 0;
        end
        if (reset == 0) begin
            if (alu_src) begin
                read_x <= immediate_gen;
            end 
            else begin
                read_x <= read_b;
            end
        end
      end
endmodule