section .text

global new_car
new_car:
    mov rax, [rsi]
    movzx edx, word [rsi+8]
    mov cx, di
    shl rcx, 16
    or rdx, rcx
    mov ecx, 0x42C80000
    shl rcx, 32
    or rdx, rcx
    ret

global new_track
new_track:
    mov eax, edi
    mov rdx, rsi
    ret

global new_race
new_race:
    mov r8, rdi
    mov r9b, cl
    xor eax, eax
    mov ecx, 15
    rep stosq
    mov rdi, r8
    mov [rdi], rsi
    mov [rdi+8], rdx
    mov byte [rdi+16], r9b
    mov byte [rdi+116], 0
    mov rax, r8
    ret

global add_participant
add_participant:
    movzx eax, byte [rdi+116]
    cmp eax, 6
    jae .full
    mov ecx, eax
    shl rcx, 4
    mov [rdi+20+rcx], rsi
    mov [rdi+28+rcx], rdx
    inc byte [rdi+116]
    mov eax, 1
    ret
.full:
    xor eax, eax
    ret

global add_race
add_race:
    mov r8, rdi
    mov rax, [r8+2400]
    imul rax, rax, 120
    lea rdi, [r8+rax]
    lea rsi, [rsp+8]
    mov ecx, 15
    rep movsq
    inc qword [r8+2400]
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif