; input a string
; output the reversed.

; procedure::
;
; swap first and last letters 
; procees loop 1/2 time the length. 

;process is same as - git




; RDI at last - RSI at first

; using stack to exchange.
; move first char to stack
; move last char to stack
; pop last char in RSI
; pop first char in RDI
;

;

;ex: A B C D E into stackk >>>>>   ABCDE ]
;
; pop char in another string: 
; E > D > C > B > A
; return string: EDCBA



; code run on Ubuntu 64bit using nasm.

section .data 

msg times 64 db 0 ; def byte 64times as zero 0 .; used as 64memory
len equ 64 ; 64 bit length


section .bss;
;none
section .text ; code zone.

global main ; start code

    main: ; 64 bit 
        
    call _read
    call _init
    call _swap
    call _write
    call _exit



    
    _read: 
        mov rdx,len ; length
        mov rsi,msg ; read content
        mov rdi,0
        mov rax,0
        syscall
        ret

    _init:
        mov rcx,rax     ; Copy the string for later
        mov rdi,msg     ; Set RDI and RSI to point at message
        mov rsi,msg     ; note: set RDI at last char
                        ; RSI at fist letter

        add rdi,rax     ; RDI should point at last character in message
        dec rdi         ;
        shr rax,1       ; Divide length by 2
        ret

    _swap:; Swap the characters using 8 bit registers
        mov bl,[rsi]    ; Swap the characters using 8 bit registers
        mov dl,[rdi]    ; mov first char to rbx
        mov [rsi],dl    ; mov last char to rdx
        mov [rdi],bl   ; mov last char in rsi


    ;mov [rdi],bl   ; mov last char in rsi
                    ; mov first char in rdi
                    ; swapped.

        inc rsi         ; Increment rsi (which is a pointer)
        dec rdi         ; Decrement rdi (also a pointer)
        dec rax         ; Decrement our counter of chars. loop 1/2time the length
        jnz _swap       ; If our counter isn't zero, keep looping
        ret
    _write:
        mov rdx,rcx ; nbytes--
        mov rsi,msg ; *msg
        mov rdi,1 ; stream
        mov rax,1 ; syscall
        syscall
        ret
        
    _exit:
        mov rdi,0
        mov rax,60 ; sysexit
        syscall





