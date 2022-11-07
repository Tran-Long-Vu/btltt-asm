;itoa function by longvu.


section .data


section .bss
    c resb 33
section .text
global  _start
 
_start:
    

    
    mov rax, 599
    call itoa
    call sprint

    mov rax, 60
    mov rbx, 0
    syscall

; integer to ascii
; number in RAX
; counter in RCX
; divide by 10
; add 48 for string
; 2nd loop: pop + ret

itoa:
    push rax
    push rcx
    push rdx
    push rsi
    mov rcx, 0 ; counter
    
.divideLoop:
    inc     rcx             ; count each byte to print - number of characters
    mov     dx, 0          ; empty edx
    mov     rsi, 10         ; mov 10 into esi
    
    idiv    rsi             ; divide eax by esi

    add     dx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    
    push rsi
    mov rsi, rdx
    lodsb
    pop rsi

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
 



















