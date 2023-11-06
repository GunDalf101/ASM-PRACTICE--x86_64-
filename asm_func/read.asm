section .data
    tes db "", 0
    siz dq 8 


section .text
    global _main

_main:
    lea r15, [rel tes]
    mov r14, [rel siz]
    call read_str     
    
    mov rax, 0x2000001   
    xor rdi, rdi         
    syscall

read_str:
    mov rax, 0x2000003
    mov rdi, 0
    mov rsi, r15
    mov rdx, r14
    syscall
    ret
