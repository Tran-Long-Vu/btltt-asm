atoi:   ; ascii to int, return in eax
    push    rbp
    mov     rbp, rsp
    sub     rsp, 8
    push    rbx
    mov     [rbp - 8], rdi     
    mov     rsi, rdi
    xor     eax, eax
    xor     ecx, ecx
    mov     ebx, 10
    
    .iter: ; loop
    mul     ebx
    mov     cl, [rsi]
    inc     si
    cmp     cl, '0'
    js      .done
    cmp     cl, '9'
    jg      .done
    and     cl, 0xf
    add     eax, ecx
    jmp     .iter

    .done: 
    div     ebx ; into eax
    pop     rbx
    mov     rsp, rbp 
    pop     rbp    
    ret    