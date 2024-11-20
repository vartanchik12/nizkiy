%include "io64.inc"

section .data
    prompt db "Enter a string: ", 0
    result_palindrome db "The string is a palindrome", 10, 0
    result_not_palindrome db "The string is NOT a palindrome", 10, 0
    newline db 10, 0

section .bss
    input resb 256    
    length resd 1     
    is_palindrome resb 1 

section .text
    global main

main:
    PRINT_STRING prompt

    GET_STRING input, 256

    mov ecx, input         
    xor eax, eax           
find_length:
    cmp byte [ecx + eax], 0 
    je length_found
    inc eax
    jmp find_length
length_found:
    mov [length], eax       

    mov byte [is_palindrome], 1

    mov ecx, 0              
    mov edx, eax            
    dec edx                 

check_palindrome:
    cmp ecx, edx            
    jge end_check
 
    mov al, [input + ecx]   
    mov bl, [input + edx]   
    cmp al, bl
    jne not_palindrome      

    inc ecx
    dec edx
    jmp check_palindrome

not_palindrome:
    mov byte [is_palindrome], 0 

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
