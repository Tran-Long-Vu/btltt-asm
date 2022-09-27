;input: 2 string.
; 1 long string
; 1 char
; 


; detect char in string
;
;record: times 
;record position.
;
; reutrn: times of appearance.
; turen: 
;position.

;
;
;
;
;
; LONG VU TRAN
; x64 LINUX COMPILER NASM
; FIND STRING AND RECORD
;


; iteration ends when out of strings.


section .bss
string1 resb 100; reserve string x 100  word
string2 resb 1; reserve a x1 char

section .data
downline db 10

section .text

global _start
_start:

    ;function
    ;input
    call _input1
    
    call _input2

    ; call compare


    ;output

    
    call _output1
    call _output2
    call _downline
    call _downline
    call _downline
    call _downline
    call _downline
       
    
    call _sysexit


    ; input
    _input1:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, string1  ; take in input
    mov rdx, 100 ; length of input
    syscall
    _input2:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, string2 ; take in input
    mov rdx, 1 ; length of input
    syscall

    ; compare loop
;
;
;

;
;
;
;
;
;
;
;
;




    ;input
    _output1:
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, string1     ; write message in register ecx
    mov rdx, 100  ; legthh of message in reg ecx 32chars
    syscall;
    _output2:
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, string2   ; write message in register ecx
    mov rdx, 11  ; legthh of message in reg ecx 32chars
    syscall;

    _downline:
    mov rax, 1           ; write output code 4 for eax
    mov rdi, 1           ; std output code 1
    mov rsi, 10   ; write message in register ecx DIOWWONLINE
    mov rdx, 2  ; legthh of message in reg ecx 32chars
    syscall;
    
    _sysexit:
    mov rax, 60           ; write output code 4 for eax
    mov rdi, 0          ; std output code 1
    ; legthh of message in reg ecx 32chars
    syscall;











