; TRAN LONG VU - STRING REVERSE
; 1. INPUT STRING
; 2. REVERSE STRING
        ; iterate and push through string.
        ; check end of string, pop each into rax.

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
    call    sprintLF
    
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
    push    rcx
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
    pop     rcx
    pop     rdx
    ret
 
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function 0AH
sprintLF:
    call    sprint
 
    push    rax
    mov     rax, 0AH
    push    rax
    mov     rax, rsp
    call    sprint
    pop     rax
    pop     rax
    ret

_reverse:; push byte into stack and pop back.
        .init:
        ;push    rbp
        ;mov     rbp, rsp  

        mov rsi, rdi; mov string into rsi
        xor ax,ax ; ax code 0
        xor rcx, rcx; rcx code 0

        .pushLoop:
        ;lodsb ; load byte from RSI(SIL) into RAX = mov RAX, SI
        
        mov al, sil
        inc rsi
        cmp al, 0xa ; check NULL to pop.
        jng .pop ; if not greater, pop

        push ax ; push the 16b char in RAX to stack

        inc cx; counter +1
        jmp .pushLoop

        .pop: 
        mov rdx, rcx ; rdx = (len of string)
        mov rsi, rdi ; rsi = string

        .popLoop:
        pop ax ; after string push, pop back char to ax.
        stosb ; 
        dec cx  ; decrease length of cx
        test cx,cx ; cx = 1 or 0
        jz .done ; if 0, end prog
        jmp .popLoop ; loop the pop 
        .done:
        mov     rax, rsi ; return convrted to rax 
        
        ;mov     rsp, rbp ; return stack 
        ;pop     rbp      ; pop off rbp
        ret  


