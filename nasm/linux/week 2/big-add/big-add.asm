
;BIGSUM
; ADDING 2 20 DIGIT INTEGERS
; ARRAY TYPE NUMBERS
; RIGHT TO LEFT NUM-ARRAY
;
;
;

;

%include        'functions.asm'
 
SECTION .bss
input1 resb 255
input2 resb 255
buffer resb 64
len_a db 64
len_b db 64

SECTION .data
; the array i8s the string itself

carry db 0

SECTION .text
global  _start


_start: 
    ; using std input
    ; call input
    mov rax, input1
    call sinput

    mov rax, input1 ;
    call slen ; length now in rax
    mov len_a, rax

    ;mov rax, input1
    ;call atoi ; rax now integer
    ;mov [input1], rax; integer input

    mov rax, input2
    call sinput

    mov rax, input2 ;
    call slen ; length now in rax
    mov len_b, rax
 
    ;mov rax, input2
    ;call atoi ; rax now integer
    ;mov [input2], rax; integer input

    ;test
    


    ; move to array loop:
    call _bigSum
    ; add sum 20b

    ; bigSum returns sum in integer
    ; call itoa

    ; mov rax, sum
    ; call sprint
    call    quit            ; call our quit function

_bigSum: ;(num1, num2) ; retturns: SUM in array
    .init:
    ; notes:
    ; r9 = len_a
    ; r10 = len_b
    ; r11 = x
    ; r12 = y
    ; r13 = sum (might need to push pop loop)
    ; r14 = carry

    ;
        ; carry = 0
        mov rax, 0
        ; len of num a
        ; len of num b
    .bigLoop:
        ; cmp len-a,0
        ;cmp len-b, 0
        ; if both not 0, loop all
        ;if meet zero, done
        jz .done
        jmp .loopa
    .loopa: 
        ; cmp len-a > 0
        ; jg loopa ; 
        ; if = len-a = 0; (end of string a)
        ; jmp loopb x = 0
    .loopa2:
        ; call atoi  byte string a

        ; mov al, byte str [len_a - 1]; 
        ; call atoi ; byte al now int
        ; mov x, al ; return single byte in var x
        ; dec len-a 
        ; jmp loopb

    .loopb:
        ; cmp len-b > 0
        ; jg loopb2
        ; jmp  addition ; if end? y = 0
    .loopb2:
        ; call atoi  byte string b

        ; mov al, byte str [len_b - 1]; 
        ; call atoi ; byte al now int
        ; mov y, al ; return single byte in var x
        ; dec len-b
        ; jmp addition


    .addition:
        ; var sum: rxx

        ; add x,y 
        ; add x, carry

        ; save byte [sum -1] in rxx as result
        
        ; record max sum in case.
        ; to print sum need legnth; based on a/b

    .carry:
        ;cmp sum, 10
        ;jge carry2 ; save carry + -10 in sum
        ;no?
        ; carry = 0
    .carry2;
        ; sum: rxx ;carry = 1
        ; sub sum, 10
        ; jmp .bigLoop


    .done:
        ret