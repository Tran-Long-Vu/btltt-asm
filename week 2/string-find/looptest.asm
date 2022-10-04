section	.text
   global main        ;must be declared for using gcc
	
main:	                ;tell linker entry point
   mov ecx,10 ; 
   mov eax, '1'
	
l1:
   mov [num], eax ; mov 1 into num value
   mov eax, 4 ; print mode
   mov ebx, 1 ; printmode

   push ecx ; push 10 in stack
	
   mov ecx, num        ; move num 1 into ecx
   mov edx, 1        ; move 1 into edx length
   int 0x80 ; syscall : PRINT THE NUMBER
	
   mov eax, [num] ; eax = 1
   sub eax, '0' ; minsu 0
   inc eax ; +! 
   add eax, '0' ; + 0
   pop ecx ; pop 10 into ecx
   loop l1
	
   mov eax,1             ;system call number (sys_exit)
   int 0x80              ;call kernel
section	.bss
num resb 1


