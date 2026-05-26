section .text

global front_door_response
front_door_response:
    ; rdi = address of the poem line
    mov al, byte [rdi]     ; first character
    ret


global front_door_password
front_door_password:
    ; rdi = address of the string to modify in-place

    ; Capitalize first character if it is lowercase
    mov al, byte [rdi]
    cmp al, 'a'
    jb .first_done
    cmp al, 'z'
    ja .first_done
    sub al, 32
.first_done:
    mov byte [rdi], al

    ; Make the rest lowercase
    inc rdi
.loop_fd:
    mov al, byte [rdi]
    test al, al
    jz .done_fd

    cmp al, 'A'
    jb .next_fd
    cmp al, 'Z'
    ja .next_fd
    add al, 32
    mov byte [rdi], al

.next_fd:
    inc rdi
    jmp .loop_fd

.done_fd:
    ret


global back_door_response
back_door_response:
    ; rdi = address of the poem line
    ; return the last alphabetic character found before the NUL terminator

    xor eax, eax           ; al = 0, used to keep the last letter found

.loop_bd:
    mov dl, byte [rdi]
    test dl, dl
    jz .done_bd

    ; Check if dl is A-Z or a-z
    cmp dl, 'A'
    jb .skip_bd
    cmp dl, 'Z'
    jbe .save_bd
    cmp dl, 'a'
    jb .skip_bd
    cmp dl, 'z'
    ja .skip_bd

.save_bd:
    mov al, dl

.skip_bd:
    inc rdi
    jmp .loop_bd

.done_bd:
    ret


global back_door_password
back_door_password:
    ; rdi = destination buffer
    ; rsi = source string

    ; Copy source string with proper capitalization
    mov al, byte [rsi]
    cmp al, 'a'
    jb .first_copy_done
    cmp al, 'z'
    ja .first_copy_done
    sub al, 32
.first_copy_done:
    mov byte [rdi], al
    inc rsi
    inc rdi

.copy_loop:
    mov al, byte [rsi]
    test al, al
    jz .append_suffix

    cmp al, 'A'
    jb .store_char
    cmp al, 'Z'
    ja .store_char
    add al, 32

.store_char:
    mov byte [rdi], al
    inc rsi
    inc rdi
    jmp .copy_loop

.append_suffix:
    mov byte [rdi], ','
    inc rdi
    mov byte [rdi], ' '
    inc rdi
    mov byte [rdi], 'p'
    inc rdi
    mov byte [rdi], 'l'
    inc rdi
    mov byte [rdi], 'e'
    inc rdi
    mov byte [rdi], 'a'
    inc rdi
    mov byte [rdi], 's'
    inc rdi
    mov byte [rdi], 'e'
    inc rdi
    mov byte [rdi], '.'
    inc rdi
    mov byte [rdi], 0
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif