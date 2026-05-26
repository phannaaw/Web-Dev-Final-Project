section .text

global daily_rate
global apply_discount
global monthly_rate
global days_in_budget

daily_rate:
    mov rax, 8
    cvtsi2sd xmm1, rax
    mulsd xmm0, xmm1
    ret

apply_discount:
    mov rax, 100
    cvtsi2sd xmm2, rax
    divsd xmm1, xmm2

    mov rax, 1
    cvtsi2sd xmm2, rax
    subsd xmm2, xmm1

    mulsd xmm0, xmm2
    ret

monthly_rate:
    mov rax, 8
    cvtsi2sd xmm2, rax
    mulsd xmm0, xmm2

    mov rax, 100
    cvtsi2sd xmm3, rax
    divsd xmm1, xmm3

    mov rax, 1
    cvtsi2sd xmm3, rax
    subsd xmm3, xmm1
    mulsd xmm0, xmm3

    mov rax, 22
    cvtsi2sd xmm2, rax
    mulsd xmm0, xmm2

    roundsd xmm0, xmm0, 2
    cvtsd2si rax, xmm0
    ret

days_in_budget:
    cvtsi2sd xmm2, rdi

    mov rax, 8
    cvtsi2sd xmm3, rax
    mulsd xmm0, xmm3

    mov rax, 100
    cvtsi2sd xmm4, rax
    divsd xmm1, xmm4

    mov rax, 1
    cvtsi2sd xmm4, rax
    subsd xmm4, xmm1

    mulsd xmm0, xmm4

    divsd xmm2, xmm0

    roundsd xmm2, xmm2, 1
    cvtsd2si eax, xmm2
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif