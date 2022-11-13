
section .bss
    string  resb  256

section .text
    global _start
_start:
    mov     rbp, rsp
    ; get user input
    mov     rdi, 0
    mov     rsi, string
    mov     rdx, 256
    mov     rax, 0
    syscall
    
    mov     rdi, string
    call    reverse
    
    mov     rsi, rax
    mov     rdi, 1
    call    println
    
    mov     rdi, 0
    mov     rax, 60
    syscall






println:    ; print with linefeed by append linefeed to string
    mov     al, 0xa
    mov     [rsi + rdx], al
    inc     rdx
    mov     rax, 1
    syscall
    ret



reverse:    ; reverse(str) use stack to store each byte and pop to reverse the string str, return *st in rax, str.size in rdx
    push    rbp
    mov     rbp, rsp  
    mov     rsi, rdi
    xor     ax, ax
    xor     rcx, rcx
    cld                     ; clear direction flag DF
    
    .iterPush:              ; iterate string and push to stack
    lodsb                   ; al = byte ptr [esi]++
    cmp     al, 0xa
    jng     .pop
    push    ax              ; push 16bit
    inc     cx
    jmp     .iterPush

    .pop:
    mov     rdx, rcx
    mov     rsi, rdi        ; save begin of str
    .iterPop:               ; pop back
    pop     ax
    stosb                   ; byte ptr [rdi]-- = al
    dec     cx
    test    cx, cx
    jz      .done
    jmp     .iterPop
    
    .done:
    mov     rax, rsi
    mov     rsp, rbp
    pop     rbp
    ret  