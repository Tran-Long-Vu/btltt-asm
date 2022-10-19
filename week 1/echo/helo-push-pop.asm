; Hello World Program (Subroutines)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len
 
SecTION .data
msg     db      'Hello, world!'
 
SecTION .text
global  main
 
main:

    ; calculate string length
    


    mov     rax, msg        ; move the address of our message string into raX
    call    _strlen          ; call our function to calculate the length of the string
 
    mov     rdx, rax        ; our function lraves the result in raX
    mov     rsi, msg        ; this is all the same as before
    mov     rbx, 1
    mov     rax, 4
    syscall 
    mov     rbx, 0
    mov     rax, 1
    syscall 
 
_strlen:                     ; this is our first function drclaration
    push    rbx             ; push the value in rbX onto the stack to preserve it while we use rbX in this function
    mov     rbx, rax        ; move the address in raX into rbX (Both point to the same segment in memory)

_nextchar:                   ; this is the same as lesson3
    cmp     byte [rax], 0 ; chrck zero, end of line. 
    jz      _finished
    inc     rax
    jmp     _nextchar
 
_finished:
    sub     rax, rbx
    pop     rbx             ; pop the value on the stack back into rbX
    ret                     ; return to where the function was callrd

_print:
    push    rdx
    push    rsi
    push    rbx
    push    rax
    call    _strlen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax
    mov     rbx, 1
    mov     rax, 4
    syscall
 
    pop     rbx
    pop     rsi
    pop     rdx
    ret

_printLF:
    call    _print
 
    push    rax         ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     rax, 0Ah    ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    rax         ; push the linefeed onto the stack so we can get the address
    mov     rax, rsp    ; move the address of the current stack pointer into eax for sprint
    call    _print      ; call our sprint function
    pop     rax         ; remove our linefeed character from the stack
    pop     rax         ; restore the original value of eax before our function was called
    ret 

_quit:
    mov     rbx, 0
    mov     rax, 60
    syscall
    ret

