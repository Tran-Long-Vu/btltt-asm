; min max value in array
; NASM x64 program
; TRAN LONG VU
%include 'functions.asm'


section .data
	msg1 db "How many numbers in array? (1 to 99): "
	msg2 db "Input elements "
	msg3 db ": "
	msg4 db "Max: "
	msg5 db "Min: " 

    min dq 0 
    max dq 0


section .bss
    n resb 64
    e resb 64
    buffer resb 64

section .text
    global _start
_start:
    ;input no. of numbers
    mov rax, msg1
    call sprintLF

    mov rax, n
    call sinput

    mov rax, n
    call atoi

    mov qword [n], rax ; integer n

    call _inputCompare

    ; print result

    mov rax, min
    call iprintLF

    mov rax, max
    call iprintLF
    call quit
_inputCompare:
    .init:
    mov r14, n
        push rax
        push r10
        push r11
        push r12
        push r13
    .input:; input single compo of array:
        mov rax, msg2
        call sprintLF

        mov rax, e ; input string
        call sinput

        mov rax, e
        call atoi ; to integer(rax)

        mov qword [e], rax ; int e

        

    .compare:
    ; note:
    ; r10 = num e
    ; r11 = min
    ; r12 = max
    ; r13 = count ; inc count
    ; r14 = n
    mov r10, e
    mov r11, min
    mov r12, max
    mov r13, 0
    .cmpMin:
        cmp r10, r11 ; if e < min, jmp 
        jl .setMin
        jmp .cmpMax
    .setMin:
        mov r11, e
        mov [min],r11
        jmp .cmpMax
    .cmpMax:
        cmp r10, r12
        jg .setMax
    .setMax:
        mov r12,e
        mov [max],r12
        jmp .loopcheck
    .loopcheck:        
        inc r13
        cmp r13, r14
        je .done
        jmp .input
    .done:
        pop r13
        pop r12
        pop r11
        pop r10
        pop rax
        ret


    

    
    














