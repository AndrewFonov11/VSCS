; Very Small Control System - VSCS version 1.0.1
; Kernel
; Released into the public domain under CC0

use16

cmd:

mov ah,0x0e
mov al,'+'
int 10h

mov ah,10h
int 16h

cmp al,0x1B
jz rst
cmp al,'1'
jz ld
cmp al,'0'
jz inf
cmp al,0x09
jz disk
cmp al,0x01
jz text
jmp cmd

ld:

mov ah,0x0e
mov al,'L'
int 10h

mov ah,10h
int 16h

cmp al,'h'
jz hdd
cmp al,'0'
jz flp
mov dl,al
jmp next
hdd:
mov dl,80h
jmp next

flp:
mov dl,0

next:
mov ah,10h
int 16h

mov cl,al

mov ax,0000h
mov es,ax
mov bx,3000h
mov ch,0
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
jmp 0000:3000h

inf:

mov ah,0x0e
mov al,'V'
int 10h
mov al,'S'
int 10h
mov al,'C'
int 10h
mov al,'S'
int 10h
mov al,' '
int 10h
mov al,'v'
int 10h
mov al,'1'
int 10h
mov al,'.'
int 10h
mov al,'0'
int 10h
mov al,'.'
int 10h
mov al,'1'
int 10h

jmp cmd

disk:

mov ah,0x0e
mov al,'D'
int 10h

mov ah,10h
int 16h

cmp al,'h'
jz d_hdd
mov dl,al
jmp n_d
d_hdd:
mov dl,80h

n_d:

mov ax,0000h
mov es,ax
mov bx,2000h
mov ch,0
mov cl,01h
mov dh,0
mov al,01h
mov ah,02h
int 13h
jc error
mov ah,0x0e
mov al,'^'
int 10h
jmp cmd

text:

mov ah,0x0e
mov al,'T'
int 10h
jmp ntext

ntext:

mov ah,10h
int 16h
mov ah,0x0e
int 10h
cmp al,0x1B
jz cmd
jmp ntext

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

jmp $