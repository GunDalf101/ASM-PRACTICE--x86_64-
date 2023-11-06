section .data
    tes db 256 dup(0)
    str_count db 32 dup(0)
    count dq 0, 0


section .text
    global _main

_main:

    call read_string
    lea r15, [rel tes]
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
        mov rdi, [rel count]
        dec rdi
        mov [rel count], rdi
        mov rax, [rel count]
        lea rdi, [rel str_count]
        mov rsi, rax
        call int_to_string

        call print_string
           
        syscall             
    
    mov rax, 0x2000001   
    xor rdi, rdi         
    syscall              

read_string:
    mov rax, 0x2000003
    mov rdi, 0           
    lea rsi, [rel tes] 
    mov rdx, 255         
    syscall 
    ret

print_string:
    mov rax, 0x2000004   
    mov rdi, 1           
    lea rsi, [rel str_count] 
    mov rdx, 255      
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