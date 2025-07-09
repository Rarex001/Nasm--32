%include "printf32.asm"
extern printf

section .data

    limit dd  120
    len equ   10
    fmt_int: db "%d ", 0
    fmt_intb: db "TOD0 b result is %d ", 0
    fmt_intc: db "TOD0 c result is %d ", 0
    newline: db 10, 0

section .bss
    ; TODO a: Reserve space for an array of `len` integers. The array name is `int_arr`
    arr resd len

section .text
global main

main:
    push ebp
    mov ebp, esp

    mov ecx, 0
    mov edx, 3
    mov ebx, 0

loop:
    cmp ecx, len
    je end_loop
    mov [arr + 4 * ecx], edx
    inc ecx
    add edx, 17
    jmp loop
end_loop:
    mov ecx, 0
loop2:
    cmp ecx, len
    je end_loop2
    mov eax, [arr + 4 * ecx]
    inc ecx
    pusha
    push eax
    push fmt_int
    call printf
    add esp, 8
    popa
    cmp eax, [limit]
    jge loop2
    inc ebx
    jmp loop2
end_loop2:

    push newline
    call printf
    add esp, 4

    push ebx
    push fmt_intb
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4

    mov ecx, 0

loop3:
    cmp ecx, len
    je end_loop3
    mov eax, [arr + 4 * ecx]
    cmp eax, [limit]
    jg end_loop3
    inc ecx
    jmp loop3
end_loop3:

    push eax
    push fmt_intc
    call printf
    add esp, 8

    push newline
    call printf
    add esp, 4
    leave
    ret

