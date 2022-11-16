section .data
	EXIT_SUCCESS equ 0	;success code
	STDIN equ 0		;standard input
	STDOUT equ 1		;standard output
	SYS_read equ 0		;read system call code
	SYS_write equ 1		;write system call code
	SYS_exit equ 60		;exit system call code
		
	msgInputALength db "Input number of elements in array(1 to 99): "
	msgInputElement1 db "Input element "
	msgInputElement2 db ": "
	msgMaxIs db "Max of array: "
	msgMinIs db "Min of array: "
	NL db 10
	minPos db 0
	maxPos db 0
section .bss
	aLen resb 1
	aLenStr resb 4
	a resd 99
	outputIntStr resb 10
	inputIntStr resb 10
section .text
	global _start
_start:
	mov rsi, msgInputALength
	mov rdx, 44
	call outputStr
	mov rsi, aLenStr
	mov rdx, 4
	call inputStr
	call stoi			;input = [rsi], output = rax
	mov byte[aLen], al ;n
	mov r14, 0
	movzx r15, byte[aLen]
	eleInputAndCompare:
		;output string instruction segment
		mov rsi, msgInputElement1	
		mov rdx, 14
		call outputStr
		mov rax, r14 ;0
		call itos			;itoa not finished ;input = rax, output string = outputIntStr, output string length = rdi
		mov rsi, outputIntStr ; print integer
		mov rdx, rdi
		call outputStr
		mov rsi, msgInputElement2
		mov rdx, 2
		call outputStr
		
		;input string segment and compare min max
		mov rsi, inputIntStr
		mov rdx, 10
		call inputStr
		call stoi			;input = rsi, output = rax
		
		mov dword[a+r14*4], eax 
		
		movzx r13, byte[minPos]
		cmp dword[a+r13*4], eax
		jg setMin
			jmp EIACcontinue1
		setMin:
			mov byte[minPos], r14b
			jmp EIACcontinue1
		EIACcontinue1:
		
		movzx r13, byte[maxPos]
		cmp dword[a+r13*4], eax
		jl setMax
			jmp EIACcontinue2
		setMax:
			mov byte[maxPos], r14b
			jmp EIACcontinue2
		EIACcontinue2:
		
		;iteration segment
		inc r14
		cmp r14, r15
		jne eleInputAndCompare
		
	mov rsi, msgMaxIs
	mov rdx, 14
	call outputStr
	movzx rbx, byte[maxPos] ; move single byte
	movsxd rax, dword[a+rbx*4] ; move single dword
	call itos
	mov rsi, outputIntStr
	mov rdx, rdi
	call outputStr
	call outputNewLine
	
	mov rsi, msgMinIs
	mov rdx, 14
	call outputStr
	movzx rbx, byte[minPos] string
	movsxd rax, dword[a+rbx*4];num
	call itos ;itoa
	mov rsi, outputIntStr
	mov rdx, rdi
	call outputStr
	call outputNewLine
	call exit


outputStr:
	mov rax, SYS_write
	mov rdi, STDOUT
	syscall
	ret

inputStr:
	mov rax, SYS_read
	mov rdi, STDIN
	syscall
	ret	

stoi:			 ;rax = output, rsi = input
	movzx rbx, byte[rsi]
	mov rax, 0
	toNumLoop:
		sub bl, '0'       ;
		add rax, rbx
		inc rsi
		mov bl, byte[rsi]      ; ecx is the pointer, so [ecx] the current char
		cmp bl, 10
		je done
		imul rax, 10
		jmp toNumLoop

done:
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
		mov byte[outputIntStr+r12], bl
		inc r12
		cmp r12, rdi	
		jne popLoop
	ret
outputNewLine:
	mov rsi, NL	
	mov rdx, 1
	call outputStr	
	ret

exit:
	mov rax, SYS_exit
	mov rdi, EXIT_SUCCESS
	syscall