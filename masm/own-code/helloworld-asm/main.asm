.386
.model flat, stdcall
option casemap: none

include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib

.data?
	buf db 32 dup(?) ; reserve 32 bytes
    msg db 'helloWorld', 0
.code
main PROC

    
    push    offset msg
    call    StdOut
    
    ret
main ENDP
end main