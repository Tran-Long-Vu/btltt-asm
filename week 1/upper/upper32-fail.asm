section .text
GLOBAL _start

_start:
        mov ecx, string
        mov edx, length
        call toUpper
        call print

        mov eax, 1
        mov ebx, 0 
        int 80h

;String in ecx and length in edx?
;-------------------------
toUpper:
        mov eax,ecx
        cmp al,0x0 ;check it's not the null terminating character?
        je done
        cmp al,'a'
        jb next_please
        cmp al,'z'
        ja next_please
        sub cl,0x20
        ret
next_please:
        inc al
        jmp toUpper
done:   int 21h ; just leave toUpper (not working)
print:
        mov ebx, 1
        mov eax, 4
        int 80h
        ret
section .data
string db "h4ppy c0d1ng", 10
length equ $-string