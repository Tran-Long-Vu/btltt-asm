global _start
section .data
    userMsg db "enter input:"
    lenuserMsg equ $-userMsg
    dispMsg db 'You have entered: '
    lenDispMsg equ $-dispMsg               ;The length of the output  

section .bss 
    input resb 5; input

section .text
_start:
    mov rax, 1 ; writemode in reg 1 (eax
    mov rdi, 1 ; standard ouput 1 (ebx

    mov rsi, lenuserMsg ; message var (ecx
    mov rdx, userMsg ; length of msg (edx

    syscall ; clear reg

    ;input code:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, input ; take in input
    mov rdx, 32 ; length of input

    syscall ; 

    ; output
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, dispMsg     ; write message in register ecx
    mov rdx, lenDispMsg  ; legthh of message in reg ecx
    syscall;




    ; output
    mov rax, msg
    mov rsi, rax

    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    ;mov rsi, input     ; write message in register ecx
    mov rdx, 32  ; legthh of message in reg ecx 32chars
    syscall;
    mov rax, 60           ; write output code 4 for eax
    mov rdi, 0          ; std output code 1
    ; legthh of message in reg ecx 32chars
    syscall;





