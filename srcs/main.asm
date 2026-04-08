; student name : mohammad jamal sabbah ,, ID Number : 202320443
; student name : mohammad samer alhasan ,, ID Number : 202311178

INCLUDE project.inc

.data
hdr1 BYTE "===========================================",0
hdr2 BYTE " STUDENT GRADE ANALYZER SYSTEM",0
hdr3 BYTE "===========================================",0

pName   BYTE "Enter student name: ",0
pNum    BYTE "Enter number of courses (1-20): ",0
pCode   BYTE "Course code: ",0
pGrade  BYTE "Numeric grade (0-100): ",0
pCredit BYTE "Credit hours (1-4): ",0
pErr    BYTE "Invalid input. Please try again.",0

oStudent BYTE "Student: ",0
oCourses BYTE "Courses: ",0
oCredits BYTE "Total Credits: ",0
oGPA     BYTE "GPA: ",0

tHead BYTE "Course  Grade  Credits  Letter  Points",0
tLine BYTE "------  -----  -------  ------  ------",0

sHead BYTE "STATISTICAL SUMMARY:",0
sHigh BYTE "Highest Grade: ",0
sLow  BYTE "Lowest Grade: ",0
sAvg  BYTE "Average Grade: ",0
sFail BYTE "Failing Courses: ",0

dHead BYTE "GRADE DISTRIBUTION:",0
distA BYTE "A: ",0
distB BYTE "B: ",0
distC BYTE "C: ",0
distD BYTE "D: ",0
distF BYTE "F: ",0

aLabel BYTE "ACADEMIC STANDING: ",0
aEx BYTE "Excellent",0
aGood BYTE "Good Standing",0
aWarn BYTE "Academic Warning",0
aProb BYTE "Academic Probation",0

sep BYTE "-------------------------------------------",0
spc BYTE "  ",0

bufName BYTE 40 DUP(0)
bufTmp  BYTE 10 DUP(0)

arrCode   BYTE  MAX*10 DUP(0)
arrGrade  DWORD MAX DUP(0)
arrCredit DWORD MAX DUP(0)
arrLetter BYTE  MAX DUP(0)
arrPoint  DWORD MAX DUP(0)

cntCourse DWORD ?
idx       DWORD ?

sumCredit DWORD 0
sumPoint  DWORD 0
sumMark   DWORD 0
hiMark    DWORD 0
loMark    DWORD 100
failCnt   DWORD 0

cntA DWORD 0
cntB DWORD 0
cntC DWORD 0
cntD DWORD 0
cntF DWORD 0
gpaVal DWORD ?

.code

main PROC

    mov edx, OFFSET pName
    call WriteString
    mov edx, OFFSET bufName
    mov ecx, 40
    call ReadString
    mov BYTE PTR [bufTmp+eax], 0

getCount:
    mov edx, OFFSET pNum
    call WriteString
    call ReadInt
    cmp eax, 1
    jl  badCount
    cmp eax, 20
    jg  badCount
    mov cntCourse, eax
    jmp readLoop
badCount:
    mov edx, OFFSET pErr
    call WriteString
    call Crlf
    jmp getCount

readLoop:
    mov idx, 0

inputLoop:
    mov eax, idx
    cmp eax, cntCourse
    jge calcPart

    call Crlf
    mov eax, idx
    inc eax
    call WriteDec
    mov al, ':'
    call WriteChar
    call Crlf

    mov edx, OFFSET pCode
    call WriteString
    mov edx, OFFSET bufTmp
    mov ecx, 10
    call ReadString

    mov esi, OFFSET arrCode
    mov eax, idx
    imul eax, 10
    add esi, eax
    mov edi, OFFSET bufTmp
    mov ecx, 10
    rep movsb

getMark:
    mov edx, OFFSET pGrade
    call WriteString
    call ReadInt
    cmp eax, 0
    jl  badMark
    cmp eax, 100
    jg  badMark
    mov esi, OFFSET arrGrade
    mov ebx, idx
    shl ebx, 2
    mov [esi+ebx], eax
    jmp getHour
badMark:
    mov edx, OFFSET pErr
    call WriteString
    call Crlf
    jmp getMark

getHour:
    mov edx, OFFSET pCredit
    call WriteString
    call ReadInt
    cmp eax, 1
    jl  badHour
    cmp eax, 4
    jg  badHour
    mov esi, OFFSET arrCredit
    mov ebx, idx
    shl ebx, 2
    mov [esi+ebx], eax

    inc idx
    jmp inputLoop
badHour:
    mov edx, OFFSET pErr
    call WriteString
    call Crlf
    jmp getHour

calcPart:
    mov idx, 0

calcLoop:
    mov eax, idx
    cmp eax, cntCourse
    jge outPart

    mov esi, OFFSET arrGrade
    mov ebx, idx
    shl ebx, 2
    mov eax, [esi+ebx]

    add sumMark, eax
    cmp eax, hiMark
    jle skipHi
    mov hiMark, eax
skipHi:
    cmp eax, loMark
    jge skipLo
    mov loMark, eax
skipLo:
    cmp eax, 60
    jge okPass
    inc failCnt
okPass:

    call GradeConv
    mov esi, OFFSET arrLetter
    add esi, idx
    mov [esi], bl

    cmp bl, 'A'
    jne cB
    inc cntA
    jmp distOK
cB: cmp bl, 'B'
    jne cC
    inc cntB
    jmp distOK
cC: cmp bl, 'C'
    jne cD
    inc cntC
    jmp distOK
cD: cmp bl, 'D'
    jne cF
    inc cntD
    jmp distOK
cF: inc cntF
distOK:

    mov esi, OFFSET arrCredit
    mov ebx, idx
    shl ebx, 2
    mov ecx, [esi+ebx]
    add sumCredit, ecx
    imul edx, ecx
    mov esi, OFFSET arrPoint
    mov [esi+ebx], edx
    add sumPoint, edx

    inc idx
    jmp calcLoop

outPart:
    ; (keep the rest of your output code exactly as in the original file)
    ; You can paste the remaining section here unchanged.

    exit
main ENDP

END main