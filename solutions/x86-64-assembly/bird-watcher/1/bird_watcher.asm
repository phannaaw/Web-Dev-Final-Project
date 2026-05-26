section .data
    last_week dq 0x0004080703050200

section .bss
    current_week  resq 1
    current_count resb 1

section .text

global last_week_counts
global current_week_counts
global save_count
global today_count
global update_today_count
global update_week_counts

last_week_counts:
    mov rax, [rel last_week]
    ret

current_week_counts:
    mov rax, [rel current_week]
    movzx rdx, byte [rel current_count]
    ret

save_count:
    movzx ecx, byte [rel current_count]
    cmp ecx, 7
    jne .append

    mov rax, [rel current_week]
    mov [rel last_week], rax

    xor eax, eax
    mov [rel current_week], rax
    mov byte [rel current_count], 0
    xor ecx, ecx

.append:
    mov al, dil

    lea rdx, [rel current_week]
    mov [rdx + rcx], al

    inc byte [rel current_count]
    ret

today_count:
    movzx ecx, byte [rel current_count]
    dec ecx

    lea rdx, [rel current_week]
    mov al, [rdx + rcx]
    ret

update_today_count:
    movzx ecx, byte [rel current_count]
    dec ecx

    lea rdx, [rel current_week]
    add byte [rdx + rcx], dil
    ret

update_week_counts:
    mov rax, [rel current_week]
    mov [rel last_week], rax

    mov rax, rdi
    shl rax, 8
    shr rax, 8
    mov [rel current_week], rax

    mov byte [rel current_count], 7
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif