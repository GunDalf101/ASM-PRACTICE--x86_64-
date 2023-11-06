section .data
    buffer db 20       ; Buffer to store the integer as a string

section .bss
    result resq 1      ; A 64-bit integer to convert and print

section .text
    global _main

_main:
    ; Set the integer value to convert
    mov rax, 123455       ; Replace 100 with your desired integer

    ; Convert the integer to a string
    lea rdi, [rel buffer]   ; Address of the buffer
    mov rsi, rax        ; The integer to convert
    call int_to_string

    call print_string
    ; Exit the program
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
    push rax            ; Save registers that will be modified
    push rdi
    push rcx

    mov rcx, 10         ; Set divisor (base 10)
    mov rdi, rdi        ; Copy the buffer address to rdi
    add rdi, 19         ; Move rdi to the end of the buffer
    mov byte [rdi], 0   ; Null-terminate the string

.reverse_loop:
    dec rdi             ; Move to the previous character in the buffer
    xor rdx, rdx        ; Clear any previous remainder
    div rcx             ; Divide rax by 10
    add dl, '0'         ; Convert the remainder to ASCII
    mov [rdi], dl       ; Store the character in the buffer

    test rax, rax       ; Check if quotient is zero
    jnz .reverse_loop    ; If not, continue the loop

    mov rsi, rdi        ; Set rsi to the address of the beginning of the string

    pop rcx             ; Restore registers
    pop rdi
    pop rax
    ret