;build commands:
;nasm -f elf64 -o findSubStr.o findSubStr_linux.asm 
;f
section .data
	TEN equ 10
	STR_S_MAXLEN equ 100
	STR_C_MAXLEN equ 10
section .bss
	strS resb 102
	strC resb 12
	subStrCount resb 3
	subStrPos resb 102
	StringBuffer resb 4

section .text
	global _start
_start:
	mov rsi, strS
	mov rdx, STR_S_MAXLEN + 2	;input two more bits for newline and NULL char
	call inputStr			;input string S

	mov rsi, strC
	mov rdx, STR_S_MAXLEN + 2	;input two more bits for newline and NULL char
	call inputStr			;input string C
	
	mov rdi, 0
	mov rsi, strS
	call findStrLen
	mov r12, rdi

	mov rdi, 0
	mov rsi, strC
	call findStrLen
	mov r13, rdi
	
	mov rdi, strS
	mov rsi, strC
	call findSubStr
	
	mov r14, 0
	mov al, byte [subStrCount]
	mov rsi, StringBuffer
	call numToString
	mov byte[rsi], 10		;insert "\n" at the end of strings
	call outputStr

	mov r15, 0	; counter for loop instruction
	printSubStrPos:
		mov r14, 0
		mov al, byte [subStrPos+r15]
		mov rsi, StringBuffer
		call numToString
		mov byte[rsi], 0x20		;insert " " at the end of strings
		call outputStr
		inc r15
		cmp r15b, byte[subStrCount]
		jne printSubStrPos
	mov rax, 60
	mov rdi, 0
	syscall

inputStr:
	mov rax, 0
	mov rdi, 0
	syscall
	ret	

findStrLen:
	mov bl, byte [rsi+rdi]
	cmp bl, 10
	je done
	inc rdi
	jmp findStrLen

done:
	ret


findSubStr:
	mov rbx, 0
	mov r10, 0		;S String Iterator
	mov r11, 0		;C String Iterator
	mov byte[subStrCount], 0
	StrSIterate:
		mov bl, byte [rdi+r10] ;big
		mov r14b, byte [rsi+r11] ;sub
		cmp bl, r14b
		jne next
		StrCIterate:
			inc r11; sub++
			cmp r11, r13	
			je saveSubStrCountAndPos; record
			mov r15, r10 ; big index
			add r15, r11 ; sub index

			mov bl, byte [rdi+r15] ; cmp 2
			mov r14b, byte [rsi+r11]

			cmp bl, r14b
			je StrCIterate ; if euqal
			jmp next
			saveSubStrCountAndPos:
				mov bl, byte[subStrCount]
				mov byte[subStrPos+rbx], r10b
				inc byte[subStrCount]
				mov r11, 0
				jmp next
			
		next:
			inc r10; big+
			cmp r10, r12
			je done
			jmp StrSIterate

numToString:
	cqo
	mov r10, 10
	div r10
	push rdx
	inc r14
	cmp rax, 0
	jne numToString
	mov rdx, r14		;save String length
	inc rdx
	stackToString:
		pop rbx
		add bl, 0x30;48
		mov byte[rsi], bl
		inc rsi
		dec r14
		cmp r14, 0
		je done
		jmp stackToString

outputStr:
	mov rax, 1
	mov rdi, 1
	mov rsi, StringBuffer
	syscall
	ret