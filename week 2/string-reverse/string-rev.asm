; input a string
; output the reversed.

; proc:

; adding every single char to the stacc.
; pop each and print
;
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

        call _loop ; SEGMETATION FAULT 

        call _print
        
        mov rax, 60 ; clear reg rax
        mov rdi, 0 ; clear reg rdi, exit code 0
        syscall ; call kernel.

      ; add char:
    _loop:
    xor bx,bx ; counter
        mov al, [rsi] ; first char

        cmp byte [rax], 0; check null, check end of string
        jz _done 

        push ax ; push al char into stack
        pop rbp
        inc rsi ;+1 char
        inc bx ; +1 counter


        cmp bx, len ; counter loop end check+
        jne _loop ; back to loop
        
    _print: 
        mov rsi, msg    ; what to print
        mov rdx, len       ; length of string to be printed
        mov rdi, 1          ; std output
        mov rax, 1         ; write mode
        syscall
        ret
    _done:   
        ret ; return



section .data 

msg db "ABCDE", 13, 10 ; assign var msg with "ABCDE." end of line.
len equ $-msg





