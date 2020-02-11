ASSUME CS:code, DS: data

data segment
    msg1 db 0ah, "Enter the string: $"
    msg2 db 0ah, "The length of the string is: $"
    instr1 db 40 dup("$")
data ends

code segment
start:
    MOV AX, data
    MOV DS, AX

    ; display msg to get string
    MOV AH, 09h
    LEA DX, msg1
    INT 21h

    MOV CX, 0; set counter to 0
    char:
        MOV AH, 01H; read a character
        INT 21h
        CMP AL, 0Dh; compare with ENTER
        JZ len     ; equal => end the string
        INC CX
        JMP char
    len: 
        ; print the length of the string
        MOV AH, 09h
        LEA DX, msg2
        INT 21h

        MOV AX, CX; move the string length into AX
        MOV CX, 0; clear counter CX
        MOV DX, 0; clear DX
        MOV BX, 0Ah
        ; perform hex to BCD conversion
        divide: 
            DIV BX
            PUSH DX
            MOV DX, 0
            INC CX
            OR AX, AX
            JNZ divide
        
        print:
            POP DX
            ADD DL, 30h
            MOV AH, 02h
            INT 21h
            LOOP print

        MOV AH, 4Ch
        INT 21h

code ends
end start