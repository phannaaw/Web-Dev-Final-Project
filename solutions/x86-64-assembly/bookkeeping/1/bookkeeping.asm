section .bss
remembered_transaction resq 1

section .text

global remember_transaction
remember_transaction:
    mov [rel remembered_transaction], rdi
    ret

global apply_remembered
apply_remembered:
    jmp qword [rel remembered_transaction]

global register_transaction
register_transaction:
    mov [rdi + rsi*8], rdx
    ret

global select_transaction
select_transaction:
    mov rax, [rdi + rsi*8]
    mov rdi, rdx
    jmp rax

global process_statement
process_statement:
    push rbx
    push r12
    push r13

    mov r12, rsi
    mov r13, rdx
    mov rax, rdi
    xor ebx, ebx

.loop_statement:
    cmp rbx, r13
    jge .done_statement

    mov r10, [r12 + rbx*8]
    mov rdi, rax
    call r10

    inc rbx
    jmp .loop_statement

.done_statement:
    pop r13
    pop r12
    pop rbx
    ret

global process_with_guard
process_with_guard:
    push r10
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
    sub rsp, 16

    mov r12, rdi
    mov r13, rsi
    mov r14, rdx
    mov r15, rcx
    xor ebx, ebx
    xor ebp, ebp

.loop_guard:
    cmp rbx, r14
    jge .done_guard

    mov rax, [r13 + rbx*8]
    mov rdi, r12
    call rax

    mov [rsp], rax
    mov rdi, rax
    call r15

    test rax, rax
    jz .skip_guard

    mov r12, [rsp]
    inc ebp

.skip_guard:
    inc rbx
    jmp .loop_guard

.done_guard:
    mov rax, r12
    mov rdx, rbp

    add rsp, 16
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
    pop r10
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif