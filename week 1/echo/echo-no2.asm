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
 
    mov     rsi, rax
    mov     rbx, 1
    mov     rax, 1
    syscall
 
    pop     rbx
    pop     rsi
    pop     rdx
    ret

sinput:
    push    rdx
    push    rsi
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax
    mov     rbx, 0
    mov     rax, 0
    syscall
 
    pop     rbx
    pop     rsi
    pop     rdx
    ret