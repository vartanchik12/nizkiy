#include <stdio.h>
#include <string.h>
#include <stdbool.h>

int main() {
    char input[256];
    int length;
    bool is_palindrome = true;

    printf("Enter a string: ");
    fgets(input, sizeof(input), stdin);

    size_t len = strlen(input);
    if (input[len - 1] == '\n') {
        input[len - 1] = '\0';
    }

    length = strlen(input);

    for (int i = 0, j = length - 1; i < j; i++, j--) {
        if (input[i] != input[j]) {
            is_palindrome = false;
            break;
        }
    }

    if (is_palindrome) {
        printf("%s\n", input);
        printf("The string is a palindrome\n");
    }
    else {
        printf("%s\n", input);
        printf("The string is NOT a palindrome\n");
    }

    return 0;
}
