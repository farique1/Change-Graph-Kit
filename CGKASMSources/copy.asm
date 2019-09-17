copy_VRAM:
	      ld a,(0xF7F8)		; get USR argument (int var)
	      ld (copy_var),a		; save it
		ld de,ram_save		; MEM start position
		ld hl,(var+0)		; VRAM screen position
		ld a,(var+3)		; get the height
		ld b,a			; b=a
copy_loopY:					; do the height
		push bc			; save the height
		ld a,(var+2)		; get the width
		ld b,a			; save the width
copy_loopX:					; do the width
		ld a,(copy_var)		; get back the USR argument
		cp 0x00			; see if it is 0
		jp z, copy_read		; if yes, go read from VRAM
		ld a,(de)			; if not. get the char from MEM
		call WRTVRM			; put it on the screen
copy_back:	
		inc hl			; increment the VRAM position
		inc de			; increment the MEM position
		djnz copy_loopX		; do until the width is reached
	
		ld bc,0x20			; get the screen width
		add hl,bc			; add to the VRAM position
		ld b,0			; put 0 on the MSByte of bc
		ld a,(var+2)		; get the width
		ld c,a			; put it on the LSByte of bc
		sbc hl,bc			; subtract from the VRAM position
		pop bc			; get back the height
		djnz copy_loopY		; do until the height is reached
		ret				; exit
copy_read:	
		call RDVRM			; read the VRAM
		ld (de),a			; put it on the MEM
		jr copy_back		; go back 
copy_var:	
		db 0x00			; read or write