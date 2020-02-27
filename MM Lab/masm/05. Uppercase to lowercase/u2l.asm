; Uppercase to lowercase
ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	mesg1 DB 0AH, 0DH, "Enter string: $"
	str DB 50 DUP("$")
DATA ENDS

CODE SEGMENT
start:
	MOV AX, DATA
	MOV DS, AX

	LEA DX, mesg1
	MOV AH, 09H
	INT 21H

	LEA SI, str
	MOV CX, 0000H	
	MOV AH,01H
	L1:
		INT 21H
		MOV [SI],AL
		INC SI
		INC CX
		CMP AL, 0DH
		JNZ L1
	DEC CX
	LEA SI,str	
	MOV AH,02H
	loop1:
		MOV DL, [SI]
		CMP DL, 61H
		JGE islower
		CMP DL, 20H
		JZ islower
		ADD DL, 20H
		islower:
			INT 21H
			INC SI
			LOOP loop1
	MOV AH,4CH
	INT 21H
CODE ENDS
END START
