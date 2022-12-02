; OddEven- Sum.

; NASM x64 program
; TRAN LONG VU


%include 'functions.asm'

section .data  
    msg1 db "insert: 1.plus, 2.minus, 3.multiply, 4.divide" , 10, "Then insert 2 numbers"
section .bss
    n resb 64 
    num1 resb 64
    num2 resb 64
    operand resb 1
    buffer resb 64

section .text


    global _start
_start:
    mov rax, msg1
    call sprintLF ; sprintLF weakness: _slen reads all legth of assigned constants. 

    mov rax, operand ; input 
    call sinput 

    mov rax, operand ;
    call atoi   ; operand n in rax

    call _Calculator
    ; print result
    call quit






_Calculator: ; main algorithm function:
    ;
    .init:
        mov r11, rax
    ; notes; compare odd even
    ; r8 num 1
    ; r9 num 2
    ; r10 result
    ; r11 opeartor

    ; r12 
    ; r13
    ; r14
    ; r15
    
    .operand:
        cmp r11, 1
        je .plus
        cmp r11, 2
        je .minus
        cmp r11, 3
        je .multi
        cmp r11, 4
        je .divide
        cmp r11, 0
        je quit
        jmp .done
    
    .plus:
        call _taketwoinput
        add r8, r9 ; addition
        mov rax, r8 
        call itoa
        mov rax, buffer
        call sprintLF   
        jmp .done
    .minus:
        call _taketwoinput
        sub r8, r9 ; sub
        mov rax, r8 
        call itoa
        mov rax, buffer
        call sprintLF   
        jmp .done
    .multi:
        call _taketwoinput
        mov rax, r8
        mul r9 ; multi
        call itoa
        mov rax, buffer
        call sprintLF   
        jmp .done
    .divide:
        call _taketwoinput
        mov rax, r8
        div r9 ; divide
        call itoa
        mov rax, buffer
        call sprintLF   
        jmp .done
    

        

    .done:
        ret

_taketwoinput:


        mov rax, num1
        call sinput
        call atoi ; to int
        mov r8, rax 

        mov rax, num2 
        call sinput
        call atoi
        mov r9, rax


        ret


    
    














