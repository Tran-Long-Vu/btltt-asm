; OddEven- Sum.

; NASM x64 program
; TRAN LONG VU


%include 'functions.asm'

section .data
	msg1 db "How many numbers in array? "
	       

    min dq 0     
    msg2 db "Input elements "       
	msg3 db "Input First "                          
    max dq 0                            

    msg4 db "Min:"   
    msg5 db "Max "   
section .bss
    n resb 64
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
    call atoi   ; integer n in rax

    mov dword [n], eax ; integer n

    call _inputCompare





    ; print result
    
    mov rax, msg4
    call sprintLF
    mov rax, r9 ; int of min
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    
    mov rax, msg5
    call sprintLF
    mov rax, r15 ; int of max
    call itoa   ; int to string in buffer
    mov rax, buffer
    call sprintLF

    call quit






_inputCompare: ; main algorithm function:
    
    .init:
    ; notes;
    ;
    ;
    ;
    ;
    ;
    ;
    ;
    ;
        mov r14, rax; no. of elemets
        mov r13, 0 ; counter

        jmp .compare
    .input:; input single compo of array:
        mov rax, msg2
        call sprintLF

        mov rax, e ; input string
        call sinput

        mov rax, e
        call atoi ; to integer( e = rax)

        jmp .compare

    .compare:
    ; note:

    .cmpMin:
        
        jl .setMin
        jmp .cmpMax ; e > min
    .setMin:
        
        jmp .loopcheck
    .cmpMax:
            
            jmp .loopcheck; e < max? jmp to loopchecc
    .setMax:
            
            jmp .loopcheck
    .loopcheck:        
        inc 
        cmp 
        je .done
        jmp 
    .done:
        
        ret


    
    














