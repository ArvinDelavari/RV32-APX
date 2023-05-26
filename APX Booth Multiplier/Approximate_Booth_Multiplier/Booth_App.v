module Booth_App #(parameter WIDTH = 8)
(
    input signed    [WIDTH - 1 : 0] input_A,
    input signed    [WIDTH - 1 : 0] input_B, 
    output signed   [2 * WIDTH - 1 : 0] C 
);
    wire signed [WIDTH - 1 : -1] A = {input_A, 1'b0};
    wire signed [WIDTH - 1 : -1] B = {input_B, 1'b0};
    wire signed [2 * WIDTH - 1 : 0] PP [0 : (WIDTH / 2) - 1];
    wire S [0 : (WIDTH / 2) - 1];
    genvar i, j;
    generate
        for (i = 0; i < WIDTH / 2; i = i + 1)
        begin
            for(j = 0; j < WIDTH; j = j + 1)
            begin
                assign PP[i][j] =   (   (B[2 * i] ^ B[2 * i - 1]) &&
                                        (B[2 * i + 1] ^ A[j])  
                                    );
                assign S[i] = B[2 * i + 1];
            end
            assign PP[i][2 * WIDTH - 1 : WIDTH] = {WIDTH{S[i]}};
        end
    endgenerate

    assign  C = ( (PP[0] + S[0]) << 0)    +   
                ( (PP[1] + S[1]) << 2)    +   
                ( (PP[2] + S[2]) << 4)    +   
                ( (PP[3] + S[3]) << 6);
endmodule