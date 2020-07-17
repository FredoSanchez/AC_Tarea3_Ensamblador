org 	100h

section .text

	call 	grafico
	xor 	di, di 
    xor     si, si

    mov 	[300h], byte 0100b
    mov 	si, 10d
    mov 	di, 70d 

	MOV 	ax, 0
	INT 	33h
	MOV 	ax, 1
	INT 	33h

reset: 
    mov ax, 04h
    mov cx, 95
    mov dx, 150
    INT 33h
    call dibujo
    mov ax, 06h
    int 33h 

hitbox:  
        mov ax,03h
        int 33h
        and bx, 3h
        CMP cx, 10d 
        JGE s1
        jmp hitbox 
    s1: cmp dx, 70d ; 
        JGE s
        jmp hitbox 
    s:  CMP cx, 85d 
        JLE s2
        jmp hitbox 
    s2: cmp dx, 145d
        JLE s3
        jmp hitbox
    s3: cmp bx, 00000001b
        JE cambio
        JL s4
    s4: cmp bx, 00000010b
        JE terminar
        jmp hitbox



dibujo:
	mov 	cx, si 
	mov 	dx, di 
	call 	pixel 
	inc 	si   
	cmp 	si, 85d 
	jne 	dibujo 
	xor 	si, si 
	mov 	si, 10d 
	mov 	cx, si 
	inc 	di   
	cmp 	di, 145d 
	jne 	dibujo
	ret

cambio:
        cmp [300h], byte 0100b
        JE verde
        cmp [300h], byte 0010b
        JE azul
        cmp  [300h], byte 0001b 
        JE rojo

verde:
   
    mov  [300h], byte  0010b
    mov si, 10d 
    mov di, 70d 
    jmp reset

azul:

    mov [300h], byte 0001b 
    mov si, 10d 
    mov di, 70d 
    jmp reset

rojo:

    mov [300h], byte 0100b
    mov si, 10d 
    mov di, 70d 
    jmp reset
    
grafico:
        mov ah,00h
        mov al, 12h
        int 10h
        ret
pixel: 
        mov ah, 0Ch
        mov al, [300h]
        int 10h
        ret
kb: 	
    mov	ah, 00h
	int 	16h
	ret

terminar:
    mov ah, 00h
    int 10h
    mov ah,0x4C          
    int 0x21