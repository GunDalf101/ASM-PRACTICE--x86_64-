section .data
    buffer db 20

section .bss
    result resq 1 

section .text
    global _main

_main:
    
    mov rax, 123455

    lea rdi, [rel buffer] 
    mov rsi, rax
    call int_to_string

    call print_string

    mov rax, 0x2000001
    xor rdi, 0
    syscall

print_string:
    mov rax, 0x2000004   
    mov rdi, 1           
    lea rsi, [rel buffer] 
    mov rdx, 20          
    syscall 
    ret

int_to_string:
    push rax          
    push rdi
    push rcx

    mov rcx, 10        
    mov rdi, rdi        
    add rdi, 19        
    mov byte [rdi], 0  
.reverse_loop:
    dec rdi            
    xor rdx, rdx       
    div rcx            
    add dl, '0'        
    mov [rdi], dl      
    test rax, rax     
    jnz .reverse_loop    

    mov rsi, rdi        
    pop rcx            
    pop rdi
    pop rax
    ret