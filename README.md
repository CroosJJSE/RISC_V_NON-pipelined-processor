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
