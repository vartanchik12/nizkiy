#include <stdio.h>

int main() {
    char input[256]; 
    int length = 0;
    int is_palindrome = 1;
    int start = 0, end;

    printf("Enter a string: ");
    fgets(input, 256, stdin);

find_length:
    if (input[length] != '\0' && input[length] != '\n') {
        length++;
        goto find_length;
    }

    end = length - 1;

check_palindrome:
    if (start >= end) goto result; 

    if (input[start] != input[end]) {
        is_palindrome = 0;
        goto result;
    }

    start++;
    end--;
    goto check_palindrome;

result:
    if (is_palindrome) {
        printf("The string is a palindrome\n");
        goto end_program;
    }

    printf("The string is NOT a palindrome\n");

end_program:
    return 0;
}
