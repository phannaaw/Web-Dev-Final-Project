; Everything that comes after a semicolon (;) is a comment
section .text
; You should implement functions in the .text section
; A skeleton is provided for the first function
; the global directive makes a function visible to the test files
global create_item_entry
create_item_entry:
    mov [rdi], rsi
    mov [rdi + 8], rdx
    mov [rdi + 16], rcx
    mov [rdi + 24], r8
    mov [rdi + 32], r9
    mov rcx, r9
    add rdi, 40
    lea rsi, [rsp + 8]
    rep movsq
    ret
global create_monthly_list
create_monthly_list:
    push rdi
    call rsi
    pop rcx
    mov rdi, rax
    mov rsi, rax
    xor eax, eax
    rep stosb
    mov rax, rsi
    ret
global insert_found_item
insert_found_item:
    imul rsi, 120
    add rdi, rsi
    vmovdqu8 zmm0, [rdx]
    vmovdqu8 [rdi], zmm0
    vmovdqu8 zmm0, [rdx + 56]
    vmovdqu8 [rdi + 56], zmm0
    ret
global print_item
print_item:
    sub rsp, 8
    imul rdi, rdx, 120
    lea rdi, [rsi + rdi]
    lea rax, [rdi + 40]
    push rax
    push qword [rdi + 32]
    mov r9, [rdi + 24]
    mov r8, [rdi + 16]
    mov rax, rcx
    mov rcx, [rdi + 8]
    mov rsi, rdx
    mov rdx, [rdi]
    xor edi, edi
    call rax
    add rsp, 24
    ret
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
