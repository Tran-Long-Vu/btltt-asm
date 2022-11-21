; OddEven- Sum.

; NASM x64 program
; TRAN LONG VU


%include 'functions.asm'

section .data

	       
    msg3 db "even"   
    min dq 0     
    msg1 db "Input ? "       
                       
    max dq 0                            

    msg2 db "odd"   
    
section .bss
    n resb 64
    
    buffer resb 64

section .text


    global _start
_start:
    ;input no. of numbers
    mov rax, msg1
    call sprintLF

    mov rax, n ; input 
    call sinput 

    mov rax, n ;
    call atoi   ; integer n in rax

    call _inputCompare
    ; print result
    call quit






_inputCompare: ; main algorithm function:
    ;
    .init:
    ; notes; compare odd even
    ; r10 = rax.
        ; int in rax
        mov rbx, 2 ; dividant
        mov rdx, 0 ; remainder
    .code:
        div rbx
        cmp rdx, 0 
        je .even
        jne .odd
    .even:
        mov rax, msg3
        call sprintLF
        jmp .done
    .odd:
        mov rax, msg2
        call sprintLF
        jmp .done
    .done:
        ret




    
    














