; CGK Support Routines
; 16bit pokable variables in little endian
; /Users/Farique/Desktop/Projects/Assembly/zasm/zasm  -uwy ./cgksources/main.asm ./diskasm/main.bin 

RDVRM		equ 0x004A	; read from VRAM
WRTVRM:	equ 0x004d	; write to VRAM
FILVRM:	equ 0x0056	; fill vram area
LDIRMV:	equ 0x0059	; block from VRAM
LDIRVM:	equ 0x005C	; block to VRAM
VRAMCHAR:	equ 0x0040 	; characters to modify 
				; 0x0040=mini_prev 0x0208=A 0x0280=P 
EDTBLKPOS:	equ 0x184e	; top left pos of the edit block

		org 0xda00-7	; start memory location
					; minus 7 bytes from the header 
		; header
		db 0xfe		; indicate it is a bin file
		dw var		; start address
		dw _end-2		; emd address
		dw start		; execute address
var:
		db 0x00,0x00,0x00,0x00	; pokable   0xd000-0xd003
		db 0x00,0x00,0x00,0x00	; variables 0xd004-0xd007
start:
		jp invert_VRAM		; 08 v0=len
		jp fill_VRAM		; 0b v0-v1=len v2-v3=srt usr(ptrn)
		jp copy_VRAM		; 0e v0-v1=VRAM v2=width v3=height usr(direc)
		jp populate_edit		; 11 v0=col_len v1=lin_len
		jp flip_VRAM		; 14 v0=len
		jp rotate_VRAM		; 17 v0=len
		jp slide_VRAM		; 1a v0=len usr(direc)

#include "invertFill.asm"
#include "copy.asm"
#include "populateEdit.asm"
#include "flip.asm"
#include "rotate.asm"
#include "slide.asm"

ram_save:					; MEM pos to use as buffer 
		db 0x0

