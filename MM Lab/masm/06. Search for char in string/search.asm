; search for char in string

ASSUME CS:CODE,DS:DATA
DATA SEGMENT
	mesg1 DB 0AH,0DH,"Enter string: $"
	mesg2 DB 0AH,0DH,"Character found$"
	mesg3 DB 0AH,0DH,"Character not found$"
	mesg4 DB 0AH,0DH,"Enter character to search: $"
	str DB 50 DUP("$")
DATA ENDS

CODE SEGMENT
start:
	MOV AX,DATA
	MOV DS,AX

	LEA DX,mesg1
	MOV AH,09H
	INT 21H

	LEA SI,str

	L1:
		MOV AH,01H

		INT 21H
		MOV [SI],AL
		INC SI
		CMP AL,0DH
		JNZ L1


	LEA DX,mesg4		
	MOV AH,09H
	INT 21H
	MOV AH,01H
	INT 21H

	LEA SI,str
	
	print:
		CMP AL,[SI]
		JZ success
		INC SI
		LOOP print
	
	fail:
		LEA DX,mesg3
		MOV AH,09H
		INT 21H                                   
		JMP stop

	success:
		LEA DX,mesg2
		MOV AH,09H
		INT 21H

	stop:
		MOV AH,4CH
		INT 21H
CODE ENDS
END START
