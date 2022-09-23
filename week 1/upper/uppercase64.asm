section .bss 
    input resb 32; input

section .text
global _start


_start: 
        call _takeInput
        mov rsi, input
        call toUpper ;; call function
        call print
        
        mov rax,60 ; end rax
        mov rdi,0 ; sys exit rbx
        syscall

_takeInput:
    mov rax, 0  ; read mode rax code: 
    mov rdi, 0; stdinput code 1

    mov rsi, input ; take in input
    mov rdx, 32 ; length of input

    syscall ; 

toUpper: ; al = 16 bit reg
        mov al,[rsi]      ; ecx is the pointer, so [ecx] the current char 
        cmp al,0x0 
        je done
        cmp al,'a'
        jb _nextChar
        cmp al,'z'
        ja _nextChar
        
        sub al, 0x20        ; move AL upper case and
        mov [rsi],al      ; write it back to string

_nextChar:
        inc rsi           ; not al, that's the character. ecx has to
                          ; be increased, to point to next char
        jmp toUpper     ; jump? to next char in string

done:   ret ; return

print:  mov rsi, input    ; what to print
        mov rdx, len       ; length of string to be printed
        mov rdi, 1          ; std output
        mov rax, 1         ; write mode
        syscall
        ret

section .data

len:    equ 32