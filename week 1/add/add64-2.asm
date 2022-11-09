; TRAN LONG VU
; ADD TWO NUMBERS:
;
; A:
;   take 2 inputs OF ASCII STRING FORMAT
; B   
; convert ascii to integer USING ATOI FUNCITON
;   Atoi function: reference from asmtutor.com
;          1. iterate through string in RSI
;          2. check if it is letters from 0-9 in ACSII table
;          3. sub 48 to convert to decimal
;          4. ADD value to RAX and mul 10 to represent hudnreds, thousands, ...
;          5. The last byte is unit line, but it got MUL 10 in the loop. Div the UNIT buyte by 10 to correct.
;          6. loop ends when NULL is found in the ASCII string. all bytes are converted.





;    Example: 531. in RSI

;    Iterate 5. Check integer? Yes
;     SUB 48: convert 5 string to 5 int
;    ADD 5 to EAX and MUL 10. -> EAX: 50
;   Iterate 3. Check integer? Yes
;   SUB 48 from ascii 3 to integer 3.
;    ADD 3 to EAX -> EAX = 53. MUL 10 -> EAX = 530.
;   Iterate 1. Check integer? Yes.
;    SUB 48 to integer 1. 
;    ADD to EAX: 531. MUL 10: 5310.
;    Iterate NULL. Check integer? NO. LOOP ENDS.
;    Div 10 ->  RAX = 531. 
;    Function ends at RAX = 531.
;
; C 
; return result with printLF function.
;   print out RAX.
;
;

;






;%include        'functions.asm'
 
SECTION .bss
input1 resb 255
input2 resb 255

SECTION .text
global  _start
 
_start: 
    ; using std input
    ; call input
    push rax
    push rbx
    push rsi
    push rdx 

    mov rax, 0
    mov rbx, 0

    mov rsi, input1 ; input1
    mov rdx, 255
    syscall

    pop rdx
    pop rsi
    pop rbx
    pop rax


    mov rax, input1              ;change input1 to int
    call    atoi       ; returns rax as int

    add     rdx, rax        ; perform  addition 

    push rax
    push rbx ; input2
    push rsi
    push rdx 

    mov rax, 0
    mov rbx, 0

    mov rsi, input2 ; input2
    mov rdx, 255
    syscall
    
    pop rdx
    pop rsi
    pop rbx
    pop rax

    mov rax, input2             ;change input2 to int
    call    atoi     

    add     rdx, rax        ; perform  addition 






    mov     rax, rdx        ; move our data result into eax for printing
    call    iprintLF        ; call  integer printing  linefeed 
    call    quit            ; call our quit function







; default fucntions from asmtutor.com

;------------------------------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
    push    rax             ; preserve eax on the stack to be restored after function runs
    push    rcx             ; preserve ecx on the stack to be restored after function runs
    push    rdx             ; preserve edx on the stack to be restored after function runs
    push    rsi             ; preserve esi on the stack to be restored after function runs
    mov     rcx, 0          ; counter of how many bytes we need to print in the end
 
divideLoop:
    inc     rcx             ; count each byte to print - number of characters
    mov     rdx, 0          ; empty edx
    mov     rsi, 10         ; mov 10 into esi
    idiv    rsi             ; divide eax by esi
    add     rdx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push    rdx             ; push edx (string representation of an intger) onto the stack
    cmp     rax, 0          ; can the integer be divided anymore?
    jnz     divideLoop      ; jump if not zero to the label divideLoop
 
printLoop:
    dec     rcx             ; count down each byte that we put on the stack
    mov     rax, rsp        ; mov the stack pointer into eax for printing
    call    sprint          ; call our string print function
    pop     rax             ; remove last character from the stack to move esp forward
    cmp     rcx, 0          ; have we printed all bytes we pushed onto the stack?
    jnz     printLoop       ; jump is not zero to the label printLoop
 
    pop     rsi             ; restore esi from the value we pushed onto the stack at the start
    pop     rdx             ; restore edx from the value we pushed onto the stack at the start
    pop     rcx             ; restore ecx from the value we pushed onto the stack at the start
    pop     rax             ; restore eax from the value we pushed onto the stack at the start
    ret
 
 
;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call our integer printing function
 
    push    rax             ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     rax, 0Ah        ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    rax             ; push the linefeed onto the stack so we can get the address
    mov     rax, rsp        ; move the address of the current stack pointer into eax for sprint
    call    sprint          ; call our sprint function
    pop     rax             ; remove our linefeed character from the stack
    pop     rax             ; restore the original value of eax before our function was called
    ret
 
 
;------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push    rbx
    mov     rbx, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rbx
    pop     rbx
    ret
 
 
;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push    rdx
    push    rcx
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax ; print content
    mov     rbx, 1
    mov     rax, 1
    syscall
 
    pop     rbx
    pop     rcx
    pop     rdx
    ret
 
 
;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
 
    push    rax
    mov     rax, 0AH
    push    rax
    mov     rax, rsp
    call    sprint
    pop     rax
    pop     rax
    ret

atoi:
    push    rbx             ; preserve ebx on the stack to be restored after function runs
    push    rcx             ; preserve ecx on the stack to be restored after function runs
    push    rdx             ; preserve edx on the stack to be restored after function runs
    push    rsi             ; preserve esi on the stack to be restored after function runs

    mov     rsi, rax        ; move pointer in eax into esi (our number to convert)
    mov     rax, 0          ; initialise eax with decimal value 0
    mov     rcx, 0          ; initialise ecx with decimal value 0
 
.multiplyLoop:
    xor     rbx, rbx        ; resets both lower and uppper bytes of ebx to be 0
    mov     bl, [rsi+rcx]   ; move a single byte into ebx register's lower half
    cmp     bl, 48          ; compare ebx register's lower half value against ascii value 48 (char value 0)
    jl      .finished       ; jump if less than to label finished
    cmp     bl, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
    jg      .finished       ; jump if greater than to label finished
 
    sub     bl, 48          ; convert ebx register's lower half to decimal representation of ascii value
    add     rax, rbx        ; add ebx to our interger value in eax
    mov     rbx, 10         ; move decimal value 10 into ebx
    mul     rbx             ; multiply eax by ebx to get place value
    inc     rcx             ; increment ecx (our counter register)
    jmp     .multiplyLoop   ; continue multiply loop
 
.finished:
    cmp     rcx, 0          ; compare ecx register's value against decimal 0 (our counter register)
    je      .restore        ; jump if equal to 0 (no integer arguments were passed to atoi)
    mov     rbx, 10         ; move decimal value 10 into ebx
    div     rbx             ; divide eax by value in ebx (in this case 10)
 
.restore:
    pop     rsi             ; restore esi from the value we pushed onto the stack at the start
    pop     rdx             ; restore edx from the value we pushed onto the stack at the start
    pop     rcx             ; restore ecx from the value we pushed onto the stack at the start
    pop     rbx             ; restore ebx from the value we pushed onto the stack at the start
    ret


itos:		;input = rax, output string = outputIntStr, output string length = rdi
	mov rbx, 10
	mov rdi, 0
	mov rdx, 0
	pushLoop:
		div rbx
		push rdx
		mov rdx, 0
		inc rdi
		cmp rax, 0
		jne pushLoop
	mov r12, 0
	popLoop:
		pop rbx
		add bl, '0'
		;mov byte[outputIntStr+r12], bl
		inc r12
		cmp r12, rdi	
		jne popLoop
	ret





 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rbx, 0
    mov     rax, 60
    syscall
    ret