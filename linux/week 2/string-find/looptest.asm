section .data
s1: db "string one", 0
s2: db "s", 0
not_e: db "non", 13,10
eq: db "equal",10

section .text
global main
main:
	mov rsi, s1     ; esi = &s1 ;string
	mov rdi, s2     ; edi = &s2 ; char
	xor rdx, rdx    ; edx = 0

loop:
	mov al, [rsi + rdx]
	mov bl, [rdi]
	inc rdx
	cmp al, bl      ; compare character with string
	jne not_equal   ; not equal

	cmp al, bl       ; at end?
	je equal        ; end of both strings

   cmp al, 0; null?
   jmp exit

	jmp loop        ; equal so far
not_equal: ; print NE
	
	jmp loop
equal: ; found same string! give a sign
	push rsi
       mov rax, 1           ; write output code 4 for eax
       mov rdi, 1           ; std output code 1
       mov rsi, eq     ; write message in register ecx
       mov rdx, 5  ; legthh of message in reg ecx 32chars
       syscall;
   pop rsi
	
exit:
	mov rax, 0x2000001  ; sys_exit
	; mov rdi, 0
	syscall




;https://github.com/HamzaYousuf7/assembly-language-course