section .text
    global recursive

recursive:
    enter 0, 0

    push ebx
    push edi
    push esi

    cmp dword [ebp + 8], 0
    jne second_if
    xor eax, eax
    jmp stop_recursion

second_if:
    cmp dword [ebp + 8], 1
    jne third_if
    mov eax, 1
    jmp stop_recursion

third_if:
    cmp dword [ebp + 8], 2
    jne fourth_if
    mov eax, 2
    jmp stop_recursion

fourth_if:
    cmp dword [ebp + 8], 3
    jne start_recursion
    mov eax, 3
    jmp stop_recursion

start_recursion:

    mov ebx, [ebp + 8]

    dec ebx ; n - 1
    push ebx
    call recursive ; f(n - 1)
    add esp, 4

    mov esi, eax

    dec ebx ; n - 2
    push ebx
    call recursive ; f(n - 2)
    add esp, 4

    add esi, eax

    dec ebx ; n - 3
    push ebx
    call recursive ; f(n - 3)
    add esp, 4

    add esi, eax

    dec ebx ; n - 4
    push ebx
    call recursive ; f(n - 4)
    add esp, 4

    add eax, esi

stop_recursion:

    pop esi
    pop edi
    pop ebx

    leave
    ret