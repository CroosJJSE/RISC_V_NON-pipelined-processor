# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/subi/codes/vscode/vivado/finalRISCV/risc/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/subi/codes/vscode/vivado/finalRISCV/risc/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {risc}\
-hw {/home/subi/codes/vscode/vivado/finalRISCV/design_1_wrapper.xsa}\
-proc {ps7_cortexa9_0} -os {standalone} -out {/home/subi/codes/vscode/vivado/finalRISCV}

platform write
platform generate -domains 
platform active {risc}
platform write
