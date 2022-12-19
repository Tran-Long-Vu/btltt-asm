; min max value in array
; NASM x64 program
; TRAN LONG VU

; ver2: added zero
; input check: positive integers.

%include 'functions.asm'

section .data
	msg1 db "How many numbers in array? ",0
	       

    min dq 0     
    msg2 db "Input elements ",0
	msg3 db "Input First ",0         


    max dq 0                            

    msg4 db "Min:",0 
    msg5 db "Max:",0 
    msg6 db "Invalid",0
section .bss
    n resb 64
    e resq 16
    buffer resb 64

section .text
    global _start
_start:
    ;input no. of numbers
    .read1:
    mov rax, msg1
    call sprintLF

    mov rax, n
    call sinput

    mov rax, n  ; value in rax.
                ; before call atoi, check ascii string for valid integers: 0-9
    call validCheck
    call atoi   ; integer n ( in rax) 

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
    ; r9 = min
    ; r15 = max
    ; 0 = [min] 
    ; [min] = [max]
    ; [max] = [e] ; input
    ; 



    
    .cmpMin:
        cmp r10, r11 ; if e < min, jmp 
        jl .setMin
        jmp .cmpMax ; e > min
    .setMin:
        mov r11, r10
        mov r9,r11 ; min = e
        jmp .loopcheck
    .cmpMax:
            cmp r10, r12 ; e > max
            jg .setMax ; 
            jmp .loopcheck; e < max? jmp to loopchecc
    .setMax:
            mov r12,r10
            mov r15,r12
            jmp .loopcheck
    

    .loopcheck:        
        inc r13
        cmp r13, r14
        je .done
        jmp .input
    .done:
        mov r9, r11
        mov r15, r12
        pop r13
        pop r12
        pop r11
        pop r10
        pop rax
        ret
       

validCheck:
    
    .looop:
    mov rbx ,rax
    mov rax, 0
    mov al, byte [rbx]  
    ; cmp each of rax chars, 0-9

    cmp al, 0x0 ; end of string
    je .done
    ; if invalid? loop back to reader. 

    cmp al,30h  ; smaller than 0?
    jl .invalid

    cmp al,39h ; greater than 9?
    jg .invalid
    
    ;valid. move back
    mov byte[rbx], al ; reutrn char to rbx
    jmp .next
    .invalid:
        mov rax, msg6 
        call sprintLF
    .next:
        inc rbx
        jmp .looop
    .done:
        ret        
      


    
    














