include \masm32\include\masm32rt.inc
.data
Hello db "Hello World",0
.Code
start:
    invoke StdOut, addr Hello
    invoke ExitProcess,0
end start

