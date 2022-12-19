; HelloWorld64 - Tran Long VU
; Already extern kernel32.dll in project.
; external functions kernel call;

; WriteFile PROTO
; ReadFile PROTO
; ExitProcess PROTO
; GetStdHandle PROTO

extrn   GetStdHandle : proc
extrn   ReadFile : proc
extrn   WriteFile : proc
extrn   ExitProcess : proc

.data?

strBuffer   db 22 dup(? ); string buffer = byte
hIn            dq ? ; input handle var when use winapi
hOut        dq ? ;  output handle var when use winapi
quadBuffer    dq ? ; number buffer = quadword

.data
msg db "Hello World", 0Ah
handleOut dq -11
handleIn dq -10

.code; main _code section
main proc										 ; before printing output or whatever, we use std_HANDLE.
												 ; printing function starts here:
												 ; program starts: rax = rdx = r9
		push rcx
		push rax
		push rdx
		push r8
		push r11

			sub     rsp, 28h						   	 ; malloc buffer handle 
			mov     rcx, handleOut						 ; winAPI stdhandle output _code = -11 ; input_code = -10
			call    GetStdHandle						 ; _call Handle from kernel32	

			mov     hOut, rax							 ; handle var 
			mov     rcx, [hOut]							 ; rcx =  handle var = FFFFF(0)
			mov     r9, OFFSET quadBuffer				 ; msg_winAPI handle buffer = r9

			mov     rdx, OFFSET msg						 ; msg content to rdx														 											 
			mov     r8, sizeof msg						 ; msg_length(bytes) = r8

			call    WriteFile							 ; Kernel32/writefile ; writefile returns r9 =0
		pop r11
		pop r8
		pop rdx
		pop rax
		pop rcx

	mov   ecx,0					; exit code 0
	call  [ExitProcess]			; call winAPI

main endp
end
