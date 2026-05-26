section .text

global time_to_make_juice
global time_to_prepare
global limes_to_cut
global remaining_orders

time_to_make_juice:
    cmp edi, 1
    je .one
    cmp edi, 2
    je .two
    cmp edi, 3
    je .three
    cmp edi, 4
    je .four
    cmp edi, 5
    je .five
    cmp edi, 6
    je .six
    cmp edi, 7
    je .seven
    mov eax, 10
    ret

.one:
    mov eax, 1
    ret
.two:
    mov eax, 3
    ret
.three:
    mov eax, 3
    ret
.four:
    mov eax, 4
    ret
.five:
    mov eax, 5
    ret
.six:
    mov eax, 4
    ret
.seven:
    mov eax, 7
    ret

time_to_prepare:
    xor eax, eax
    xor ecx, ecx

.loop:
    cmp ecx, esi
    jge .done

    mov edx, dword [rdi + rcx*4]

    cmp edx, 1
    je .add1
    cmp edx, 2
    je .add3
    cmp edx, 3
    je .add3
    cmp edx, 4
    je .add4
    cmp edx, 5
    je .add5
    cmp edx, 6
    je .add4
    cmp edx, 7
    je .add7
    add eax, 10
    jmp .next

.add1:
    add eax, 1
    jmp .next
.add3:
    add eax, 3
    jmp .next
.add4:
    add eax, 4
    jmp .next
.add5:
    add eax, 5
    jmp .next
.add7:
    add eax, 7

.next:
    inc ecx
    jmp .loop

.done:
    ret

limes_to_cut:
    xor eax, eax
    xor ecx, ecx
    xor r8d, r8d

.loop2:
    cmp r8d, edi
    jae .done2
    cmp ecx, edx
    jge .done2

    mov r9b, byte [rsi + rcx]

    cmp r9b, 'S'
    je .small
    cmp r9b, 'M'
    je .medium

    add r8d, 10
    jmp .next2

.small:
    add r8d, 6
    jmp .next2

.medium:
    add r8d, 8

.next2:
    inc eax
    inc ecx
    jmp .loop2

.done2:
    ret

remaining_orders:
    xor eax, eax
    xor ecx, ecx

.loop3:
    mov edx, dword [rsi + rcx*4]
    test edx, edx
    jz .done3

    cmp edx, 1
    je .r1
    cmp edx, 2
    je .r3
    cmp edx, 3
    je .r3
    cmp edx, 4
    je .r4
    cmp edx, 5
    je .r5
    cmp edx, 6
    je .r4
    cmp edx, 7
    je .r7
    mov r8d, 10
    jmp .have_time

.r1:
    mov r8d, 1
    jmp .have_time
.r3:
    mov r8d, 3
    jmp .have_time
.r4:
    mov r8d, 4
    jmp .have_time
.r5:
    mov r8d, 5
    jmp .have_time
.r7:
    mov r8d, 7

.have_time:
    sub edi, r8d
    inc eax
    inc ecx
    cmp edi, 0
    jg .loop3

.done3:
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif