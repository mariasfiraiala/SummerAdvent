section .text
    global power

power:
    enter 0, 0

    push ebx
    push edi
    push esi

    cmp word [ebp + 12], 0
    jne recursion
    mov eax, 1
    jmp stop_recursion

recursion:
    test dword [ebp + 12], 1
    jz is_even

    mov ebx, [ebp + 12]
    dec ebx
    push ebx
    push dword [ebp + 8]
    call power ; call a * f (a, b - 1), when b is odd
    add esp, 8

    mul dword [ebp + 8]
    jmp stop_recursion

is_even:
    mov ebx, [ebp + 12]
    shr ebx, 1
    push ebx
    push dword [ebp + 8]
    call power
    add esp, 8

    mov ebx, eax ; return f(a, b / 2) * f(a, b / 2), when b is even
    mul ebx

stop_recursion:

    pop esi
    pop edi
    pop ebx

    leave
    ret