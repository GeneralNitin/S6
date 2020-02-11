ASSUME CS:CODE, DS:DATA
display MACRO str
    MOV AH, 09H
    LEA DX, str
    INT 21H
ENDM

DATA SEGMENT
    MSG1 DB "ENTER YOUR STRING : $"
    MSG2 DB "CONVERTED STRING IS : $"
    STR1 DB 20 DUP('$')
    LINE DB 10, 13, '$'
DATA ENDS

CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    display MSG1
    MOV AH, 0AH
    LEA DX, STR1
    INT 21H
    display LINE
    MOV CH, 00
    MOV CL, BYTE PTR[STR1+1]
    LEA SI, STR1+2
    L1: MOV AH, BYTE PTR[SI]
        CMP AH, 'A'
        JL L4
        CMP AH, 'Z'
        JG L2
        ADD BYTE PTR[SI], 32
        JMP L3
    L2: CMP AH, 'a'
        JL L4
        CMP AH, 'z'
        JG L4
        SUB BYTE PTR[SI], 32
    L3: INC SI
        LOOP L1
        display MSG2
        display STR1+2
    L4: MOV AH, 4CH
        INT 21H
CODE ENDS
END START