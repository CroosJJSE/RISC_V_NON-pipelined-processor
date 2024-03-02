# RISC_V_single_clock_Micro_programmed_processor
This repo is about the single clock microprogrammed Risc_V processor
## WHY RISC_V?
```
1. Open Standard
   - RISC-V is an open and royalty-free ISA.
   - x86 is a proprietary ISA, and manufacturers typically need to license it from Intel or AMD.

2. Customizability
   - RISC-V allows for a high degree of customization in its instruction set.
   - x86 is a more fixed architecture with limited customization options.

3. Modularity
   - RISC-V is designed with modularity, supporting various extensions.
   - x86 has a more complex and less modular architecture.

4. Scalability
   - RISC-V is scalable from low-power embedded systems to high-performance computing.
   - x86 is primarily used in higher-end desktops, servers, and data centers.

5. Ecosystem Growth
   - RISC-V's ecosystem is rapidly growing with support from various industries and academia.
   - x86 has a mature and well-established ecosystem.

6. Lower Power Consumption
   - RISC-V's simplified instruction set and architecture can result in lower power consumption.
   - x86 processors tend to consume more power, which can be a concern for battery-powered devices.

7. Reduced Instruction Set
   - RISC-V follows the RISC philosophy, emphasizing a simpler and streamlined instruction set.
   - x86 has a more complex instruction set due to historical reasons, which can impact power efficiency.

8. Custom Hardware Acceleration
   - RISC-V's open nature allows for the integration of custom hardware accelerators, making it suitable for specialized workloads.
   - x86 also supports custom accelerators but may be more tightly integrated with proprietary technologies.

9. Cost
   - RISC-V can be cost-effective because of its open nature and lack of licensing fees.
   - x86 may involve licensing costs and royalties, which can add to the overall cost of products.

```
## why microprogammed?
Certainly, here are the benefits of microprogrammed processors summarized in point form:
```
1. Flexibility
   - Microprogrammed processors offer greater flexibility.
   - Control logic is stored in microcode, which can be easily modified or updated.
   - Allows for changes to the processor's behavior without altering hardware.

2. Simpler Hardware Design
   - Microprogrammed processors often have simpler and more regular hardware designs.
   - This simplifies development, debugging, and maintenance compared to hardwired processors.

3. Higher Instruction Set Complexity
   - Microprogramming supports complex and diverse instruction sets.
   - Easier implementation of a wide range of instructions due to microcode storage.

4. Emulation and Virtualization
   - Useful for emulating other processor architectures or virtualizing hardware resources.
   - Microcode can mimic the behavior of different architectures or virtualize hardware components.

```

# My progress
## Start from R type
1. Get the instruction
   - add t0 t2 t3
2. Parse instruction fields (rd, rs1, rs2, operation…)
   - rd = t0 rs1 = t2 rs2 = t3
3. Read data based on parsed operands
   - R[t2] R[t3]
4. Perform operation
   - R[t2] + R[t3]
5. Write result to our destination register
   - R[t0] = R[t2] + R[t3]

![IMG_8073](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/68bcb02e-8c77-42cd-b38d-fdfb94798d28)

# RISC-V Instruction Types

This repository provides explanations and examples of different instruction types in the RISC-V assembly language.

## R-Type Instructions

R-Type instructions operate on two source registers and store the result in a destination register.

Example:
```assembly
ADD x3, x1, x2   // Add the contents of registers x1 and x2 and store the result in register x3
```

 ## Arithmetic I-Type
We need an additional module (imm.gen) to extract the immediate value from the instruction,
we have to extend the values accordoing to the RISC V 
I-Type instructions operate on one register and an immediate value, storing the result in a destination register.


![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/fdb50e10-cba8-4417-9bf3-363411760543)
```
ADDI x3, x1, 10   // Add the immediate value 10 to the contents of register x1 and store the result in register x3
```


and we need a mux to connect the imm.gen and Data B(from reg.file) to the ALU. so the updated schematic will be

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/f3254222-c1e3-40a0-b955-60f083846de9)

# RISC-V Memory access instructions
## Load type

```
LW x3, 100(x1)   // Load a word from memory at address (100 + contents of register x1) and store it in register x3
```
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/825cbca8-75f2-498d-b826-e6932ad29d06)
here we will have base address in rs1 and increment will be in immediate and we have to store the value from memory to rd register.
here we are implementing another module "data memeory".

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/201d522f-2331-4fd5-b5f5-3190e103b90b)



