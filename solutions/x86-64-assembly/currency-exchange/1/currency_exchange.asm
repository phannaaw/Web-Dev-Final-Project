%include "debug.mac"

section .rodata
currency_table:
    dd 0x00504247
    dd 0x00525545
    dd 0x0059504A
    dd 0x00445541
    dd 0x004C5242
    dd 0x00594E43
    dd 0x00444143
    dd 0x00524E49

section .text

global stringify_currency
stringify_currency:
    lea rax, [rel currency_table]
    mov eax, [rax + rsi*4]
    mov [rdi], eax
    ret

global exchange_rate
exchange_rate:
    movsd xmm0, [rdx + rsi*8]
    movsd xmm1, [rdx + rdi*8]
    divsd xmm0, xmm1
    ret

global get_value_of_bills
get_value_of_bills:
    movzx rsi, si
    mov rax, rdi
    imul rax, rsi
    ret

global get_number_of_bills
get_number_of_bills:
    cvtss2sd xmm0, xmm0
    cvtsi2sd xmm1, rdi
    divsd xmm0, xmm1
    cvttsd2si eax, xmm0
    ret

global exchangeable_value
exchangeable_value:
    cvtss2sd xmm0, xmm0

    movzx eax, dil
    cvtsi2sd xmm2, eax

    mov eax, 100
    cvtsi2sd xmm3, eax
    divsd xmm2, xmm3

    mov eax, 1
    cvtsi2sd xmm3, eax
    addsd xmm2, xmm3

    mulsd xmm1, xmm2
    divsd xmm0, xmm1

    cvttsd2si rax, xmm0

    xor edx, edx
    div rsi

    imul eax, esi
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif