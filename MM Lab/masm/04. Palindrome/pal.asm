assume cs:code, ds:data

data segment
    msg1 db 10, 13, 'Enter a string: $'
    msg2 db 10, 13, 'Entered string is: $'
    msg3 db 10, 13, 'No, given string is not a palindrome $' 
    msg4 db 10, 13, 'The given string is a palindrome $'
    msg5 db 10, 13, 'Reverse of entered string is: $'
    p1 label byte
    m1 db 0ffh              ; buffer size
    l1 db ?                 ;inputLength - no. of characters read 
    str1 db 0ffh dup ('$')  ; actual buffer
    str2 db 0ffh dup ('$')
data ends 

display macro msg
    mov ah, 09h
    lea dx, msg
    int 21h
endm

code segment
start:
    mov ax, data
    mov ds, ax
            
    display msg1
    
    lea dx, p1
    mov ah, 0ah
    int 21h
    
    display msg2
    display str1
    
    display msg5
            
    lea si, str1
    lea di, str2
    
    mov dl, l1
    dec dl
    mov dh, 0
    add si, dx
    mov cl, l1
    mov ch, 0
       
    reverse:
        mov al, [si]
        mov [di], al
        inc di
        dec si
        loop reverse
       
    display str2
                    
    lea si, str1
    lea di, str2   
    
    mov cl, l1
    mov ch, 0
       
    check:
        mov al, [si]
        cmp [di], al
        jne notpalin
        inc di
        inc si
        loop check
    display msg4
    jmp exit
    notpalin:
        display msg3
               
    exit: 
        mov ah, 4ch
        int 21h
code ends
end start