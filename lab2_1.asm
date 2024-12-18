%include "io64.inc"

section .rodata
a: dd 2.0                  ; Коэффициент a
x: dd 1.5                  ; Коэффициент x
y: dd 0.5                  ; Коэффициент y

section .text
global main

main:
    ; Шаг 1: Вычисляем x + a
    fld dword [x]          ; st0 = x
    fld dword [a]          ; st0 = a, st1 = x
    fadd                   ; st0 = x + a

    ; Шаг 2: Проверяем, что x + a > 0
    ftst                   ; Проверяем знак (x + a)
    fstsw ax               ; Сохраняем статусные флаги
    sahf                   ; Загружаем их в регистр флагов
    jbe false              ; Если x + a <= 0, переходим на false

    ; Шаг 3: Вычисляем ln(x + a)
    fldln2                 ; st0 = ln(2), st1 = x + a
    fxch                   ; st0 = x + a, st1 = ln(2)
    fyl2x                  ; st0 = log2(x + a)

    ; Шаг 4: Сравниваем y с log2(x + a)
    fld dword [y]          ; st0 = y, st1 = log2(x + a)
    fcomip                 ; Сравниваем y и log2(x + a)
    jnb false              ; Если y >= log2(x + a), переходим на false

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
