
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
buffer resb 64

SECTION .data

array1 dq 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
array2 dq 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
carry db 0

SECTION .text
global  _start


_start: 
    ; using std input
    ; call input
    mov rax, input1
    call sinput

    mov rax, input1
    ;call atoi ; rax now integer
    ;mov [input1], rax; integer input

    mov rax, input2
    call sinput

    mov rax, input2
    ;call atoi ; rax now integer
    ;mov [input2], rax; integer input

    ;test
    


    ; move to array loop:
    call _bigSum
    ; add sum 20b
    call    quit            ; call our quit function

_bigSum: ;(num1, num2) ; retturns: SUM in array
    .init:
        ;carry = 0
        mov rax, 0
        ; len of num a
        ; len of num b
    .bigLoop:
        ; cmp len-a,0
        ;cmp len-b, 0
        ;if meet zero, done
        jz .done
        jmp .loopa
    .loopa: ; call atoi in string a
        ; sub byte rxx, str [len_a - 1]
        ; call atoi

        ; return single byte in var x

        ; dec len-a 
        ; cmp len-a > 0
        ; jg loopa ; if = 0 jmp b

        ; jmp diffenrent b

    .loopb:; call atoi in string b
        ; call atoi in string b
        ; sub byte rxx, str [len_b - 1]
        ; call atoi

        ; return single byte in var y

        ; dec len-b
        ; cmp len-b > 0
        ; jg to addition
        ; if = 0 keep jumping

        ; add single byte

    .addition:
        ; var sum: rxx

        ; add x,y 
        ; add x, carry

        ; save byte [sum] in rxx as result

    .carry:
        ;cmp sum, 10
        ;jge carry2 ; save carry + -10 in sum
        ;no?
        ; carry = 0
    .carry2;
        ; sum: rxx ;carry = 1
        ; sub sum, 10
        ; jmp 


    .done:
        ret