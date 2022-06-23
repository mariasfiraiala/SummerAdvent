section .data
    format_scanf db "%d", 0, 10

section .text
    global partition
    global alloc_array
    global read_array

    extern malloc
    extern scanf
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

partition:
    enter 0, 0

    push ebx
    push edi
    push esi

    push dword [ebp + 8]
    call alloc_array ; allocate v
    add esp, 4

    mov ebx, eax ; ebx = v

    push ebx
    push dword [ebp + 8]
    call read_array ; read v
    add esp, 8

    push dword [ebp + 8]
    call alloc_array ; allocate tmp
    add esp, 4

    mov edi, eax ; edi = tmp
    xor ecx, ecx ; index for v
    xor edx, edx ; index for tmp
    mov esi, [ebp + 12]

find_lower_values:
    cmp ecx, [ebp + 8]
    je stop_finding_lower_values

    cmp dword [ebx + 4 * ecx], esi
    jge ignore
    mov eax, dword [ebx + 4 * ecx]
    mov dword [edi + 4 * edx], eax
    inc edx

ignore:
    inc ecx
    jmp find_lower_values

stop_finding_lower_values:

    xor ecx, ecx

find_greater_values:
    cmp ecx, [ebp + 8]
    je stop_finding_greater_values

    cmp dword [ebx + 4 * ecx], esi
    jl ignore_this
    mov eax, dword [ebx + 4 * ecx]
    mov dword [edi + 4 * edx], eax
    inc edx

ignore_this:
    inc ecx
    jmp find_greater_values

stop_finding_greater_values:

    push ebx
    call free
    add esp, 4

    mov eax, edi

    pop esi
    pop edi
    pop ebx

    leave
    ret