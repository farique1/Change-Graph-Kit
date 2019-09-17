slide_VRAM:
		ld de,0x0010		; point to 3rd char
		ld a,(0xF7F8)		; get USR argument (int var)
		ld hl,VRAMCHAR		; get the VRAM char position
		cp 0x00			; compare the USR argument
		jp z,slide_V		; if 0, do the vertical slide

slide_H:
		ld a,(var+0)		; get the total bytes length
		ld b,a			; put in b for the loop
		cp 0x08			; see if it is 8
		jr z,slide_H_small	; if yes, go do the small slide
		ld b,0x10			; if not. make the loop 2 chars

slide_H_full:
		call RDVRM			; get the 1st byte of 1st char 
		ld c,a			; put in c
		add hl,de			; point hl to the 3rd char col 
		call RDVRM			; get its 1st VRAM byte
		rr a				; rotate it and get carry
		rr c				; rotate 1st byte and pass carry
		jr nc,slide_H_cont	; if las carry is not 0
		xor 0b10000000		; make left bit of byte in a be 1
slide_H_cont:		
		call WRTVRM			; write it back to VRAM
		and a				; reset carry for next operation
		sbc hl,de			; point hl back to 1st VRAM byte
		ld a,c			; get the byte in c
		call WRTVRM			; write back to VRAM
		inc hl			; send hl to next VRAM byte
		djnz slide_H_full		; repeat until finished
		ret				; exit

slide_H_small:
		call RDVRM			; get ist VRAM byte
		rrca				; rotate it to the right
		call WRTVRM			; write it back
		inc hl			; send hl to next byte
		djnz slide_H_small	; do until finished
		ret				; return

slide_V:
		add hl,de			; send hl to the 3rd char
		call RDVRM			; get its 1st byte
		push af			; save it
		ld hl,VRAMCHAR		; send hl back to 1st char
		call RDVRM			; get its 1st byte
		push af			; save it
		ld bc,0x0020		; set length to all chars
		ld de,ram_save		; set MEM to start pos
		ld hl,VRAMCHAR		; set VRAM to 1st char byte
		call LDIRMV			; copy to MEM
		ld bc,0x001f		; set length to all minus 1 byte
		ld hl,ram_save+0x01	; set MEM to start pos +1
		ld de,VRAMCHAR		; set VRAM to 1st char byte
		call LDIRVM			; copy back from MEM offset by 1

		ld de,0x0007		; set de to the len of 1 char
		ld a,(var+0)		; get total byte length
		cp 0x08			; see if it is 1 character
		jr z,slide_small		; if yes, jump ahead
		ld e,0x0f			; if not. set the len to 2 char
slide_small:
		ld hl,VRAMCHAR		; set VRAM to 1st char byte
		add hl,de			; send to last byte of this col 
		pop af			; get saved 1st byte of this col
		call WRTVRM			; write it back to VRAM
						; next only needed for full slide
		ld de,0x0010		; make de point to 3rd char
		add hl,de			; send to last byte of this col
		pop af			; get saved 1st byte of this col
		call WRTVRM			; write it back to VRAM
		ret				; exit
