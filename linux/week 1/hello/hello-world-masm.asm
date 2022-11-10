
; code run on Windows using MASM32 lirabry and ASCII complier

include \masm32\include\masm32rt.inc ; include library


.data ;  var zone
 message db "Hello world", 0 ; var "Hello world"

.code ; code zone
main:
 invoke StdOut, addr message ; use lib stdoutput message.
 invoke ExitProcess, 0 ; call kernel, exit code 0.
end main














