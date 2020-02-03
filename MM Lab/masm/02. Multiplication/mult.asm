ASSUME CS:CODE, DS:DATA

DATA SEGMENT
MSG1 DB 0AH,0DH,"Enter First Number to Add: $"
MSG2 DB 0AH,0DH,"Enter Second Number to Add: $"
MSG3 DB 0AH,0DH,"Result of Addition is: $"
DATA ENDS

CODE SEGMENT
START:
    mov AX, DATA
    mov DS, AX

    mov AH, 09H
    lea DX, MSG1
    int 21H

    mov AH, 01H
    INT 21H         ; Read 1st digit of 1st no.
    sub AL, 30h
    mov CL, 04
    rol AL, CL      ;rotate the digit to MSB position
    mov BL, AL      ;save to BL

    mov AH, 01H
    INT 21H         ; Read 2nd digit of 1st no.
    sub AL, 30h
    add BL, AL      ; the 1st number is in BL


    mov AH, 09H
    lea DX, MSG2
    int 21H

    mov AH, 01H
    INT 21H         ; Read 1st digit of 2nd no.
    sub AL, 30h
    mov CL, 04
    rol AL, CL      ;rotate the digit to MSB position
    mov DL, AL      ;save to DL

    mov AH, 01H
    INT 21H         ; Read 2nd digit of 2nd no.
    sub AL, 30h
    add DL, AL      ; the 2nd number is in DL

    ; call displaynum
    mov AL, DL
    MUL BL
     


    mov AH, 4Ch
    int 21H


;display procedure. Expects the number to be displayed in "BL"

displaynum proc near
    mov al,bl
    mov cl,04
    and al,0f0h
    shr al,cl
    cmp al,09
    jbe number
    add al,07

number: add al,30h
        mov dl,al
        mov ah,02
        int 21h

        mov al,bl
        and al,00fh
        cmp al,09
        jbe number2
        add al,07
number2: add al,30h
         mov  dl,al
         mov ah,02
         int 21h

ret                          ;return from procedure 
displaynum endp              ;end of "displaynum" procedure

CODE ENDS
END START