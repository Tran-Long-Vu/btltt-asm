; code run on Ubuntu 64bit using nasm.
section .text ; code zone.
global main ; start code

main: ; 64 bit runs with rax,rbx,rdx,..
    mov rax, 1 ; write mode rax (eax)
    mov rdi, 1 ; std out  rdi  (ebx)

    mov rsi, msg; load msg var into reg rsi (ecx)
    mov rdx, 12  ; msg length into reg rdx (edx

    syscall ; call kernel

    mov rax, 60 ; clear reg rax
    mov rdi, 0 ; clear reg rdi, exit code 0
    syscall ; call kernel.

section .data 

msg db "hello world", 10 ; assign var msg with "hello world." end of line.

















