`include "RV32_APX_CORE.v"
`timescale 1ns/100ps

module CPU_testbench();

  reg clk;
  reg reset;
  
  always #10 clk <= ~clk;
  RV32_APX_CORE CPU(.clk(clk), .reset(reset));
  
  initial begin
      $dumpfile("RV32_APX.vcd");
      $dumpvars(0, CPU_testbench);
      reset <= 1;
      clk <= 0;
      #1 reset = ~reset;
  end
  initial
   #60000 $finish;
  
endmodule