section .text
GLOBAL _start

_start: mov ecx, string
        call toUpper
        call print
        mov eax,1
        mov ebx,0
        int 80h

_start: 
        
        mov rsi, string
        call toUpper ;; call function
        call print
        
        mov rax,60 ; end rax
        mov rdi,0 ; sys exit rbx
        syscall

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
done:   ret

print:  mov rsi, input    ; what to print
        mov rdx, len       ; length of string to be printed
        mov rdi, 1          ; std output
        mov rax, 1         ; write mode
        syscall
        ret

section .data
string: db "h4ppy c0d1ng",10,0
len:    equ $-string