INCLUDE project.inc

.code

PrintStar PROC
    push ecx
    mov  ecx, eax
    cmp  ecx, 0
    je   psEnd
psLoop:
    mov  al, '*'
    call WriteChar
    loop psLoop
psEnd:
    pop  ecx
    ret
PrintStar ENDP

END