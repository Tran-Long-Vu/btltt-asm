


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
; int slen(String message) from RAX, output RAX
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
    push    rsi
    push    rbx
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax ; print content
    mov     rbx, 1
    mov     rax, 1
    push r11
    syscall
    pop r11
    pop     rbx
    pop     rsi
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

sinput:
    push rdx
    push rsi
    push rbx
    push rax

    mov     rbx, 0 ; readmode mother string
    mov     rsi, rax

    mov     rdx, 102
    mov     rax, 0
    syscall
    
    pop rax
    pop rbx
    pop rsi
    pop rdx
    ret
 

printArray:  ; print n elements of array arr
    push    rbp
    mov     rbp, rsp
    sub     rsp, 0x10          ; align stack to call other functions
    mov     ecx, esi; ecx holds the esi array from outside. ECX = array
    mov     [rbp - 8], rdi
        
    .iter:
    mov     rdi, [rbp - 8]
    mov     di, [rdi]       ; byte of array; integer
    and     edi, 0xff       ; get (byte) *[arr] to edi ; pointer position[] of array.

    ;call    iprint            ; print each element in ascii. 
    ; 
    mov     rdi, [rbp - 8]
    inc     di  ; inc byte pos
    mov     [rbp - 8], rdi 
    mov     [rbp - 0xc], ecx ; counter malloc
    mov     rdi, 1
    movzx   rdx, ax
    mov     rax, rdx
    call    iprint ; print 1 byte 
    mov     ecx, [rbp - 0xc] ; de-malloc. 

    dec     ecx ; size - 1
    test    ecx, ecx; check end of array
    jnz     .iter
    
    mov     rsp, rbp ; return memory
    pop     rbp
    ret    


fastPrint: ; rax
    push    rdx
    push    rsi
    push    rbx
    push    rax
    
 
    mov     rdx, 10
    
 
    mov     rsi, rax ; print content
    mov     rdi, 1
    mov     rax, 1
    syscall

    pop     rax
    pop     rbx
    pop     rsi
    pop     rdx

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
		mov byte[buffer+r12], bl
		inc r12
		cmp r12, rdi	
		jne popLoop
	ret

itoa:
    .init:
    push r15
    push rcx
    push rdx
    push rsi
    push rax
    push rbx
    mov qword [buffer],0
    mov r15, 0

    mov rcx, 0 ; counter
    mov     rdx, 0          ; empty edx
    mov     rsi, 10         ; mov 10 into esi
    
    .divideLoop:
        inc     rcx             ; count each byte to print - number of characters
        div rsi ; divide rax by 10
        push rdx ; push remainder
        mov rdx, 0 ; reset
        cmp     rax, 0          ; can the integer be divided anymore?
        jnz     .divideLoop      ; jump if not zero to the label divideLoop

    .popLoop:
        pop rbx ;return from stack
        add bl, '0'; change byte to string
        mov byte [buffer+r15], bl ; move char to buffer

        inc r15
        cmp rcx,r15
        jne .popLoop
        jmp .restore
    .restore:   
        
        pop rbx
        pop rax
        pop rsi
        pop rdx
        pop rcx
        pop r15    
        ret


;------------------------------------------
; void exit()

; Exit program and restore resources
quit:
    mov     rbx, 0
    mov     rax, 60
    syscall
    ret
