section	.text
   global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point

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
	
   mov	rdx,21	        ;message length
   mov	rsi,sum	        ;message to write
   mov	rdi,1	        ;file descriptor (stdout)
   mov	rax,1	        ;system call number (sys_write)
   syscall	        ;call kernel
	
   mov rax,60
   mov rdi, 0	        ;system call number (sys_exit)
   syscall	        ;call kernel

section	.data
msg db 'The Sum is:',0xa	
len equ $ - msg			
num1 db '12345'
num2 db '12345'
sum db '                    '