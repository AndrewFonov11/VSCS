; Very Small Control System - VSCS
; Build
; Released into the public domain under CC0

format binary as 'img'
macro align value { db value-1 - ($ + value-1) mod (value) dup 0 }
HEADS = 1
SPT = 2
Begin:
        file "vscs_boot.bin",512
        file "vscs_kernel.bin"
        align 512