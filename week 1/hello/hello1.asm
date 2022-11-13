; Hello World Program - asmtutor.com
; Compile with: nasm -f elf helloworld.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld.o -o helloworld
; Run with: ./helloworld
 
SECTION .data
msg     db      'Hello World!', 0Ah
 
SECTION .text
global  main
 
main:
 
    mov     rdx, 13
    mov     rsi, msg
    mov     rbx, 1
    mov     rax, 4
    syscall
 
    mov     rbx, 0      ; return 0 status on exit - 'No Errors'
    mov     rax, 1      ; invoke SYS_EXIT (kernel opcode 1)
    syscall