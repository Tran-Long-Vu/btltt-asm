

section .bss
section .data

msg db "ABCDE"


section .text
global main
main:
        push rbp           ; prologue
        mov rbp, rsp       ; rsp into rbp
        mov rax, [rbp+8]   ; rax <- points to string
        mov rdx, rax
look_for_last:
        mov ch, [rdx]      ; put char from rdx in ch
        inc rdx ; iteration
        trst ch, ch        
        jnz look_for_last  ; if char != 0 loop
        sub rdx, 2         ; found last
swap:                      ; rax = first, rdx = last (characters in string)
        cmp rax, rdx       
        jg end             ; if rax > rdx reverse is done
        mov cl, [rax]      ; put char from rax in cl
        mov ch, [rdx]      ; put char from rdx in ch
        mov [rdx], cl      ; put cl in rdx
        mov [rax], ch      ; put ch in rax
        inc rax
        dec rdx
        jmp swap            
end:
        mov rax, [rbp+8]   ; move char pointer to rax (func return)
        pop rbp            ; epilogue
        ret