; adder calc 
; TRAN LONG VU

%include        'functions.asm'
 
SECTION .bss
input1resb 255
input2 resb 255

SECTION .text
global  _start
 
_start: 
    ; using std input
    ; call input
    
    mov rax, 0
    mov rbx, 0

    mov rsi, input1 ; input1
    mov rdx, 255
    syscall

    mov rax, input1              ;cahnge input1 to int
    call    atoi       
    add     rdx, rax        ; perform our addition logic

    mov rax, 0
    mov rbx, 0

    mov rsi, input2
    mov rdx, 255
    syscall

    mov rax, input2             ;cahnge input1 to int
    call    atoi      
    add     rdx, rax        ; perform our addition logic






    mov     rax, rdx        ; move our data result into eax for printing
    call    iprintLF        ; call our integer printing with linefeed function
    call    quit            ; call our quit function