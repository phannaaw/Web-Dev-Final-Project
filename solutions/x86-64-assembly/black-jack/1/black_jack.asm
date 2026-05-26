C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1
FALSE equ 0

section .text

global value_of_card
value_of_card:
    cmp rdi, 11
    jl .numeric
    cmp rdi, 13
    jle .face
    mov rax, 1
    ret
.numeric:
    mov rax, rdi
    ret
.face:
    mov rax, 10
    ret

global higher_card
higher_card:
    mov r8, rdi
    mov r9, rsi

    cmp r8, 11
    jl .val1_num
    cmp r8, 13
    jle .val1_face
    mov r11, 1
    jmp .val1_done
.val1_num:
    mov r11, r8
    jmp .val1_done
.val1_face:
    mov r11, 10
.val1_done:

    cmp r9, 11
    jl .val2_num
    cmp r9, 13
    jle .val2_face
    mov r10, 1
    jmp .val2_done
.val2_num:
    mov r10, r9
    jmp .val2_done
.val2_face:
    mov r10, 10
.val2_done:

    cmp r11, r10
    jg .first_higher
    jl .second_higher

    mov rax, r8
    mov rdx, r9
    ret

.first_higher:
    mov rax, r8
    xor rdx, rdx
    ret

.second_higher:
    mov rax, r9
    xor rdx, rdx
    ret

global value_of_ace
value_of_ace:
    cmp rdi, CA
    je .ace_is_one
    cmp rsi, CA
    je .ace_is_one

    mov r8, rdi
    cmp r8, 11
    jl .sum1_num
    cmp r8, 13
    jle .sum1_face
.sum1_num:
    jmp .sum2
.sum1_face:
    mov r8, 10
.sum2:
    mov r9, rsi
    cmp r9, 11
    jl .sum2_num
    cmp r9, 13
    jle .sum2_face
.sum2_num:
    jmp .add
.sum2_face:
    mov r9, 10
.add:
    add r8, r9

    cmp r8, 10
    jle .ace_is_eleven
.ace_is_one:
    mov rax, 1
    ret
.ace_is_eleven:
    mov rax, 11
    ret

global is_blackjack
is_blackjack:
    cmp rdi, CA
    jne .check_second
    cmp rsi, C10
    je .true
    cmp rsi, CJ
    je .true
    cmp rsi, CQ
    je .true
    cmp rsi, CK
    je .true
.check_second:
    cmp rsi, CA
    jne .false
    cmp rdi, C10
    je .true
    cmp rdi, CJ
    je .true
    cmp rdi, CQ
    je .true
    cmp rdi, CK
    je .true
.false:
    mov rax, FALSE
    ret
.true:
    mov rax, TRUE
    ret

global can_split_pairs
can_split_pairs:
    mov r8, rdi
    cmp r8, 11
    jl .sp1_num
    cmp r8, 13
    jle .sp1_face
    mov r8, 1
    jmp .sp2
.sp1_num:
    jmp .sp2
.sp1_face:
    mov r8, 10
.sp2:
    mov r9, rsi
    cmp r9, 11
    jl .sp2_num
    cmp r9, 13
    jle .sp2_face
    mov r9, 1
    jmp .compare
.sp2_num:
    jmp .compare
.sp2_face:
    mov r9, 10
.compare:
    cmp r8, r9
    jne .false
    mov rax, TRUE
    ret
.false:
    mov rax, FALSE
    ret

global can_double_down
can_double_down:
    mov r8, rdi
    cmp r8, 11
    jl .dd1_num
    cmp r8, 13
    jle .dd1_face
    mov r8, 1
    jmp .dd2
.dd1_num:
    jmp .dd2
.dd1_face:
    mov r8, 10
.dd2:
    mov r9, rsi
    cmp r9, 11
    jl .dd2_num
    cmp r9, 13
    jle .dd2_face
    mov r9, 1
    jmp .sum
.dd2_num:
    jmp .sum
.dd2_face:
    mov r9, 10
.sum:
    add r8, r9

    cmp r8, 9
    je .true
    cmp r8, 10
    je .true
    cmp r8, 11
    je .true
    mov rax, FALSE
    ret
.true:
    mov rax, TRUE
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif