; Calculator


; NASM x64 program
; TRAN LONG VU


%include 'functions.asm'

section .data  
    msg1 db "insert: 1.plus, 2.minus, 3.multiply, 4.divide",0
    msg2 db  " Insert number 1:",0
    msg3 db  " Insert number 2:",0
    msg4 db  "result:",0
    msg6 db "Invalid. Enter a number.",0
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
    call sprintLF 

    mov rax, operand ; input 
    call sinput 

    mov rax, operand ;
    call validCheck
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
        mov rax, msg2
        call sprintLF 

        mov rax, num1
        call sinput
        mov rax, num1
        call validCheck
        call atoi ; to int
        mov r8, rax 

        mov rax, msg3
        call sprintLF 

        mov rax, num2 
        call sinput
        mov rax, num2
        call validCheck
        call atoi
        mov r9, rax

        mov rax, msg4
        call sprintLF 
        ret


validCheck: ; string at rax
    push rax
    push rbx
    .looop:
    
    mov bl, byte [rax]  
    ; cmp each of rax chars, 0-9

    cmp bl, 10; end of string
    je .done
    ; if invalid? loop back to reader. 

    cmp bl, 48  ; valid 0
    jle .invalid

    cmp bl,57 ; valid 9
    jg .invalid
    
    ;valid. move back
    
    jmp .next
    
    .next:
        inc rax
        jmp .looop
    .done:
        pop rbx
        pop rax
        ret
    .invalid:
        mov rax, msg6 
        call sprintLF
        call quit
    

