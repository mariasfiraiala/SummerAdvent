section .data
    initial_text: times 1000 db 0
    format_scanf: db "%s", 0, 10
    format_printf: db "%c - %d", 10
    freq: times 173 dd 0

section .text
    global main

    extern scanf
    extern printf
    extern isalpha

main:
    enter 0, 0

    push ebx
    push edi
    push esi

    push initial_text
    push format_scanf
    call scanf
    add esp, 8

    xor ebx, ebx

get_letters:
    cmp byte [initial_text + ebx], 0 ; we stop iterating when we reach \0
    je the_word_is_over

    movzx eax, byte [initial_text + ebx] ; get every letter
    inc dword [freq + 4 * eax] ; mark the letter as used, by incrementing its numeral correspondent
    inc ebx
    jmp get_letters

the_word_is_over:

    xor ebx, ebx
    mov ebx, 65

print_letters:
    cmp ebx, 173
    je done_printing

    cmp dword [freq + 4 * ebx], 0 ; if the letter is not in the word, we won't print it
    je they_dont_matter

    push ebx
    call isalpha ; checking whether we found a letter and not a random character
    add esp, 4

    cmp eax, 0
    je they_dont_matter

    push dword [freq + 4 * ebx]
    push ebx
    push format_printf
    call printf
    add esp, 12

they_dont_matter:
    inc ebx
    jmp print_letters

done_printing:

    xor eax, eax

    pop esi
    pop edi
    pop ebx

    leave
    ret