
;BIGSUM
; ADDING 2 20 DIGIT INTEGERS
; ARRAY TYPE NUMBERS
; RIGHT TO LEFT NUM-ARRAY
;
;


%include        'functions.asm'
 
SECTION .bss
input1 resb 255
input2 resb 255
SECTION .data
array1 do 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
array2 do 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

SECTION .text
global  _start


_start: 
    ; using std input
    ; call input
    mov rax, input1
    call sinput

    mov rax, input1
    call atoi ; rax now integer
    mov [input1], rax; integer input

    mov rax, input2
    call sinput

    mov rax, input2
    call atoi ; rax now integer
    mov [input2], rax; integer input

    ;test
    


    ; move to array loop:
    call _bigSum
    ; add sum 20b

    ; memory maipulation


    ; rdx stores result from rax. 

    call    quit            ; call our quit function

_bigSum:
    mov rax, 0
    .done:
        ret