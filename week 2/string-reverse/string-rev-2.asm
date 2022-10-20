

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


