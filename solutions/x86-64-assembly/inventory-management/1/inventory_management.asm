WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

global get_box_weight
get_box_weight:
    movzx eax, di        
    movzx esi, si          
    imul eax, esi          

    movzx edx, dx          
    movzx ecx, cx         
    imul edx, ecx         

    add eax, edx
    add eax, WEIGHT_OF_EMPTY_BOX
    ret

global max_number_of_boxes
max_number_of_boxes:
    movzx ecx, dil         
    mov eax, TRUCK_HEIGHT  
    xor edx, edx           
    div ecx                
    movzx eax, al          
    ret

global items_to_be_moved
items_to_be_moved:
    mov eax, edi          
    sub eax, esi          
    ret

global calculate_payment
calculate_payment:
   
    mov eax, esi           
    imul rax, PAY_PER_BOX  

    mov r11d, edx          
    imul r11, PAY_PER_TRUCK_TRIP
    add rax, r11           

    sub rax, rdi           

    mov r10d, ecx          
    imul r10, r8           
    sub rax, r10          

    movzx ecx, r9b         
    inc ecx                

    cqo                    
    idiv rcx               

    add rax, rdx           
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif