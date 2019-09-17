flip_VRAM:
		ld a,(flip_var)		; get the status variable
		xor 0xff			; invert
		ld (flip_var),a		; save
		jp z,flip_V			; if zero do vert else do horz
flip_H:	
		ld hl,VRAMCHAR		; get VRAM start
		ld a,(var+0)		; get total byte length
		ld b,a			; b=a
flip_H_byte:	
		push bc			; save total byte length
		ld b,0x08			; number of bits to cycle
		call RDVRM			; VRAM hl(VRAMCHAR) to a
		ld d,a			; b=a
flip_bitloop:	
		rl d				; drop a bit from the left of b
		rra				; and insert to the right of a
		djnz flip_bitloop		; do this 8(b) times
		call WRTVRM			; then done put a into VRAM hl(VRAMCHAR)
		inc hl			; increment the byte location
		pop bc			; get total byte length back
		djnz flip_H_byte		; do this (var+0)(b) times
		ld a,(var+0)		; get total byte length
		cp 0x08			; see if it is 8
		ret z				; if yes, exit
						; if not, do the character swap
		ld bc,0x0020		; length of all 4 characters
		ld de,ram_save		; MEM save location
		ld hl,VRAMCHAR		; VRAM get location
		call LDIRMV			; copy VRAM to MEM
		ld bc,0x0010		; length of 2 characters
		ld de,VRAMCHAR+0x10	; VRAM location of 2nd set of chars
		ld hl,ram_save		; MEM location of 1st set of 2 chars
		call LDIRVM			; put MEM 1st set into VRAM 2nd set
		ld bc,0x0010		; length of 2 chars (LDIRVM destroys bc)
		ld de,VRAMCHAR 		; VRAM location of 1st set of chars 
		ld hl,ram_save+0x10	; MEM location of 2nd set of 2 chars
		call LDIRVM			; put MEM 2nd set into VRAM 1st set
		ret	
flip_V:	
		ld bc,0x0020		; get all characters
		ld de,ram_save		; get the MEM position
		ld hl,VRAMCHAR		; get the VRAM position
		call LDIRMV			; put VRAM chars on MEM
		ld hl,VRAMCHAR		; VRAM position again (LDIRMV destroys)
		ld b,0x08			; the length of a character
		ld de,ram_save+0x07	; MEM pos of the char's last byte
		ld a,(var+0)		; get the intended total length of bytes
		cp 0x08			; if it is 8
		jp z,flip_V_loop		; jump ahead with the previous data
		ld de,ram_save+0x0f	; MEM pos of the 2nd char last byte
		ld b,0x02			; if not 8 process char columns 2 times
flip_V_full:
		push bc			; save the number of columns
		ld b,0x10			; else get the length of 2 characters
flip_V_loop:
		ld a,(de)			; put the last byte in a
		call WRTVRM			; write to VRAM pos hl - VRAMCHAR
		inc hl			; increment the VRAM position
		dec de	 		; decrement the MEM position
		djnz flip_V_loop		; do until the char or chars are done
		ld a,(var+0)		; get the intended total length of bytes 
		cp 0x08			; see if it is 8
		ret z				; if yes, exit

		ld hl,VRAMCHAR+0x10	; VRAM pos of the 3rd char 1st byte
		ld de,ram_save+0x1f	; MEM pos of the 4th char last byte
		pop bc			; get back the number of columns
		djnz flip_V_full		; if not done, do another
		ret				; exit
flip_var:	
		db 0x00			; flip H or V