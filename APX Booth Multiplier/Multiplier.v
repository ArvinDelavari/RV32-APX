module MUL 
(
      input  reset,
      input  clk,
      input  [31:0] read_a, read_x,
      output reg [31:0] result
);

wire [15:0] read_a_p;
wire [15:0] read_x_p;
assign read_a_p = read_a [15:0];
assign read_x_p = read_x [15:0];

reg   [2:0]  c = 0;
reg   [31:0] partial_product = 0;
reg   [31:0] shifted_pp = 0;
reg   [15:0] i = 0, j = 0;
reg   flag = 0, temp = 0;
wire  [15:0] tows_comp;

assign tows_comp = (~read_a_p) + 1'b1;

always @(posedge clk) 
begin
      if (reset == 1) 
      begin
            c = 0;
            partial_product = 0;
            shifted_pp = 0;
            i = 0; j = 0;
            flag = 0; temp = 0;
            result = 0;
      end
      if (reset == 0) 
      begin
      
         if (!flag)
            c = {read_x_p [1], read_x_p [0], 1'b0};
            flag = 1;
            case (c)
            3'b000,3'b111: begin
                  if(i < 8)
                  begin  i = i + 1;
                  c = {read_x_p [2*i+1], read_x_p [2*i], read_x_p [2*i-1]}; 
                  end else
                  c = 3'bxxx;
            end
            3'b001,3'b010: begin
                  if(i < 8)
                  begin i = i + 1;
                  c = {read_a_p [2*i+1], read_x_p [2*i], read_x_p[2*i-1]};
                  partial_product = {{16{read_a_p[15]}}, read_a_p};
                  if(i == 1'b1)
                        result = partial_product;
                  else begin
                        temp = partial_product[31];
                        j = i - 1;
                        j = j << 1;
                        shifted_pp = partial_product << j;
                        shifted_pp = {temp, shifted_pp[30:0]};
                        result = result + shifted_pp;
                  end
                  end else 
                  c = 3'bxxx;
            end
            3'b011: begin
                  if(i < 8)
                  begin i = i + 1;
                  c = {read_x_p [2*i+1], read_x_p [2*i], read_x_p [2*i-1]};
                  partial_product = {{15{read_a_p[15]}}, read_a_p,1'b0};
                  if(i == 1'b1)
                        result = partial_product;
                  else begin
                        temp = partial_product [31];
                        j = i - 1;
                        j = j << 1;
                        shifted_pp = partial_product << j;
                        shifted_pp = {temp, shifted_pp[30:0]};
                        result = result + shifted_pp;
                  end
                  end else 
                  c = 3'bxxx;
            end
            3'b100: begin
                  if(i < 8)
                  begin
                  i = i + 1;
                  c = {read_x_p [2*i+1], read_x_p [2*i], read_x_p [2*i-1]};
                  partial_product = {{15{tows_comp[15]}}, tows_comp, 1'b0};
                  if(i == 1'b1)
                        result = partial_product;
                  else begin
                        temp = partial_product[31];
                        j = i - 1;
                        j = j << 1;
                        shifted_pp = partial_product << j;
                        shifted_pp = {temp,shifted_pp[30:0]};
                        result = result + shifted_pp;
                  end
                  end else 
                  c = 3'bxxx;
            end
            3'b101, 3'b110: begin
                  if(i < 8)
                  begin
                  i = i + 1;
                  c = {read_x_p [2*i+1], read_x_p [2*i], read_x_p [2*i-1]};
                  partial_product = {{16{tows_comp[15]}}, tows_comp};
                  if(i == 1'b1)
                        result = partial_product;
                  else begin
                        temp = partial_product[31];
                        j = i - 1;
                        j = j << 1;
                        shifted_pp = partial_product << j;
                        shifted_pp = {temp, shifted_pp[30:0]};
                        result = result + shifted_pp;
                  end
                  end else 
                  c = 3'bxxx;
            end

            default:
            result = partial_product;
            endcase   

      end
end

endmodule