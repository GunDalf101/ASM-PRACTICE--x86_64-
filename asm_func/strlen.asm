section .data
    tes db "test.exe", 0
    count dq 0, 0


section .text
    global _main

_main:

    lea r15, [rel tes]
    call strlen      
    
    mov rax, 0x2000001   
    xor rdi, rdi         
    syscall

strlen:
    loop_start:
        mov al, [r15]
        cmp al, 0
        je loop_end

        mov rdi, [rel count]
        inc rdi
        mov [rel count], rdi

        mov [r15], al
        inc r15
               

        
        jmp loop_start
    loop_end:
        ret