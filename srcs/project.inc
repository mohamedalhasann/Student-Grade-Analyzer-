INCLUDE Irvine32.inc

MAX = 20

; --- procedures implemented in other modules ---
PrintStar PROTO
GradeConv  PROTO    ; input: EAX=grade, output: BL=letter, EDX=points(0..4)
