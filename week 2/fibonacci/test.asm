;itoa function by longvu.


section .data
   ; string buffer to store results
   a db  '299'

   
%include "functions.asm"


section .bss
    
section .text
global  _start
 
_start:
    mov rax, a
    call sprintLF
 
    call quit


; integer to ascii
; number in RAX
; counter in RCX
; divide by 10
; add 48 for string
; 2nd loop: pop + ret


itoa:
    .init:
    push rax
    push rcx
    push rdx
    push rsi
    
    mov rcx, 0 ; counter
    mov     dx, 0          ; empty edx
    mov     rsi, 10         ; mov 10 into esi
    
    .divideLoop:
        inc     rcx             ; count each byte to print - number of characters
        div rsi ; divide rax by 10
        push rdx ; push remainder
        mov rdx, 0 ; reset
        cmp     rax, 0          ; can the integer be divided anymore?
        jnz     .divideLoop      ; jump if not zero to the label divideLoop

    .popLoop:
        pop rbx ;return from stack
        add bl, '0'; change byte to string
        mov byte [buffer], bl ; move char to buffer

        dec rcx ; counter loop
        cmp rcx, 0          ; compare ecx register's value against decimal 0 (our counter register)
        je .restore ; jump if equal to 0 (no integer arguments were passed to atoi)
        jmp .popLoop






