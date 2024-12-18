%include "io64.inc"

section .rodata
x: dd 1.5708                ; Значение x
a: dd 1.0                  ; Коэффициент a
y: dd 1.0        ; Значение y (пример для sin(60 градусов))
epsilon: dd 0.000001       ; Погрешность

section .text
global main

main:
    ; Шаг 1: Проверяем, что a != 0
    fld dword [a]          ; st0 = a
    ftst                   ; Проверяем знак a
    fstsw ax               ; Сохраняем флаги
    sahf                   ; Загружаем флаги в регистр
    jz invalid_input       ; Если a == 0, переходим на invalid_input

    ; Шаг 2: Вычисляем x / a
    fld dword [x]          ; st0 = x
    fld dword [a]          ; st0 = a, st1 = x
    fdiv                   ; st0 = x / a

    ; Шаг 3: Вычисляем sin(x / a)
    fsin                   ; st0 = sin(x / a)

    ; Шаг 4: Сравниваем sin(x / a) с y
    fld dword [y]          ; st0 = y, st1 = sin(x / a)
    fsub                   ; st0 = y - sin(x / a)
    fabs                   ; st0 = |y - sin(x / a)|

    ; Шаг 5: Сравниваем разницу с epsilon
    fld dword [epsilon]    ; st0 = epsilon, st1 = |y - sin(x / a)|
    fcomip                 ; Сравниваем |y - sin(x / a)| и epsilon
    ja true                ; Если |разница| > epsilon, переходим на true

result:
    ; Выводим 0 (значения равны с учётом погрешности)
    PRINT_DEC 4, 0
    jmp end

true:
    ; Выводим 1 (значения не равны)
    PRINT_DEC 4, 1
    jmp end

invalid_input:
    ; Выводим сообщение об ошибке
    PRINT_STRING "Invalid input: a cannot be zero\n"
    jmp end

end:
    ; Завершение программы
    fstp st0               ; Очищаем стек
    xor rax, rax
    ret
