org	100h

section	.text

	call	grafico
	xor	di, di
	xor	si, si

yelow1:	mov	cx, 20d	
	add	cx, si
	mov	dx, 30d
	add	dx, di
	call	pixel
	inc	di
	cmp	di, 201d
	jne	yelow1
	xor	di, di
	inc	si
	cmp	si, 151d
	jne	yelow1
	mov	ah, 3d
	call	m_cur

	xor	di, di
texto2:	mov	ah, 0Eh 	
	mov	al, [msg1+di]
	mov	bl, 1111b
	int	10h
	inc	di
	cmp	di, len
	jl	texto2

	xor	di, di
input:	call 	kb 		
	cmp	al, 0Dh
	je	output
	cmp	al, 40h
	je	set

valid:	mov	[400h+di], al
	inc	di
	jmp	input	

output:	mov	[360h], di
	cmp	di, 70d
	jg	error
	cmp	di, 50d
	jl 	error
	xor	ah, ah
	mov	ah, 3d
	call	m_cur2
	xor	si, si

texto3:	mov	ah, 0Eh 	
	mov	al, [400h+si]
	mov	bl, 1110b
	int	10h
	cmp	si, 17d
	je	newl1
	cmp	si, 35d
	je	newl2
	cmp	si, 53d
	je	newl3

valid1:	inc	si
	cmp	si, di
	jle	texto3
	mov	ah, 5d
	call	m_cur
	xor	di, di

texto4:	mov	ah, 0Eh 	
	mov	al, [msg2+di]
	mov	bl, 01h
	int	10h
	inc	di
	cmp	di, len3
	jl	texto4
	call	kb
	cmp	al, 53h
	je	next
	int	20h

next:	mov	ax, 0000h
	int	10h
	call	grafico
	xor	ah, ah
	mov	ah, 3d
	call	m_cur2

	xor	si, si
texto9:	mov	ah, 0Eh 	
	mov	al, [400h+si]
	add	al, 20h
	cmp	al, 40h
	je	set2

valid3:	mov	bl, 1111b
	int	10h
	cmp	si, 17d
	je	newl4
	cmp	si, 35d
	je	newl5
	cmp	si, 53d
	je	newl6

valid2:	inc	si
	cmp	si, [360h]
	jle	texto9
	call	kb
	int	20h

newl1:	mov	ah, 4d		
	call	m_cur2
	jmp	valid1

newl2:	mov	ah, 5d
	call	m_cur2
	jmp	valid1

newl3:	mov	ah, 6d
	call	m_cur2
	jmp	valid1

newl4:	mov	ah, 4d
	call	m_cur2
	jmp	valid2

newl5:	mov	ah, 5d
	call	m_cur2
	jmp	valid2

newl6:	mov	ah, 6d
	call	m_cur2
	jmp	valid2

grafico:mov	ah, 00h
	mov	al, 12h
	int	10h
	ret

cls:	mov	ah, 00h
	mov	al, 03h
	int	10h
	ret

pixel:	mov	ah, 0Ch			
	mov	al, 1110b
	int 	10h
	ret

m_cur:	mov	dh, ah			
	mov	dl, 25d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

m_cur2:	mov	dh, ah
	mov	dl, 3d
	mov	bh, 0d
	mov	ah, 02h
	int	10h
	ret

set:	mov	al, 20h		
	jmp	valid

set2:	mov	al, 20h
	jmp	valid3

error:	mov	ah,3d
	call	m_cur
	xor	di, di
texto5:	mov	ah, 0Eh 	 
	mov	al, [err+di]
	mov	bl, 0100b
	int	10h
	inc	di
	cmp	di, len2
	jl	texto5
	call	kb
	int	20h

kb: 	mov	ah, 00h
	int 	16h
	ret

section	.data
msg1	db	"En escriba un parrafo corto y presione Enter"
len	equ	$-msg1
err	db	"La cantidad caracteres debe ser entre 50 y 70"
len2	equ	$-err
msg2	db	"validinuar con el proceso? (S/n)"
len3	equ	$-msg2