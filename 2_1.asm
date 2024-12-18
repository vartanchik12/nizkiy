%include "io64.inc"

section .rodata
    x: dd 3.0
    y: dd 6.0
    a: dd 9.0
    ;y<ln3(sin(x)+a)
    ;ПОЛИЗ x sin a + ln ^3
    ;4,5<3,12
    
section .text
global main

main:
mov rbp, rsp;

FLD dword[x] ;ST0 = x
FSIN  ; ST0 = sin(x)
FLD dword[a] ; ST0 = a, ST1 = sin(x)
FADDP ; ST1+=ST0 и ST0 выталкивается
FLDLN2 ; ST0 = ln(2)
FXCH ST1 ; swap(ST0,ST1)
FYL2X ; Вычисляю логарифм

FLD1
FLD1
FLD1
FADD
FADD ;ST0 = 3


FXCH ST1; swap(ST0,ST1)
FYL2X
FLD1
FLD ST1
FPREM
F2XM1
FADD
FSCALE
FSTP ST1 ;pow(st0,st1)

FLD dword[y]
FCOMIP ST1
jae false
PRINT_DEC 4,1
jmp end
false:
PRINT_DEC 4,0
end:
FSTP ST0
xor rax,rax
ret

