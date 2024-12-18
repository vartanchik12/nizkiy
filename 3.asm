%include "io64.inc"

section .bss
    x: resd 1
section .rodata
    a: dd 3.0
    section .rodata
    ;2^ctg(x) = a
    ;x = arctg(log2(a))
    ;Полиз a log2 arctg
    
section .text
global main

main:
mov rbp, rsp;
xor rbx, rbx

FLD1
FLD dword[a] ;ST0 = x

FYl2x
FLD1
FXCH
FPATAN

FSTP dword[x]

ret