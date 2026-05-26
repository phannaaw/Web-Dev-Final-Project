section .text

global extract_higher_bits
global extract_lower_bits
global extract_redundant_bits
global set_message_bits
global rotate_private_key
global format_private_key
global decrypt_message

PRIVATE_KEY equ 0b1011_0011_0011_1100

extract_higher_bits:
    movzx eax, di
    shr eax, 8
    ret

extract_lower_bits:
    movzx eax, dil
    ret

extract_redundant_bits:
    movzx eax, dil
    movzx edx, di
    shr edx, 8
    and eax, edx
    ret

set_message_bits:
    movzx eax, dil
    movzx edx, di
    shr edx, 8
    or eax, edx
    ret

rotate_private_key:
    mov cx, di
    mov dx, di
    shr dx, 8
    and cx, dx
    popcnt cx, cx
    mov ax, PRIVATE_KEY
    rol ax, cl
    movzx eax, ax
    ret

format_private_key:
    call rotate_private_key
    mov dx, ax
    shr dx, 8
    movzx eax, al
    xor al, dl
    not al
    movzx eax, al
    ret

decrypt_message:
    push rbx
    push rdi
    call set_message_bits
    mov ebx, eax
    pop rdi
    call format_private_key
    shl eax, 8
    or eax, ebx
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif