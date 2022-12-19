WriteFile PROTO
ReadFile PROTO
ExitProcess PROTO
GetStdHandle PROTO

.data?
strBuffer   db 22 dup(? )
hIn            dq ?
hOut        dq ?
quadBuffer    dq ?
.data
msg1 db "Enter Echo String: ", 0

.code
main proc
sub     rsp, 28h

mov        rcx, -10					; save output handle = nasm rax code 0
call    GetStdHandle
mov     hIn, rax; save input handle

mov     rcx, -11					; save output handle = nasm rax code 1
call    GetStdHandle
mov     hOut, rax

mov     rcx, [hOut]					; save output handle				= nasm rax code 1
lea     rdx, msg1; string content					= nasm rsi
mov     r8, sizeof msg1; string length						= nasm rdx
lea     r9, quadBuffer				; handle buffer						= nasm rbx code 60 (linux kernel);

;note: windows need both string buffer and numeric buffer.

call    WriteFile

mov     rcx, [hIn]					;save input handle					= nasm rax code 0
lea     rdx, strBuffer				; input content into buffer			= nasm rsi
mov     r8, 22						; input length						= nasm rdx
lea     r9, quadBuffer				; handle buffer						= nasm rbx code 60 (linux kernel)
call    ReadFile

mov     rcx, [hOut]								; save output handle = nasm rax code 1
lea     rdx, strBuffer							; string content = nasm rsi
mov     r8, sizeof strBuffer					; string length = nasm rdx
lea     r9, quadBuffer							; handle buffer = nasm rbx code 60 (linux kernel)

call    WriteFile






main endp
end