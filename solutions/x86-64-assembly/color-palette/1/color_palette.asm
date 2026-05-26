; Everything that comes after a semicolon (;) is a comment

; Define the constants 'RED', 'GREEN' and 'BLUE'
; They must be accessible from other source files

; Define the variable 'base_color' with the default value of 0xFFFFFF00
; It must be accessible from other source files

default rel
extern combining_function

section .rodata
global RED
RED dd 0xFF000000

global GREEN
GREEN dd 0x00FF0000

global BLUE
BLUE dd 0x0000FF00

section .data
global base_color
base_color dd 0xFFFFFF00
temp_addr dq 0

section .text


; the global directive makes a function visible to the test files
global get_color_value
get_color_value:

    mov eax, dword [rdi]
    ret

global add_base_color
add_base_color:
    mov eax, dword [rdi]
    mov dword [base_color], eax
    ret

global make_color_combination
make_color_combination:

    mov qword [temp_addr], rdi
    mov edi, dword [base_color]
    mov esi, dword [rsi]

    call combining_function 

    mov rdi, qword [temp_addr]
    mov dword [rdi], eax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
