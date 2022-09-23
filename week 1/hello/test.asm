section .data
    msg db "Hello world!", 0ah ; var 
    
    BUFSIZE equ $-buffer 

section .bss
    buffer resb

section .text
    global _start ; fucntion

_start:
    xor rax, rax, 1 ; readmode in reg 1
    xor edi, edi   ; standard input 0

    mov rsi, buffer ; message var
    mov edx, BUFSIZE ; length of msg
    syscall ; call kernel to output-
    


    ;mov rax, 60 ; sys exit reg
    ;mov rdi, 0 ; exit successful with ouput 0
    
    ;syscall ; call kernel to end
