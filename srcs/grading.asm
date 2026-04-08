INCLUDE project.inc

.code

GradeConv PROC
    cmp eax, 90
    jl  gB
    mov bl, 'A'
    mov edx, 4
    ret
gB:
    cmp eax, 80
    jl  gC
    mov bl, 'B'
    mov edx, 3
    ret
gC:
    cmp eax, 70
    jl  gD
    mov bl, 'C'
    mov edx, 2
    ret
gD:
    cmp eax, 60
    jl  gF
    mov bl, 'D'
    mov edx, 1
    ret
gF:
    mov bl, 'F'
    mov edx, 0
    ret
GradeConv ENDP

END