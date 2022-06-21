section .data
    format_scanf db "%d", 0, 10
    format_printf db "%d", 10

section .text
    global alloc_array
    global read_array
    global sum_array
    global main

    extern malloc
    extern scanf
    extern printf
    extern free

alloc_array:
    enter 0, 0
    
    push ebx
    push edi
    push esi

    mov eax, 4
    mul dword [ebp + 8]

    push eax
    call malloc
    add esp, 4

    pop esi
    pop edi
    pop ebx

    leave
    ret

read_array:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 12]
    xor esi, esi

read_step_by_step:
    cmp esi, [ebp + 8]
    je done_reading

    lea edi, [ebx + 4 * esi]
    push edi
    push format_scanf
    call scanf
    add esp, 8

    inc esi
    jmp read_step_by_step


done_reading:

    pop esi
    pop edi
    pop ebx

    leave
    ret

sum_array:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ebx, [ebp + 12]
    mov ecx, [ebp + 8]
    xor eax, eax

construct_sum:
    add eax, dword [ebx + 4 * ecx - 4]
    loop construct_sum

    pop esi
    pop edi
    pop ebx

    leave
    ret

main:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ebx, 5

    push ebx
    call alloc_array
    add esp, 4

    mov edi, eax ; edi = v after allocating it

    push edi
    push ebx
    call read_array
    add esp, 8

    push edi
    push ebx
    call sum_array
    add esp, 8

    mov esi, eax ; esi = sum

    push esi
    push format_printf
    call printf
    add esp, 8

    push edi
    call free
    add esp, 4

    xor eax, eax

    pop esi
    pop edi
    pop ebx

    leave
    ret