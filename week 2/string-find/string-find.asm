; LONG VU TRAN
; x64 LINUX COMPILER NASM
; FIND STRING
;
; steps: 
; 1. input two strings.
; 2. compare. 
; 3. output results.
;
; 2: 
; -iterate through string 
; - if not similar, skip
; 
; - if similar
; - push similar in stack
; - similar count +1. defualt count zero.
; - position number record in iteration
; - print similar ones
; iteration ends when out of strings.


section .bss
string1 resb 100; reserve string x 100 
string2 resb 10; reserve a x10 string

section .data

section .text

global _start
_start:


    call _input1
    call _input2
    call _output1
    call _output2
    call _sysexit

    _input1:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, string1 ; take in input
    mov rdx, 100 ; length of input
    syscall
    _input2:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, string2 ; take in input
    mov rdx, 10 ; length of input
    syscall

















    
    _output1:
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, string1     ; write message in register ecx
    mov rdx, 100  ; legthh of message in reg ecx 32chars
    syscall;
    _output2:
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, string2     ; write message in register ecx
    mov rdx, 10  ; legthh of message in reg ecx 32chars
    syscall;
    _sysexit:
    mov rax, 60           ; write output code 4 for eax
    mov rdi, 0          ; std output code 1
    ; legthh of message in reg ecx 32chars
    syscall;










