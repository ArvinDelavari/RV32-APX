`include "Multiplier.v"
`timescale 1ns/1ps

module Multiplier_tb;

  reg clk;
  reg reset;
  reg [31:0] read_a;
  reg [31:0] read_x;
  wire [31:0] result;

  MUL mul(.clk(clk), .reset(reset), .read_a(read_a), .read_x(read_x), .result(result));

  always #1 clk = ~clk;

  initial begin
    $dumpfile("Approx_Multiplier.vcd");
    $dumpvars(0,Multiplier_tb);
    clk = 0;
    reset = 0;
    read_a = 16'b0000000000000011; read_x = 16'b0000000000000010;
    #50;
    reset = 1;
    #5;
    reset = 0;
    read_a = 16'b0000000000000010; read_x = 16'b0000000000001111;
    #50;
    reset = 1;
    #5;
    reset = 0;
    read_a = 16'b0000000100000110; read_x = 16'b0000000001001000;
    #50;
    reset = 1;
    #5;
    reset = 0;
    read_a = 16'b0000000000000111; read_x = 16'b0000001000001010;
    #50;
    reset = 1;
    #5;
    reset = 0;
    read_a = 16'b0000110000000001; read_x = 16'b0000010011011111;
    #50
    reset = 1;
    #5
    reset = 0;
    read_a = 16'b0000110101011001; read_x = 16'b0000011011011111;
    #50
    reset = 1;
    #5
    reset = 0;
    read_a = 16'b0010110101011001; read_x = 16'b0010011011011111;
    #50
    reset = 1;
    #5
    reset = 0;
    read_a = 16'b0010110000000001; read_x = 16'b1100110011011111;
    #50;
    reset = 1;
    #5;
    $finish;
  end

endmodule