; OddEven- Sum.

; NASM x64 program
; TRAN LONG VU


%include 'functions.asm'

section .data
	msg1 db "How many numbers in array? ",0 ; count
    msg2 db "Input elements "    ,0   
    msg4 db "Oddsum:"   ,0
    msg5 db "Evensum: "   ,0
    msg6 db "Invalid. Enter a number.",0
section .bss
    n resq 16
    e resq 16
    buffer resb 64

section .text
    global _start
_start:
    ;input no. of numbers
    mov rax, msg1
    call sprintLF

    mov rax, n
    call sinput

    mov rax, n ;
    call validCheck
    call atoi   ; integer n in rax

    mov dword [n], eax ; save int n

    call _OddEvenSum





    ; print result
    
    mov rax, msg4
    call sprintLF
    mov rax, r9 ; int of odd
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    
    mov rax, msg5
    call sprintLF
    mov rax, r10 ; int of even
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    call quit






_OddEvenSum: ; main algorithm function:
    
    .init:
        ; notes;
        ; r8 = n
        ; r9 = oddsum (output)
        ; r10 = even sum (output)
        ; r11 = counter
        ; r12 = number input
        ; r13 = proxy
        push r8
        push r11
        push r12
        push r13


        mov r8, rax; no. of elemets
        mov r11, 0 ; counter
        mov r9, 0 ;oddsum
        mov r10, 0 ; evensum
        
    .input:; input single compo of array:
        mov rax, msg2 ; prompt input
        call sprintLF

        mov rax, e ; input string e
        call sinput

        mov rax, e
        call validCheck
        call atoi ; to integer e = rax
        mov r13, rax ; save to r13

        jmp .oddEven

    .oddEven:
                   ; divider = rax
        mov rbx, 2 ; dividant
        mov rdx, 0 ; remainder
        div rbx    ; divide rax by 2
        cmp rdx, 0 ; check even
        je .even
        jne .odd
    .even:
        
        add r10, r13  ; add evensum
        jmp .loopcheck
    .odd:
        add r9, r13   ; odd sum
        jmp .loopcheck

    .loopcheck:        
        inc r11 ; counter
        cmp r11, r8
        je .done
        jmp .input
    .done:
        pop r13
        pop r12
        pop r11
        pop r8 
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

    














