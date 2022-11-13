SECTION .data
msg     db      'Hello, brave new world!', 0Ah
 
SECTION .text
global  _start
 
_start:
 
    mov     rax, msg        ; move the address of our message string into EAX
    call    strlen          ; call our function to calculate the length of the string
 
    mov     rdx, rax        ; our function leaves the result in EAX
    mov     rsi, msg        ; NOTE rsi fucntion in x64
    mov     rbx, 1
    mov     rax, 1          ; NOTE code 1,1
    syscall
 
    mov     rbx, 0
    mov     rax, 60
    syscall
 
strlen:                     ; this is our first function declaration
    push    rbx             ; push the value in EBX onto the stack to preserve it while we use EBX in this function
    mov     rbx, rax        ; move the address in EAX into EBX (Both point to the same segment in memory)
 
nextchar:                   ; this is the same as lesson3
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx             ; pop the value on the stack back into EBX
    ret                     ; return to where the function was called