section .data
    format_printf1 db "%d ", 0
    format_printf2 db 10, 0

section .text
    global inc2
    global is_odd
    global map
    global filter
    global print_array
    global main

    extern malloc
    extern realloc
    extern printf
    extern free

;;;;;;;;;;;;;;;;;;;;;;;;;;;    FIRST FUNCTION      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;        INC2            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

inc2:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ecx, [ebp + 8]
    mov eax, 3
    mul ecx
    
    add eax, 10

    pop esi
    pop edi
    pop ebx

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;    SECOND FUNCTION      ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;        IS_ODD           ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

is_odd:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ecx, [ebp + 8]

    test ecx, 1
    jz even
    mov eax, 1
    jmp both

even:
    xor eax, eax

both:

    pop esi
    pop edi
    pop ebx

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;    THIRD FUNCTION      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;          MAP           ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

map:
    enter 0, 0
    
    push ebx
    push edi
    push esi

    mov eax, 4
    mul dword [ebp + 8]

    push eax
    call malloc
    add esp, 4

    mov edi, eax ; edi = res

    mov ecx, [ebp + 8] ; ecx = n
    mov ebx, [ebp + 12] ; ebx = v
    mov edx, [ebp + 16] ; edx = f

construct_res:

    push edx
    push ecx ; calling convention

    push dword [ebx + 4 * ecx - 4]
    call edx
    add esp, 4

    pop ecx
    pop edx ; calling convention

    mov [edi + 4 * ecx - 4], eax
    loop construct_res

    mov eax, edi

    pop esi
    pop edi
    pop ebx

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;    FOURTH FUNCTION     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;        FILTER          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

filter:
    enter 0, 0
    
    push ebx
    push edi
    push esi

    mov eax, 4
    mul dword [ebp + 12]

    push eax
    call malloc
    add esp, 4

    mov edi, eax ; edi = res

    mov ecx, [ebp + 12] ; ecx = n
    mov ebx, [ebp + 16] ; ebx = v
    mov edx, [ebp + 20] ; edx = f
    xor esi, esi ; esi = count

construct_res_filter:

    push edx
    push ecx ; calling convention

    push dword [ebx + 4 * ecx - 4]
    call edx
    add esp, 4

    pop ecx
    pop edx ; calling convention

    cmp eax, 0
    je wait_and_jump

    mov eax, [ebx + 4 * ecx - 4]
    mov [edi + 4 * esi], eax
    inc esi

wait_and_jump:
    loop construct_res_filter

    mov ecx, esi; ecx = count

reverse_res:
    mov eax, esi
    shr eax, 1
    
    cmp eax, ecx
    je stop_reversing_res

    mov eax, esi
    sub eax, ecx

    push dword [edi + 4 * ecx - 4]
    push dword [edi + 4 * eax]

    pop dword [edi + 4 * ecx - 4]
    pop dword [edi + 4 * eax]

    loop reverse_res

stop_reversing_res:
    mov eax, 4
    mul esi

    push eax
    push edi
    call realloc ; eax will get res
    add esp, 8

    mov ecx, [ebp + 8]
    mov [ecx], esi

    pop esi
    pop edi
    pop ebx

    leave
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;     FIFTH FUNCTION     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;       PRINT_ARRAY      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_array:
    enter 0, 0
    
    push ebx
    push edi
    push esi

    mov eax, [ebp + 12]

    xor ebx, ebx

print_step_by_step: 
    cmp ebx, [ebp + 8]
    je done_printing

    push eax ; calling convention

    push dword [eax + 4 * ebx]
    push format_printf1
    call printf
    add esp, 8
    
    pop eax ; calling convention

    inc ebx
    jmp print_step_by_step

done_printing:

    push format_printf2
    call printf
    add esp, 4

    xor eax, eax

    pop esi
    pop edi
    pop ebx

    leave
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;           MAIN           ;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

main:
    enter 0, 0

    push ebx
    push edi
    push esi

    mov ecx, 5

initialize_array:
    push ecx
    loop initialize_array

    mov ebx, esp ; ebx = v

    push inc2
    push ebx
    push 5
    call map
    add esp, 12

    mov edi, eax ; edi = map_v

    sub esp, 4
    mov esi, esp ; esi = filter_count

    push is_odd
    push ebx
    push 5
    push esi
    call filter ; eax will get filter_v
    add esp, 16

    push eax ; calling convention

    push edi
    push 5
    call print_array
    add esp, 8

    pop ebx ; calling convention

    push ebx
    push dword [esi]
    call print_array
    add esp, 8

    push edi
    call free
    add esp, 4

    push ebx
    call free
    add esp, 4

    xor eax, eax

    pop esi
    pop edi
    pop ebx

    leave
    ret