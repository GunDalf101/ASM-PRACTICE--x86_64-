section .data
    tes db "test.exe", 0
    siz dq 8 


section .text
    global _main

_main:
    lea r15, [rel tes]
    mov r14, [rel siz]
    call write_str      
    
    mov rax, 0x2000001   
    xor rdi, rdi         
    syscall
write_str:
    mov rax, 0x2000004
    mov rdi, 1
    mov rsi, r15
    mov rdx, r14
    syscall
    ret