this is the schematic after the load instruction
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/2afb7640-4ea1-4754-8016-8cada2cac9f1)



##  S-Type store value in data memory
```
SW x3, 100(x1)   // Store the contents of register x3 into memory at address (100 + contents of register x1)
```
we are moving the data from the regfile to data memory.
we connect the B reg to data input directly.
### rs1 rs2 imm => store the value[rs2] in MEM[value[rs1]+ imm ]

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/2e82a9d0-ff05-4455-aaf4-f24040d397bc)

Here the immediate generating is different because of the instruction format,
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/8d3964c3-ca70-4b92-847e-bbb3e92ff71f)

# RISC-V Control Flow Instructions

## B-type
```
BEQ x1, x2, 100   // Branch to address 100 if the contents of registers x1 and x2 are equal
```
this is conditional branching,
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/8868f3e4-d891-4a88-82ad-36710db2b627)

it will compare the val[rs1],val[rs2]; the condition is encoded in func3 

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/6edbc832-9823-48cf-8612-b0f21331034f)

the immeidate will be the increment of the PC.
here we are not storing the current programme counter value, so is we have to go back to old counter, we have to add negative increment for the immediate





This repository contains examples and explanations of control flow instructions in the RISC-V assembly language.

## JAL (Jump and Link)
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/f7484341-6a57-430b-90f0-85da892163f9)

The `JAL` instruction is used for unconditional jumps to a target address by adding offset to current PC while simultaneously storing the address of the next instruction (the return address) into a specified register.

```assembly
JAL rd, offset
JAL x1, 100   // Jump to address 100 and store the return address in register x1
```

lets execute 
```
 JAL X3, -2 
```
imm: 11111111111111111110
rd:  00011
opcode: JAL opcode 1101111
```
imm[20] | imm[10:1] | imm[11] | imm[19:12] | rd | opcode
```
imm[1] = 0 
so instruction will be 
```
1_1111111110_1_11111111_00011_1101111
```
pc 7 to 9 is because of BEQ
9 to 7 because of JAL
7 will be stored in x3

![Screenshot from 2024-03-02 09-37-03](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/810d00ef-4f3b-49db-a510-a007851ed51e)

## JALR (Jump and Link Register)
The `JALR` instruction is used for jumps to a target address by adding offset to current PC specified by a register plus an immediate offset, while simultaneously storing the address of the next instruction (the return address) into a specified register.

```assembly
JALR rd, rs1, offset
JALR x31, x5, 2   // Jump to the address stored in register x5 + 2 and store the return address in register x31
imm[11:0] | rs1 | funct3 | rd | opcode
0000_0000_0010_00101_000_11111_1100111

```
pc 9 to 3
10 is stored in x31

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/927a5979-a7c5-4a7a-8c78-8c369b7496b0)



current data path
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/a14826e3-812f-464f-b0e4-02c24ddaffac)



## AUIPC (Add Upper Immediate to PC)

AUIPC is an instruction in the RISC-V instruction set architecture. It is used to add a 20-bit immediate value to the current Program Counter (PC) and store the result in a register.

### Purpose
AUIPC allows you to calculate a 32-bit absolute address by adding a signed immediate value to the PC. This is particularly useful for computing addresses relative to the current instruction.
but **it wont branch**, 

### Instruction Format
The format of the AUIPC instruction is as follows:

Where:
- `rd` is the destination register.
- `imm` is the 20-bit immediate value.

### Example
```assembly
AUIPC x2, 0x1000   // Add 0x1000 to the current PC and store the result in register x2
000000000101_00010_010111
```
JALR will use this to change the pc to ba;lue in register
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/dfc3135f-48e8-4337-9dd2-010f4f264d8f)
```
            memory[10] = 32'b0000000_00011_00001_000_00100_0010011; // ADDI
            memory[11] = 32'b0000000_00000_00001_010_00101_0010111; // AUIPC
                    //00000000000000001010_00101_0010111
            memory[12] =  32'b00000000_0010_00101_000_11111_1100111; // JALR              
            memory[23] = 32'b0000000_00011_00001_000_00100_0010011; // ADDI
```
