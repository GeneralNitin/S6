assume cs:code, ds: data

data segment
    msg1 db 0ah, 0dh, "Enter the string: $"
    msg2 db 0ah, 0dh, "The string is: $"
    msg3 db 0ah, 0dh, "The length of the string is: $"
    instr1 db 20 dup("$")
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    lea si, instr1

    ; display msg to get string
    mov ah, 09h
    lea dx, msg1
    int 21h

    mov ah, 0Ah
    mov dx, si
    int 21h


    ; print the string
    mov ah, 09h
    lea dx, msg2
    int 21h

    mov ah, 09h
    lea dx, instr1+2
    int 21h


    ; print the length of the string
    mov ah, 09h
    lea dx, msg3
    int 21h

    add si, 2
    mov ax, 00

    l2:
        cmp byte ptr[si], "$"
        je l1; encountered end of string, therefore stop
        inc si
        add al, 1
        jmp l2

    l1:
        sub al, 1
        aaa
        mov bx, ax
        add bx, 3030h

        mov ah, 02h
        mov dl, bh
        int 21h; display MSD
        mov ah, 02h
        mov dl, bl
        int 21h; display LSD

        mov ah, 4ch
        int 21h

code ends
end start