%include "io64.inc"

section .rodata
x: dd 2.718281828        ; Значение x (например, e, чтобы проверить ln(e) = 1)
y: dd 1.5                ; Значение y

section .text
global main

main:
    ; Шаг 1: Проверяем, что x > 0
    fld dword [x]        ; st0 = x
    ftst                 ; Проверяем знак x
    fstsw ax             ; Сохраняем флаги
    sahf                 ; Загружаем флаги в регистр
    jbe false            ; Если x <= 0, переходим на false

    ; Шаг 2: Вычисляем ln(x)
    fldln2               ; st0 = ln(2)
    fxch                 ; Меняем местами st0 и x
    fyl2x                ; st0 = ln(x)

    ; Шаг 3: Сравниваем y с ln(x)
    fld dword [y]        ; st0 = y, st1 = ln(x)
    fcomip               ; Сравниваем y с ln(x)
    jna false            ; Если y <= ln(x), переходим на false

    ; Условие выполнено: выводим 1
    PRINT_DEC 4, 1
    jmp end

false:
    ; Условие не выполнено: выводим 0
    PRINT_DEC 4, 0

end:
    ; Завершение программы
    fstp st0             ; Очищаем стек
    xor rax, rax
    ret
