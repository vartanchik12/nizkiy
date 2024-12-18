%include "io64.inc"

section .rodata
a: dd 2.0                 ; Коэффициент a
x: dd 0.0                 ; Коэффициент x
y: dd 0.5                 ; Коэффициент y

section .text
global main

main:
    ; Шаг 1: Вычисляем ax
    fld dword [a]          ; st0 = a
    fld dword [x]          ; st0 = x, st1 = a
    fmul                   ; st0 = ax

    ; Шаг 2: Вычисляем cos(ax)
    fcos                   ; st0 = cos(ax)

    ; Шаг 3: Сравниваем y с cos(ax)
    fld dword [y]          ; st0 = y, st1 = cos(ax)
    fcomip                 ; Сравниваем y и cos(ax)
    ja false               ; Если y > cos(ax), переходим на false

    ; Условие выполнено: выводим 1
    PRINT_DEC 4, 1
    jmp end

false:
    ; Условие не выполнено: выводим 0
    PRINT_DEC 4, 0

end:
    ; Завершение программы
    fstp st0               ; Очищаем стек
    xor rax, rax
    ret
