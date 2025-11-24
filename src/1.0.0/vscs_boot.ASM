; Very Small Control System - VSCS version 1.0.0
; Boot Loader
; Released into the public domain under CC0

org 0x7c00
use16

jmp start
nop
db 'VSCS'
db 'Public Domain Software'

start:

cli
xor ax, ax
mov ds, ax
mov es, ax
mov ss, ax
mov sp, 0xFFFF
sti

mov ax,0002h
int 10h

mov ah,10h
int 16h

cmp al,'*'
jz next

jmp rst

next:

mov ax,0000h
mov es,ax
mov dl,0
mov bx,1000h
mov ch,0
mov cl,02h
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
jmp 0000:1000h

error:

mov ah,0x0e
mov al,'~'
int 10h
mov ah,10h
int 16h
jmp rst

rst:
mov ax,0002h
int 10h
int 19h

times 510 - ($ - $$) db 0
db 0x55,0xAA