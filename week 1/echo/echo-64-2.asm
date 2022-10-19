; ECHO 64 BIT
; COMPILED WITH NASM + LD LINKER
; RUN ON UBUNTU LINUX.

;


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