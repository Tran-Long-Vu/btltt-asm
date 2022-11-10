; Hello World Program (Calculating string length)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len
; Run with: ./helloworld-len
 
%include "functions.asm"
SECTION .data
msg   db  9
 
SECTION .text
global  _start
 
_start:
 
        ; move the address of our message string into EBX
    mov     rax, msg        ; move the address in EBX into EAX as well (Both now point to the same segment in memory)
    call    iprintLF

 
    mov     rbx, 0
    mov     rax, 60
    syscall