;itoa function by longvu.


section .data
   ; string buffer to store results
   a db  64

   
%include "functions.asm"



section .bss
    buffer resb 64
    input resb 64
section .text

global  _start
 
_start:
    
    

    add rax, 99612

    call itoa

    mov rax, buffer
    call sprint
    call quit


; integer to ascii
; number in RAX
; counter in RCX
; divide by 10
; add 48 for string
; 2nd loop: pop + ret





