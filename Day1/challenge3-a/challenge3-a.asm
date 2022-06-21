section .data
    initial_string: times 1000 db 0
    transformed_string: times 1000 db 0
    format_strtok: db " ", 0, 10
    format_printf: db "%s"
    format_strcat: db " "

section .text
    global main

    extern stdin
    extern fgets
    extern strtok
    extern printf
    extern strcat

main:
    enter 0, 0

    push ebx
    push edi
    push esi

    push dword [stdin]
    push 1000
    push initial_string ; read the initial string
    call fgets
    add esp, 12

    push format_strtok
    push initial_string
    call strtok ; strtok's first call
    add esp, 8

parse_words_with_strtok:
    cmp eax, 0 ;  eax = the pointer returned by strtok
    je stop_parsing

    cmp byte [eax], 90
    jle is_upper
    sub byte [eax], 32 ; lower letters come after capital letters in ASCII

is_upper:
    push eax
    push transformed_string ; paste the transformed word into the result string
    call strcat
    add esp, 8

    push format_strcat
    push transformed_string
    call strcat ; add a space between words
    add esp, 8

    push format_strtok
    push 0
    call strtok ; calling strtok in a loop
    add esp, 8
    jmp parse_words_with_strtok

stop_parsing:

    push transformed_string
    push format_printf
    call printf
    add esp, 8

    xor eax, eax

    pop esi
    pop edi
    pop ebx

    leave
    ret