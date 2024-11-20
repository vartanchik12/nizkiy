#include <stdio.h>

int main() {
    char input[256];       // Буфер для строки
    int length = 0;        // Длина строки
    int is_palindrome = 1; // Флаг палиндрома
    int start = 0, end;    // Индексы для проверки

    // Ввод строки
    printf("Enter a string: ");
    fgets(input, 256, stdin);

    // Определение длины строки
find_length:
    if (input[length] != '\0' && input[length] != '\n') {
        length++;
        goto find_length;
    }

    // Установка индекса конца строки
    end = length - 1;

check_palindrome:
    if (start >= end) goto result; // Условие завершения проверки

    if (input[start] != input[end]) {
        is_palindrome = 0;
        goto result;
    }

    start++;
    end--;
    goto check_palindrome;

result:
    // Вывод результата
    if (is_palindrome) {
        printf("The string is a palindrome\n");
        goto end_program;
    }

    printf("The string is NOT a palindrome\n");

end_program:
    return 0;
}
