; min max value in array
; NASM x64 program
; TRAN LONG VU
; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm

%include 'functions.asm'

section .data
	msg1 db "How many numbers in array? (1 to 99): "
	msg2 db "Input elements "       
	msg3 db "Input First "          

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

    mov rax, n ;
    call atoi   ; integer n

    mov dword [n], eax ; integer n

    call _inputCompare

    ; print result

    mov rax, [min] ; int of min
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    

    mov rax, [max] ; int of max
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    call quit

_inputCompare:
    
    .init:
        
        
        push rax
        push r10
        push r11
        push r12
        push r13
        mov r14, rax
        mov r13, 0 ; counter
    .firstInput:; input single compo of array:
        mov rax, msg3
        call sprintLF

        mov rax, e ; input string
        call sinput

        mov rax, e
        call atoi ; to integer( e = rax)
        ; first number of the array (rax)
        ; init min = max = first a[0]
        mov r10, rax
        mov r11, rax
        mov r12, rax
        
        jmp .compare
    .input:; input single compo of array:
        mov rax, msg2
        call sprintLF

        mov rax, e ; input string
        call sinput

        mov rax, e
        call atoi ; to integer( e = rax)
        mov r10, rax 
        jmp .compare

    .compare:
    ; note:
    ; r10 = num e (rax changed)
    ; r11 = min
    ; r12 = max
    ; r13 = count ; +count
    ; r14 = n
    ; 0 = [min] 
    ; [min] = [max]
    ; [max] = [e] ; input
    ;



    
    .cmpMin:
        cmp r10, r11 ; if e < min, jmp 
        jl .setMin

        jmp .cmpMax
    .setMin:
        mov r11, r10
        mov [min],r11 ; min = e
        jmp .loopcheck
    .cmpMax:
            cmp r10, r12
            jg .setMax
    .setMax:
            mov r12,r10
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

; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm
; note: last case between min and max dispurts the algoritm

    

    
    














