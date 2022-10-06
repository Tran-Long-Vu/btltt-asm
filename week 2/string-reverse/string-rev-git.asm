; ------------------------
; reverse.asm - Reverse a string without copying it
; Max length of string is 64 bytes
; This is for an x86_64 Linux System
; Assemble with:
;     yasm -f elf64 reverse.asm
; Link with:
;     ld -o reverse reverse.o
; Note: Also perfectly capable of swapping yasm for nasm without changing code
; ------------------------
[bits 64]

section .data
msg times 64 db 0 ; distenict byte 64times as zero 0
max equ 64

section .text
global main

main:
; Read
mov rdx,max
mov rsi,msg
mov rdi,0
mov rax,0
syscall

mov rcx,rax     ; Copy the string for later
mov rdi,msg     ; Set RDI and RSI to point at message
mov rsi,msg     ; proc: set RDI at last
                ; RSI at fist letter

add rdi,rax     ; RDI should point at last character in message
dec rdi         ;
shr rax,1       ; Divide length by 2

.loop           ; Begin loop:
mov bl,[rsi]    ; Swap the characters using 8 bit registers
mov dl,[rdi]    ; mov first char to rbx
mov [rsi],dl    ; mov last char to rdx
mov [rdi],bl   ; mov last char in rsi
                ; mov first char in rdi
                ; swapped.

inc rsi         ; Increment rsi (which is a pointer)
dec rdi         ; Decrement rdi (also a pointer)
dec rax         ; Decrement our counter of chars. loop 1/2time the length
jnz .loop       ; If our counter isn't zero, keep looping

; Write
.write
mov rdx,rcx ; nbytes
mov rsi,msg ; *msg
mov rdi,1 ; stream
mov rax,1 ; syscall
syscall

; Exit
mov rdi,0 ; exit code
mov rax,60 ; syscall
syscall