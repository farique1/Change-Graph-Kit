; CGK Support Routines
; To use on the DATA lines inside the program
; 16bit reg variables in little endian

RDVRM:	equ 0x004A	; read from VRAM
WRTVRM:	equ 0x004d	; write to VRAM
FILVRM:	equ 0x0056	; fill vram area
LDIRMV:	equ 0x0059	; copy from VRAM
LDIRVM:	equ 0x005C	; copy to VRAM
VRAMCHAR	equ 0x0040	; characters to modify 
EDTBLKPOS:	equ 0x184e	; top left pos of the edit block
		; mini preview: hl=0x0040 bc=0x0020
		; scan area: hl=0x0400 bc=0x0320
		; wind req: len=0x0060 vram=0x1940 mem=ram_save
		org 0xda00
var:
		db 0x0,0x0,0x0,0x0	; pokable   0xd000-0xd003
		db 0x0,0x0,0x0,0x0	; variables 0xd004-0xd007
start:
		jp invert_VRAM	; 08 v0-v1=len v2-v3=srt usr(ptrn)
		jp fill_VRAM	; 0b v0=len
		jp copy_VRAM	; 0e v0-v1=strt v2-3=len usr(direc)
		jp populate_edit	; 11 v0=col_len v1=lin_len
		
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

copy_VRAM:		
	      ld a,(0xF7F8)		; get USR argument (int var)
		cp 0x00			; see if it is 0
		jp z, copy_from_VRAM	; if yes, go read from VRAM
copy_to_VRAM:
		ld bc,(var+2)		; get the length
		ld de,(var+0)		; get the VRAM position
		ld hl,ram_save		; get the MEM position
		call LDIRVM			; copy to VRAM
		ret				; exit
copy_from_VRAM:
		ld bc,(var+2)		; get the length
		ld de,ram_save		; get the MEM position
		ld hl,(var+0)		; get the VRAM position
		call LDIRMV			; read the VRAM
		ret				; exit
		
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
		
ram_save:
		db 0x0