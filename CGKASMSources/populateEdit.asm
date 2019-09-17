populate_edit:
		ld de,VRAMCHAR		; pos of 1st byte to read
		ld hl,EDTBLKPOS		; edit block top left pos
		ld a,(var+0)		; edit block columns length
		ld b,a			; b=a
pop_loopL:					; do the columns
		push bc			; save the columns number
		ld a,(var+1)		; edit block lines length
		ld b,a			; b=a
pop_loopY:					; do the lines
		push bc			; save the lines number
		ex de,hl			; put the VRAM pos in hl
		call RDVRM			; get 1st VRAM byte (hl to a)
		ex de,hl			; get the edit pos back in hl
		ld b,0x08			; number of bits to process
pop_loopX:					; do the bits
		rla				; put the left bit on the carrier
		push af			; save the byte being read
		jr c,pop_ONE		; if the bit is 1, get its char
		ld a,0x10			; else get the 0 bit character
pop_cont:	
		call WRTVRM			; put it on the screen
		pop af			; get the byte being read back
		inc hl			; increment the edit block X pos
		djnz pop_loopX		; do until the byte is finished
	
		inc de			; increment the byte to read pos
		push de			; save the byte to read pos
		ld de,0x18			; jump edit blk pos to next line
		add hl,de			; send it to hl
		pop de			; get back the byte to read pos
		pop bc			; get the lines number back
		djnz pop_loopY		; do until there are lines to do
	
		ld hl,EDTBLKPOS+8		; edit block 2dn column pos
		pop bc			; get back edit block col length
		djnz pop_loopL		; if more than 1, do another
		ret				; exit
pop_ONE:	
		ld a,228			; get the 1 bit character
		jr pop_cont			; return