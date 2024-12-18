%include "io64.inc"

section .rodata
a: dd 2.0                  ; Коэффициент a
x: dd 1.0                  ; Коэффициент x
y: dd 0.5                  ; Коэффициент y

section .text
global main

main:
    ; Шаг 1: Вычисляем x / a
    fld dword [x]          ; st0 = x
    fld dword [a]          ; st0 = a, st1 = x
    fdiv                   ; st0 = x / a

    ; Шаг 2: Вычисляем sin(x / a)
    fsin                   ; st0 = sin(x / a)

    ; Шаг 3: Сравниваем y с sin(x / a)
    fld dword [y]          ; st0 = y, st1 = sin(x / a)
    fcomip                 ; Сравниваем y и sin(x / a)
    jb false               ; Если y < sin(x / a), переходим на false

    ; Выводим 1 (условие выполнено)
    PRINT_DEC 4, 1
    jmp end

false:
    ; Выводим 0 (условие не выполнено)
    PRINT_DEC 4, 0

end:
    ; Завершение программы
    fstp st0               ; Очищаем стек
    xor rax, rax
    ret
