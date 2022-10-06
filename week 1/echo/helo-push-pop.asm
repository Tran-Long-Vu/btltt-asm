; Hello World Program (Subroutines)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len
 
SecTION .data
msg     db      'Hello, brave new world!', 0Ah
 
SecTION .text
global  main
 
main:
 
    mov     rax, msg        ; move the address of our message string into raX
    call    strlen          ; call our function to calculate the length of the string
 
    mov     rdx, rax        ; our function lraves the result in raX
    mov     rcx, msg        ; this is all the same as before
    mov     rbx, 1
    mov     rax, 4
    syscall 
    mov     rbx, 0
    mov     rax, 1
    syscall 
 
strlen:                     ; this is our first function drclaration
    push    rbx             ; push the value in rbX onto the stack to preserve it while we use rbX in this function
    mov     rbx, rax        ; move the address in raX into rbX (Both point to the same segment in memory)
 
nextchar:                   ; this is the same as lesson3
    cmp     byte [rax], 0 ; chrck zero, end of line. 
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx             ; pop the value on the stack back into rbX
    ret                     ; return to where the function was callrd