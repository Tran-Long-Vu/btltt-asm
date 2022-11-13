; TRAN LONG VU
; STRING FINDER

; COMPILED WITH NASM + LD LINKER
; RUN ON UBUNTU LINUX.
; NOTE: partially working
;
;
%include "functions.asm"

SECTION .data
msg1        db      'motherstring?: ', 0h      ; message string asking user for input
msg2        db      'Substring?: ', 0h                       ; message string to use after user has entered their name
msg3        db      'found.' , 0h 
SECTION .bss
    bigstring      resb    30
    substring         resb    12
    arr         resb    100
    size        resd    1 ; dword = 32b

    subCount    resd 1      ;size of position array
    position         resb 100

SECTION .text
global  _start
 
_start:
 
    ; message
    mov rax, msg1
    call sprint

    ; call input string
    mov rax , bigstring
    call sinput

    
    
 
    ; message2
    mov rax, msg2
    call sprint
    
    ; call input sub string
    mov rax , substring
    call sinput
    

    call _compareLoop
    ; compare here. 

    

    mov rax, bigstring
    call sprintLF

    call  quit
    _compareLoop:
        .init:
         

        mov rdi, substring
        mov rsi, bigstring
        mov r10,0 ; sub index
        mov r11,0 ; str index
        
        .bigLoop:
            mov bl, byte [rdi+r10]
            mov r14b, byte [rsi+r11]

            cmp r14b, 0xa; check null bigstring
            je .done ; end  
            ;if not, enter subLoop              
            .subLoop:
                cmp bl, 0xa; if sub ends NULL, record
                je .record
                ; if not NULL? compare               

                cmp bl, r14b; if [byte]: sub = big. 
                je .bothNext ; if equal:   
                ; if not equal
                jmp .resetSub
                jmp .bigNext 
            .record:
                ; record pos +count             
                ; .resetSub ; reset Sub
                ; bigNext
                
                mov rax, msg3; test record
                ;call sprintLF 
                
                jmp .resetSub
                jmp .bigNext
                
            .bigNext:
                inc r11
                jmp .bigLoop
                
            .bothNext:
                inc r11
                inc r10
                jmp .bigLoop
                
            .resetSub:
                xor r10, r10; sub[0]
                jmp .bigNext
                
            .done:
            
            ret
                

            

            


    
