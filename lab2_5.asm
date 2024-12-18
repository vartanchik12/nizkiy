%include "io64.inc"

section .rodata
x: dd 100.0                ; Коэффициент x
y: dd 2.0                  ; Коэффициент y
epsilon: dd 0.000001       ; Погрешность для сравнения

section .text
global main

main:
    ; Шаг 1: Проверяем, что x > 0
    fld dword [x]          ; st0 = x
    ftst                   ; Проверяем знак x
    fstsw ax               ; Сохраняем флаги
    sahf                   ; Загружаем флаги в регистр
    jbe result      ; Если x <= 0, переходим на invalid_input

    ; Шаг 2: Вычисляем log10(x)
    fldlg2                 ; st0 = log10(2)
    fld dword [x]          ; st0 = x, st1 = log10(2)
    fyl2x                  ; st0 = log10(x)

    ; Шаг 3: Сравниваем y с log10(x) с учётом погрешности
    fld dword [y]          ; st0 = y, st1 = log10(x)
    fsub                   ; st0 = y - log10(x)
    fabs                   ; st0 = |y - log10(x)|
    fld dword [epsilon]    ; st0 = epsilon, st1 = |y - log10(x)|
    fcomip                 ; Сравниваем |y - log10(x)| и epsilon
    ja true               ; Если |y - log10(x)| > epsilon, переходим на false

result:
    ; Выводим 1 (условие выполнено)
    PRINT_DEC 4, 0
    jmp end

true:
    ; Выводим 0 (условие не выполнено)
    PRINT_DEC 4, 1
    

end:
    ; Завершение программы
    fstp st0               ; Очищаем стек
    xor rax, rax
    ret