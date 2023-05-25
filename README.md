# RV32-APX
## 32 Bit RISC-V Processor with Approximate Adder
In this project, I made a 32 bit RISC-V processor which currently can perform an approximate addition function. 
The final goal of this project is to make an approximate processor which can perfom several approxiamte functions with good accuracy in order to be used on some image processing and computer vision cases.

This project is done with iverilog simulator and GTKWave tool.
To use this project you need to do the following steps:
- Write an assembly code with RIV32I instructions.
- Get the HEX or BIN output of the code.
- Copy each line of output to the imem.txt which is empty in this repository and dave it.
- Put your test cases in dmem.txt and save it.
- Simulate it with iverilog tool.

I used Venus simulator to write and simulate RISC-V assembly code and get the HEX output of my code in order to give it to the CPU instuction memory.
- Instuctions supported : ADD (Approximate), AND, OR, XOR, SLL, SRL, SLT, SLTU, SRA, MUL

An approximate Booth Multiplier is also added to this CPU:
- MUL is an R-TYPE Instruction (MUL rd, rs1, rs2)
- This is not a standard MUL function beacause this CPU does not support LBU.
- In this function we multiply first 16-bit of read_a and read_x 
   and the product will be saved in result(32-bit) register.
- Multiplier Unit is seperated from ALU because it will need a more complicated circuit and logic.
- In this CPU I used an approximate Radix-4 Booth Multiplier which you can see in the following paper:

Name : Design of Approximate Radix-4 Booth Multipliers for Error-Tolerant Computing 

Confrence: IEEE Transactions on computers, 2017

Link : http://www.ece.ualberta.ca/~jhan8/publications/Final_Feb_20_R4Booth_Mult_Brief.pdf

## Arvin Delavari - May 2023
