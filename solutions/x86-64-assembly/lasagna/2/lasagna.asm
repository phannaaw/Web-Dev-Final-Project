section .text

global expected_minutes_in_oven
expected_minutes_in_oven:

    mov rax, 40;
    ret

global remaining_minutes_in_oven
remaining_minutes_in_oven:

    mov rax, 40;
    sub rax, rdi;
    ret

global preparation_time_in_minutes
preparation_time_in_minutes:

    imul rax, rdi, 2;
    ret

global elapsed_time_in_minutes
elapsed_time_in_minutes:

    mov rax, rdi;
    add rax, rdi;
    add rax, rsi;

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
