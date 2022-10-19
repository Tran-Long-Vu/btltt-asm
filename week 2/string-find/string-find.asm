; STRING FINDER

; COMPILED WITH NASM + LD LINKER
; RUN ON UBUNTU LINUX.
;
; INPUT of 2 strings.
; iterate through  both strings. Find length. 
; 
;
;
;
; use such iteration to compare bytes.
; if match, go to next iteration.
; check NULL to end 
; record position + count of times appearance,
; NULL of the long string ends the program
; 
; Example:
; "longcocakaca" & ca
; s1 and s2
; iterate "ca". starts with s2[0]. "c"
; cmp "c" with s1[0]. not match, loop skip.
; until cmp with s1[4]. "c" and "c". Match 
; cmp s2[1] = "a". with s1[5]. s1[curretn + 1]
; cmp "a" with "o". Not match. Skip loop. Back to S2[0]
; till "ca" match "ca". Record count +1 and position: 6.
; Record count +2 and pos: 11.
; check null/end of string
; end loop 
; print out count + loop count

SECTION .data
msg1        db      'Please enter your name: ', 0h      ; message string asking user for input
msg2        db      'Hello, ', 0h                       ; message string to use after user has entered their name
 
SECTION .bss
count resb 10
input:     resb    255                                 ; reserve a 255 byte space in memory for the users input string

SECTION .text
global  _start
 
_start:
 

    mov     rdx, 255        ; number of bytes to read
    mov     rsi, input     ; reserved space to store our input (known as a buffer)

    mov     rbx, 0          ; write to the STDIN file
    mov     rax, 0         ; invoke SYS_READ (kernel opcode 3)
    syscall
 

 
    mov     rax, input     ; move our buffer into eax (Note: input contains a linefeed)
    call    _print          ; call our print function
 
    call    _quit

_input:
    push    rdx
    push    rsi
    push    rbx
    push    rax

    mov     rdx, 255        ; number of bytes to read. predefined
    mov     rsi, rax     ; reserved space to store our input (known as a buffer)

    mov     rbx, 0          ; write to the STDIN file code 0
    mov     rax, 0          ;  SYS_READ (x64 kernel code 0)
    syscall

    pop     rax
    pop     rbx
    pop     rsi
    pop     rdx
    ret

_print: ; mov string into rax and print given string to cmdline(linux)
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
; function to count string length, put in rdx.
slen:
    push    rbx
    mov     rbx, rax
 
nextchar: ; iteration 0ver string 
    cmp     byte [rax], 0
    jz      _finished
    inc     rax
    jmp     nextchar
 
_finished: ; end sub routine
    sub     rax, rbx
    pop     rbx
    ret
 
 
_quit: ; end program
    mov     rbx, 0
    mov     rax, 60
    syscall
    ret