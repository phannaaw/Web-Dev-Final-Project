section .text

factorial:
    ; rdi = n
    ; rax = n!
    mov rax, 1
factorial_helper:
    cmp rdi, 1
    jle .base_case
    imul rax, rdi
    dec rdi
    jmp factorial_helper
.base_case:
    ret

global largest_portion
largest_portion:

    test rsi, rsi
    jz .done

    mov rax, rdi
    xor edx, edx
    div rsi            

    mov rdi, rsi       
    mov rsi, rdx       
    jmp largest_portion

.done:
    mov rax, rdi
    ret

global double_factorial
double_factorial:
    ; rdi/edi = n
    ; rax = n!!
    mov rax, 1
.loop:
    cmp edi, 1
    jbe .done
    imul rax, rdi
    sub edi, 2
    jmp .loop
.done:
    ret

global pipers_pi
pipers_pi:

    push rbx
    mov ebx, edi       

    xor eax, eax
    cvtsi2sd xmm1, rax 

    mov eax, 1
    cvtsi2sd xmm0, rax 

    xor ecx, ecx       
.loop:
    addsd xmm1, xmm0   

    cmp ecx, ebx
    je .finish

    mov edx, ecx
    inc edx
    cvtsi2sd xmm2, rdx     

    mov edx, ecx
    add edx, ecx
    add edx, 3
    cvtsi2sd xmm3, rdx     

    divsd xmm2, xmm3
    mulsd xmm0, xmm2      

    inc ecx
    jmp .loop

.finish:
    addsd xmm1, xmm1       
    movapd xmm0, xmm1
    pop rbx
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif