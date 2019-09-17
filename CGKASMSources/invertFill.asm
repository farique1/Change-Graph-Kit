; mini preview:	length / bc / var+3 = 0x0020
;			start / hl / var+1 = 0x0040
; scan area:	length / bc / var+3 = 0x0320
;			start / hl / var+1 = 0x0400
; wind req:		length / bc / var+0 = 0x0060
;			VRAM start / var+2 = 0x1940
invert_VRAM:
		ld a,(var+0)		; get the length
		ld b,a			; b=a
		ld hl,VRAMCHAR		; the VRAM start pos
invert_loop:	
		call RDVRM			; read from VRAM
		xor 0xff			; invert the bits
		call WRTVRM			; write to VRAM
		inc hl			; increment the VRAM pos
		djnz invert_loop		; do until end of length
		ret				; exit
			
fill_VRAM:	
	      ld a,(0xF7F8)		; get USR argument (int var)
		ld bc,(var+0)		; length to fill
		ld hl,(var+2)		; the VRAM start pos
		call FILVRM			; fill the VRAM
		ret				; exit