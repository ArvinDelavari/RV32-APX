# RV32-APX
## 32 Bit RISC-V Processor with Approximate Adder
In this project, I made an RV32I processor which currently can perform an approximate addition function. 
My goal is to make an approximate processor which can perfom several approxiamte functions with good accuracy and I'll update this project with other approximate arithmetic functions soon. This project is done with iverilog simulator and GTKWave tool.
To use this project you need to do the following steps:
- Write an assembly code with RIV32I instructions.
- Get the HEX or BIN output of the code.
- Copy each line of output to the imem.txt which is empty in this repository and dave it.
- Put your test cases in dmem.txt and save it.
- Simulate it with iverilog tool.

I used Venus simulator to write and simulate RISC-V assembly code and get the HEX output of my code in order to give it to the CPU instuction memory.
- Instuctions supported : ADD (Approximate), AND, OR, XOR, SLL, SRL, SLT, SLTU, SRA
## Arvin Delavari - May 2023
