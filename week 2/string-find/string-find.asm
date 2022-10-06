; LONG VU TRAN
; steps: 
; 1. input two strings.
; 2. compare. 
; 3. output results.
;
; 2: 
; -iterate through string2
; - if not similar to char string1, +1 point string1
; 
; - if similar
; - push similar in stack
; - similar count +1. defualt count zero.
; - position of string1 char number record in iteration

; - print similar ones
; if not stringend/null, contume loop
; iteration ends when out of strings.


section .bss
string1 resb 100; reserve string x 100 
string2 resb 1; reserve a x10 string

section .data
msg db "found similar"
section .text

global main
main:


    call _input1
    call _input2

    call _iterate
    
    call _output1
    call _output2
    call _sysexit

    _input1:
        mov rax, 0  ; read mode rax code: 
        mov rdi, 0; stdinput code 1

        mov rsi, string1 ; take in input
        mov rdx, 100 ; length of input
        syscall
        ret

    _input2:
        mov rax, 0  ; read mode rax code: 
        mov rdi, 0; stdinput code 1

        mov rsi, string2 ; take in input
        mov rdx, 1 ; length of input
        syscall
        ret

    ; iteration:
    _iterate: 
    mov rsi, string1 

    mov al, [rsi]    ; first char of string1.
    mov rdx, string2 ; char of string2
    mov bl, [rsi]

    cmp al, bl ; compare char with string
    je _found



    cmp al, 0x0 ;check null
    je _done ;if null then end 

    inc rsi ; next char
    jmp _iterate

    _found:
        mov rax, 1           ; write output code 4 for eax
        mov rdi, 1           ; std output code 1
        mov rsi, msg    ; write message in register ecx
        mov rdx, 100  ; legthh of message in reg ecx 32chars
        syscall;
        ret

    _done:   ret ; return

    _output1:
        mov rax, 1           ; write output code 4 for eax
        mov rdi, 1           ; std output code 1
        mov rsi, string1     ; write message in register ecx
        mov rdx, 100  ; legthh of message in reg ecx 32chars
        syscall;
        ret

    _output2:
        mov rax, 1           ; write output code 4 for eax
        mov rdi, 1           ; std output code 1
        mov rsi, string2     ; write message in register ecx
        mov rdx, 1  ; legthh of message in reg ecx 32chars
        syscall;
        ret

    _sysexit:
        mov rax, 60           ; write output code 4 for eax
        mov rdi, 0          ; std output code 1
        ; legthh of message in reg ecx 32chars
        syscall;










