%include "printf32.asm"
extern printf

section .data
M dd -20
N dd 90
msg_minus1 db '-1', 0
msg_0      db '0', 0
msg_1      db '1', 0
msg_fmt    db "%d ", 0
msg_newline db 10, 0

arr dd -30, -20, -10, 40, 50, 60, 70, 80, 90, 100
len equ 10

section .bss
in_len resd 1
res times len resd 1

section .text
global main

main:
    push ebp
    mov ebp, esp

    ; Compare arr[0] with M
    mov eax, [arr]
    cmp eax, [M]
    jl print_minus1

    cmp eax, [N]
    jg print_1

    jmp print_0

print_minus1:
    push msg_minus1
    call printf
    add esp, 4
    jmp done

print_0:
    push msg_0
    call printf
    add esp, 4
    jmp done

print_1:
    
    push msg_1
    call printf
    add esp, 4  
done:
    push msg_newline
    call printf
    add esp, 4
    mov ecx, 0
    mov edx, 0
    mov dword [in_len], 0
loop:
    cmp ecx, len
    je end_loop
    pusha
    mov eax, [arr + 4 * ecx]
    cmp eax, [M]
    jl next_elem
    cmp eax, [N]
    jg next_elem
    inc edx
    mov [res + 4 * edx], eax
    inc dword [in_len]
next_elem:
    inc ecx
    jmp loop

end_loop:
    
    mov eax, [in_len]
    push eax
    push msg_fmt
    call printf
    add esp, 8

    push msg_newline
    call printf
    add esp, 4
    mov ecx, 0
loopa:
    cmp ecx, [in_len]
    je end_loopa
    mov eax, [res + 4 * ecx + 4]
    pusha
    push eax
    push msg_fmt
    call printf
    add esp, 8
    popa
    inc ecx
    jmp loopa
end_loopa:

    push msg_newline
    call printf
    add esp, 4


    mov esp, ebp
    pop ebp
    ret
