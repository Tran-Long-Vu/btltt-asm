

; code run on Ubuntu 64bit using nasm.
; TRAN LONG VU - STRING REVERSE
; 1. INPUT STRING
; 2. REVERSE STRING
        ; iterate and push char through string.
        ; check end of string, pop each char into rax.

; 3. OUTPUT RESULT.

section .bss
    string  resb  256

section .text
    global _start
_start:
    mov     rbp, rsp ; stack pointer into rbp
    
    ; get user input
    mov     rdi, 0
    mov     rsi, string
    mov     rdx, 256
    mov     rax, 0
    syscall
    ; reverse the string
    mov     rdi, string ; starts at rdi, result at rax
    call    _reverse
    ; print out result.
    mov     rsi, rax
    mov     rdi, 1
    call    sprint
    
    mov     rdi, 0
    mov     rax, 60
    syscall


 
 
;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    rbx
    mov     rbx, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx
    ret
 
 
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    rdx
    push    rsi
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax ; print content
    mov     rbx, 1
    mov     rax, 1
    syscall
 
    pop     rbx
    pop     rsi
    pop     rdx
    ret
 
 

_reverse:; push byte into stack and pop back.
        .init:
        ;push    rbp
        ;mov     rbp, rsp  

        mov rsi, rdi; mov string into rsi
        xor ax,ax ; ax code 0
        xor rcx, rcx; rcx code 0

        .pushLoop:
        lodsb ; load single byte from RSI(SIL) into RAX = mov RAX, SI
        
        
        cmp al, 0xa ; check NULL(end of string) to pop.
        jng .pop ; if not greater, pop

        push ax ; push the 16b char from RAX to stack
                ; cannot push 8bit. wrong operand
        inc cx; counter +1
        jmp .pushLoop

        .pop: 
        mov rdx, rcx ; rdx = (len of string)
        mov rsi, rdi ; rsi = string

        .popLoop:
        pop ax ; after string push, pop back char to ax.
        stosb ; PUSH single byte from AX to RSI.
        dec cx  ; decrease length of cx
        test cx,cx ; cx = 1 or 0
        jz .done ; if 0, end prog
        jmp .popLoop ; loop the pop 
        ; functions ends with RSI having the converted string.
        .done:
        mov     rax, rsi ; return convrted to rax 
        
        ;mov     rsp, rbp ; return stack 
        ;pop     rbp      ; pop off rbp
        ret  




itoa:
    push rax
    push rcx
    push rdx
    push rsi
    mov rcx, 0 ; counter
    
.divideLoop:
    lodsb ; rsi to ax
    
    
    inc     rcx             ; count each byte to print - number of characters
    mov     dx, 0          ; empty edx
    mov     r9, 10         ; mov 10 into 9r
    
    idiv    r9             ; divide eax by r9

    add     dx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    
    
    mov rsi, rdx
    

    push    ax             ; push edx (string representation of an intger) onto the stack
    
    cmp     rax, 0          ; can the integer be divided anymore?
    jnz     .divideLoop      ; jump if not zero to the label divideLoop

.popLoop:
    pop ax ;return from 
    stosb ; mov rsi, ax

    dec rcx
    cmp rcx, 0          ; compare ecx register's value against decimal 0 (our counter register)
    je .restore ; jump if equal to 0 (no integer arguments were passed to atoi)
    jmp .popLoop


.restore:
    mov rax, rsi ; return result in rax.
    pop     rsi             ; restore esi from the value we pushed onto the stack at the start
    pop     rdx             ; restore edx from the value we pushed onto the stack at the start
    pop     rcx             ; restore ecx from the value we pushed onto the stack at the start
    pop     rbx             ; restore ebx from the value we pushed onto the stack at the start
    ret