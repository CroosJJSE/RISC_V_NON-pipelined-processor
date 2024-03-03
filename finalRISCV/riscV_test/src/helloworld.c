#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"

int main()
{
    init_platform();
    XGpio ALU, PC, INST;
    int ALU_VAL, PC_val, INST_VAL;
    int prev_PC_val = -1; // Initialize with a value that won't be in the actual range

    // Initialize
    XGpio_Initialize(&ALU, XPAR_AXI_GPIO_ALU_DEVICE_ID);
    XGpio_Initialize(&INST, XPAR_AXI_GPIO_INST_DEVICE_ID);
    XGpio_Initialize(&PC, XPAR_AXI_GPIO_PC_DEVICE_ID);

    // Set direction
    XGpio_SetDataDirection(&ALU, 1, 1);
    XGpio_SetDataDirection(&INST, 1, 1);
    XGpio_SetDataDirection(&PC, 1, 1);

    while (1) {
        // Read values
        ALU_VAL = XGpio_DiscreteRead(&ALU, 1);
        PC_val = XGpio_DiscreteRead(&PC, 1);
        INST_VAL = XGpio_DiscreteRead(&INST, 1);

        // Check if PC_val has changed
        if (PC_val != prev_PC_val) {
            // Print the PC value with a new line
            xil_printf("PC value changed: %d ", PC_val);
            prev_PC_val = PC_val; // Update previous value

            // Print the ALU value


            // Convert INST value to 32-bit binary number with underscores
            xil_printf("INST ");
            for (int i = 31; i >= 0; i--) {
                int bit = (INST_VAL >> i) & 1;
                xil_printf("%d", bit);
                // Add underscores at specific bit positions
                if (i == 24 || i == 19 || i == 14 || i == 11 || i == 6) {
                    xil_printf("_");
                }
            }
            xil_printf(" ALU value: %d ", ALU_VAL);
            xil_printf("\n\r");
        }
    }

    cleanup_platform();
    return 0;
}
