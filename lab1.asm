%include "io64.inc"

section .data
    prompt db "Enter a string: ", 0
    result_palindrome db "The string is a palindrome", 10, 0
    result_not_palindrome db "The string is NOT a palindrome", 10, 0
    newline db 10, 0

section .bss
    input resb 256    ; Буфер для строки длиной до 255 символов (плюс нулевой байт)
    length resd 1     ; Длина строки
    is_palindrome resb 1 ; Флаг проверки палиндрома

section .text
    global main

main:
    ; Печать приглашения
    PRINT_STRING prompt

    ; Считать строку
    GET_STRING input, 256

    ; Определить длину строки
    mov ecx, input         ; Указатель на строку
    xor eax, eax           ; Счётчик длины
find_length:
    cmp byte [ecx + eax], 0 ; Проверить на конец строки (нулевой байт)
    je length_found
    inc eax
    jmp find_length
length_found:
    mov [length], eax       ; Сохранить длину строки

    ; Установить флаг палиндрома
    mov byte [is_palindrome], 1

    ; Проверка строки на палиндром
    mov ecx, 0              ; Начало строки
    mov edx, eax            ; Конец строки (длина - 1)
    dec edx                 ; Учитываем индексацию с нуля

check_palindrome:
    cmp ecx, edx            ; Если указатели встретились или пересеклись
    jge end_check

    ; Сравнение символов
    mov al, [input + ecx]   ; Символ с начала
    mov bl, [input + edx]   ; Символ с конца
    cmp al, bl
    jne not_palindrome      ; Если не совпадают, это не палиндром

    ; Перейти к следующей паре символов
    inc ecx
    dec edx
    jmp check_palindrome

not_palindrome:
    mov byte [is_palindrome], 0 ; Установить флаг "не палиндром"

end_check:
    ; Вывод результата
    PRINT_STRING input
    cmp byte [is_palindrome], 1
    je print_palindrome

    PRINT_STRING result_not_palindrome
    PRINT_STRING newline
    jmp end_program

print_palindrome:
    PRINT_STRING result_palindrome
    PRINT_STRING newline

end_program:
    ret
