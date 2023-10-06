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

 ## Arithmetic I-Type
We need an additional module (imm.gen) to extract the immediate value from the instruction,
we have to extend the values accordoing to the RISC V 


![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/fdb50e10-cba8-4417-9bf3-363411760543)



and we need a mux to connect the imm.gen and Data B(from reg.file) to the ALU. so the updated schematic will be

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/f3254222-c1e3-40a0-b955-60f083846de9)


## Load I type


![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/825cbca8-75f2-498d-b826-e6932ad29d06)
here we will have base address in rs1 and increment will be in immediate and we have to store the value from memory to rd register.
here we are implementing another module "data memeory".

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/201d522f-2331-4fd5-b5f5-3190e103b90b)



this is the schematic after the load instruction
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/2afb7640-4ea1-4754-8016-8cada2cac9f1)



##  S-Type store value in data memory
we are moving the data from the regfile to data memory.
we connect the B reg to data input directly.

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/2e82a9d0-ff05-4455-aaf4-f24040d397bc)


## SB type 
this is conditional branching

![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/d1bc68fa-b54f-448c-bc7c-bbfd9fde3154)

the values in rs1 and rs2 will be compared according to fun3 and if the condition is satisfied it will increase pc by immediate
but here generating immediate is diffent than r type.
so we increase the imm.gen control signal width.


current data path
![image](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/ac0284db-6dc5-4e59-ac87-aa98f9f62fa7)

Next clock will be increased using **PCSel** and **ASel**
but it is pretty complex, because added another adder seperately to PC to reduce hardware complex, make faster (reducing combinational delay)

**updated one**

![IMG_8075](https://github.com/CroosJJSE/RISC_V_single_clock_Micro_programmed_processor/assets/141708783/122f624d-efd9-4b69-aa34-a2c1b72959da)
