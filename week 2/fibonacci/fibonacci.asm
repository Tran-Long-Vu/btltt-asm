; FINBONACCI - ASSEMBLY 
; TRAN LONG VU 

        ;#include<stdio.h> 

        ;int main()
        ;{
        ;   int n, first = 0, second = 1, next, c;
        ;
        ;   printf("Enter the number of terms\n");
        ;   scanf("%d",&n);
        ;
        ;   printf("First %d terms of Fibonacci series are :-\n",n);
        ;
        ;   for ( c = 0 ; c < n ; c++ )
        ;   {
        ;      if ( c <= 1 )
        ;         next = c;
        ;      else
        ;      {
        ;         next = first + second;
        ;         first = second;
        ;         second = next;
        ;      }
        ;      printf("%d\n",next);
        ;   }
        ;return 0;
        ;}
; 
; 
;
;
;
;
;
;
;
;
%include "functions.asm"

section .data

msg db "enter no. of fibonacci"
msg2 db "test" , 0Ah

first db 0
second db 1
next db 0
c db 0
section .bss
n resb 4


section .text
global  _start
 
_start:
    mov rax, msg
    call sprintLF
    

    mov rax, n ; string
    call sinput
    call atoi

        _fibonacciLoop:
        mov r10, c
        mov r11, n
        ;cmp c, 1
        ;jnge

        inc byte [c]
        cmp r10, r11 ; if equal, end
        jz _quit

        











_quit:
    mov rax, 60
    mov rbx, 0
    syscall







