rotate_VRAM:
		ld hl,VRAMCHAR		; pos of 1st byte to read
		ld d,0x08			; amount of bytes per turn
		ld e,0x04			; number of characters
rotate:
		ld b,0x08			; number of bits to process
		push hl			; save the VRAM position
		call RDVRM			; get 1st byte of the char
		ld hl,(rotate_ram_sv)	; get the MEM save position
rotate_bitloop:
		rla				; put the left bit on the carrier
		rr (hl)			; and into the 1st MEM position
		inc hl			; go to the next MEM position
		djnz rotate_bitloop	; repeat until 8 bytes got bits
		pop hl			; get back the VRAM position
		inc hl			; go to the next VRAM position
		dec d				; decrement the number of bytes
		jr nz,rotate		; if not 0 do another byte
		ld a,(var+0)		; get the total bytes length
		cp 0x08			; if need to do one char
		jp nz,rotate_fillback	; if no, go do some more 
		ld bc,0x0008		; set length to 1 character
		ld hl,ram_save		; MEM location of processed char
		ld de,VRAMCHAR		; VRAM of original char
		call LDIRVM			; replace orig char with new
		ret				; exit

rotate_fillback:				; if is more than 1 character
		push hl			; save the VRAM position
		ld hl,(rotate_ram_sv)	; get the MEM save position
		ld bc,0x0008		; get 8
		add hl,bc			; add to the MEM position
		ld (rotate_ram_sv),hl	; save the new MEM position
		pop hl			; get back the VRAM position
		ld d,0x08			; do another character
		dec e				; decrease the number of chars
		jr nz,rotate		; if not 0 go do another
						; if 0
		ld hl,ram_save		; get original MEM position
		ld (rotate_ram_sv),hl	; restore to enable to use again
		ld bc,0x0008		; set length to 1 character
		ld hl,ram_save+0x00	; MEM loc of 1st altered char
		ld de,VRAMCHAR+0x10	; VRAM loc of 3rd char
		call LDIRVM			; replace orig with new
		ld bc,0x0008		; set length to 1 character
		ld hl,ram_save+0x08	; MEM loc of 2nd altered char
		ld de,VRAMCHAR+0x00	; VRAM loc of 1st char
		call LDIRVM			; replace orig with new
		ld bc,0x0008		; set length to 1 character
		ld hl,ram_save+0x10	; MEM loc of 3rd altered char
		ld de,VRAMCHAR+0x18	; VRAM loc of 4th char
		call LDIRVM			; replace orig with new
		ld bc,0x0008		; set length to 1 character
		ld hl,ram_save+0x18	; MEM loc of 4th altered char
		ld de,VRAMCHAR+0x08	; VRAM loc of 2nd char
		call LDIRVM			; replace orig with new
		ret				; exit
rotate_ram_sv:				; copy of the MEM position
		dw ram_save			; to increase without losing