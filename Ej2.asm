org 	100h

section .text

	call 	grafico	

;f(0) = 1
	xor 	si, si
	xor 	di, di

	mov 	si, 95d 	; X -> Columna
	mov 	di, 120d 	; Y -> Fila
	mov	al, 30d		
	mov	[300h], al	; L -> Lado
	mov	al, 0Dh
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '1'
	mov	[320h], al
	mov	al, 8d
	mov	[321h], al ;Fila
	mov	al, 13d
	mov	[322h], al ;Columna
	mov	al, 0Dh
	mov	[323h], al
	call	char

	;f(1) = 1
	xor 	si, si
	xor 	di, di

	mov 	si, 125d 	; X -> Columna
	mov 	di, 120d 	; Y -> Fila
	mov	al, 30d		
	mov	[300h], al	; L -> Lado
	mov	al, 03h
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '1'
	mov	[320h], al
	mov	al, 8d
	mov	[321h], al ;Fila
	mov	al, 17d
	mov	[322h], al ;Columna
	mov	al, 03h
	mov	[323h], al
	call	char

	;f(2) = 2
	xor 	si, si
	xor 	di, di

	mov 	si, 95d 	; X -> Columna
	mov 	di, 60d 	; Y -> Fila
	mov	al, 60d		
	mov	[300h], al	; L -> Lado
	mov	al, 06h
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '2'
	mov	[320h], al
	mov	al, 5d
	mov	[321h], al ;Fila
	mov	al, 15d
	mov	[322h], al ;Columna
	mov	al, 06h
	mov	[323h], al
	call	char

	;f(3) = 3
	xor 	si, si
	xor 	di, di

	mov 	si, 5d 	; X -> Columna
	mov 	di, 60d 	; Y -> Fila
	mov	al, 90d		
	mov	[300h], al	; L -> Lado
	mov	al, 09h
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '3'
	mov	[320h], al
	mov	al, 6d
	mov	[321h], al ;Fila
	mov	al, 6d
	mov	[322h], al ;Columna
	mov	al, 09h
	mov	[323h], al
	call	char

	;f(4) = 5
	xor 	si, si
	xor 	di, di

	mov 	si, 5d 	; X -> Columna
	mov 	di, 150d 	; Y -> Fila
	mov	al, 150d		
	mov	[300h], al	; L -> Lado
	mov	al, 01h
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '5'
	mov	[320h], al
	mov	al, 13d
	mov	[321h], al ;Fila
	mov	al, 10d
	mov	[322h], al ;Columna
	mov	al, 01h
	mov	[323h], al
	call	char

	;f(5) = 8
	xor 	si, si
	xor 	di, di

	mov 	si, 155d 	; X -> Columna
	mov 	di, 60d 	; Y -> Fila
	mov	al, 240d		
	mov	[300h], al	; L -> Lado
	mov	al, 02h
	mov	[320h], al	; Color
	
	call 	cuadro

	mov	al, '8'
	mov	[320h], al
	mov	al, 11d
	mov	[321h], al ;Fila
	mov	al, 34d
	mov	[322h], al ;Columna
	mov	al, 02h
	mov	[323h], al
	call	char

	call 	kb
	int 	20h

pixel:	mov	ah, 0Ch
	mov	al, [320h]
	mov	bh, 00h
	int 	10h
	ret

grafico:mov	ah, 00h
	mov	al, 12h
	int 	10h
	ret

;Este segmento dibuja un cuadro iniciando en (si, di) con L = [300h]
cuadro:	mov	bx, 0000h	;Limites de si (BH) y di (BL)
	mov	[310h], si
hor:	mov 	cx, 0d 		; Columna 
	add 	cx, si
	mov	dx, di 		; Fila
	mov	[330h], bx
	call 	pixel
	mov	bx, [330h]
	inc 	si
	inc 	bh
	cmp 	bh, [300h]
	jne 	hor
	
	inc	di
	inc	bl
	cmp	bl, [300h]
	je	end
	mov	si, [310h]
	mov	bh, 00h
	jmp	hor

end:	ret

	;Escribir el caracter guardado en [320h] en la fila [321h] y columna [322h], color en [323h]
char:	mov  dl, [322h]   	; Columna
	mov  dh, [321h]   	; Fila
	mov  bh, 0h   
	mov  ah, 02h 
	int  10h

	mov  al, [320h]		; Caracter
	mov  bl, [323h]  	; Color
	mov  bh, 0h    		; Pagina 0
	mov  ah, 0Eh
	int  10h
	ret

kb: 	mov	ah, 00h
	int 	16h
	ret
