; LONG VU TRAN
; ASCII TO INTEGER ATOI addition



; steps: 
; 1. input two numbers.
; 2. add. COnvert ACSII TO INT
; 3. output results.
;
; 2: add
; -iterate through last number (don vi) 
; start loop
; - add num 1 last to num 2 last. 
;   
; - if carry, add 1 bit to carry reg.
; - if not carry, skip to next unit num
; loop ends: the end of number string
;
; - 
; -  
; iteration e


section	.data
msg db 'The Sum is:',0xa	
len equ $ - msg			

      

section .bss

num1 resb 1
num2 resb 1
sum resb 1
global _start


section	.text


_start:	                ;tell linker entry point
; input 1
        mov	rax,0       ;system call number (sys_write)
        mov	rdi,0	        ;file descriptor (stdout)
        mov	rdx,1	        ;message length
        mov	rsi,num1	        ;message to write
        syscall	        ;call kernel
    ;input 2
        mov	rax,0       ;system call number (sys_write)
        mov	rdi,0	        ;file descriptor (stdout)
        mov	rdx,1	        ;message length
        mov	rsi,num2	        ;message to write
        syscall	        ;call kernel
   mov     rsi, 19       ;pointing to the rightmost digit ; pointer
   mov     rcx, 20       ;num of digits ; total 5x
   clc
    add_loop:  
    mov 	al, [num1 + rsi] ; move into al: '12345' + 4 pointer. 'number 5.'
    adc 	al, [num2 + rsi] ; extra 16b memory for 8b addition. ; Al = Al + 0 + CF.
    
        ; adjust to ascii numbers 
    sub al, 0x40 ; change to deci
    pushf ; push flag in stacc
    or 	al, 30h ; check zero to pop.
    popf
        
    mov	[sum + rsi], al ; error here
    dec	rsi
    loop	add_loop



        mov	rax,1        ;system call number (sys_write)
        mov	rdi,1	        ;file descriptor (stdout)
        mov	rdx,len	        ;message length
        mov	rsi,msg	        ;message to write
        syscall	        ;call kernel
        
        mov	rdx,1	        ;message length
        mov	rsi,sum	        ;message to write
        mov	rdi,1	        ;file descriptor (stdout)
        mov	rax,1	        ;system call number (sys_write)
        syscall	        ;call kernel
        
        mov rax,60
        mov rdi, 0	        ;system call number (sys_exit)
        syscall	        ;call kernel
    
    




