; input a string
; output the reversed.

; procedure::
; # NOTE: make  push/pop in a single fucbniton call./
; slot ABCDE in reg
; make loop:

; push each
; loop pop each
; move A into smol reg
; push A in to stackk
; slot B into new reg

; pop A




;ex: A B C D E into stackk >>>>>   ABCDE ]
;
; pop char in another string: 
; E > D > C > B > A
; return string: EDCBA



; code run on Ubuntu 64bit using nasm.
section .bss;
;none
section .text ; code zone.
global main ; start code

    main: ; 64 bit runs with rax,rbx,rdx,..
        
 
        mov rsi, msg; load msg var into reg rsi (ecx)   
        push rsi
        call _loop ; SEGMETATION FAULT 
        pop rsi
        call _print
        
        call _exit

      ; add char:
    _loop:
        mov rax, [rsi] ; first char

        cmp rax, 0x0 ; check null
        je _done
        
        ;mov rbx, rax ; move 8bit char into rbx. 
        ;push rbx ; push al char into stack 
                  ; must pop it back to rbx
        jmp _next

        
        ; goes next when done pushing stuff to stackk 
        ;and clear the register.

        
        

    _next: 
        inc rsi ; char +1 
        push rax
        mov rax,0
        jmp _loop








    _print: 
        mov rsi, rbx
        mov rdx, len       ; length of string to be printed
        mov rdi, 1          ; std output
        mov rax, 1         ; write mode
        syscall
        ret
    _done:   
        pop rbx 
        ret ; return
    _exit:
        mov rax, 60
        mov rbx, 0
        syscall


section .data 

msg db "ABCDE", 13, 10 ; assign var msg with "ABCDE." end of line.
len equ $-msg

msg2 db "xxxxx", 13, 10 ; assign var msg with "ABCDE." end of line.
len2 equ $-msg



