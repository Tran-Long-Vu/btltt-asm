; FINBONACCI - ASSEMBLY 
; TRAN LONG VU 
                        ;# Program to display the Fibonacci sequence up to n-th term;;
                        ;
                        ;nterms = int(input("How many terms? "));
                        ;
                        ;# first two terms
                        ;n1, n2 = 0, 1
                        ;count = 0

                        ;# check if the number of terms is valid
                        ;if nterms <= 0:
                        ;   print("Please enter a positive integer")
                        ;# if there is only one term, return n1
                        ;elif nterms == 1:
                        ;   print("Fibonacci sequence upto",nterms,":")
                        ;   print(n1)
                        ;# generate fibonacci sequence
                        ;else:
                        ;   print("Fibonacci sequence:")
                        ;  while count < nterms:
                        ;      print(n1)
                        ;      nth = n1 + n2
                        ;      # update values
                        ;      n1 = n2
                        ;      n2 = nth
                        ;      count += 1
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



  

section .bss
    n resb 4


section .text
global  _start
 
_start:
    
        mov rax, msg
        call sprintLF

        mov rax, n ; string
        call sinput

        

        mov rax, n
        call atoi ; change n to integer(rdi)
        add r13, rax ; n = r13

        

        call _fibonacciCalc

        call _quit

_fibonacciCalc:
            .init:
            mov r9, 0 ; c
            mov r10, 0 ; first
            mov r14, 1 ; second
            mov r12, 0 ; next
            .addtest:
            push rax
            push rbx
            mov rax, 13
            mov rbx, 8
            add rax,rbx
            pop rbx
            pop rax
            .loop1:
            cmp r9, r13
            je .done ; check end of loop
            cmp r9 , 1
            jg .loop2
            mov r12, r9 ; next = c
                .loop2:
                    add r10, r14
                    mov r12, r10 ; next = first + second
                    mov r10, r14 ; first = second
                    mov r14, r12 ; second = next

            ; change int to string 
            mov rax, r12
            call itoa; NOTE: RESEARCH MORE ON ITOA

            ; print (next)


            





            inc r9
            jmp .loop1
            .done:
                ret
            
        
_quit:
    mov rax, 60
    mov rbx, 0
    syscall 








