#make_COM#

; COM file is loaded at CS:0100h
;ramrems
ORG 100h

.model small
.STACK 100H
.data

giris1 db 'choose number for coloring house','$'
giris2 db 'red:1 blue:2 green:3 yellow:4','$'
giris3 db 'choose color of the door','$'
giris4 db 'choose color of the roof','$'

color db ?
color2 db ?
color3 db ?

.code
mov ax,@data
mov ds,ax

MOV AH,02H  
MOV BH,00 
MOV DH,9  
MOV DL,46
INT 10H
lea dx,giris2
mov ah,9
int 21h
;yana renklerle ilgili yaz� yazdirdim burada

MOV AH,02H  
MOV BH,00 
MOV DH,10  
MOV DL,46
INT 10H
lea dx,giris1 
mov ah,9
int 21h
; yana yazi 

mov ax, 3 ;ekran� temizlemek i�in kullan�yoruz
int 10h   ;her i�lemin sonunda olmal� diyebiliriz

;koda giris yapalim
mov ah, 00h ; klavyeden tu�a bas�ld���n� kontrol etmek i�in
int 16h     ; al�nan tu� kodu AH'ya atan�r
; kullan�c�n�n girdi�i say�ya g�re renk de�i�kenine atama yapal�m
cmp al, '1'
je red
cmp al, '2'
je blue
cmp al, '3'
je green
cmp al, '4'
je yellow
jmp done

red:
mov byte ptr [color], 44h ; renk de�i�kenine 4 (k�rm�z�) atama
jmp done

blue:
mov byte ptr [color], 11h ; renk de�i�kenine 1 (mavi) atama
jmp done

green:
mov byte ptr [color], 22h ; renk de�i�kenine 2 (ye�il) atama
jmp done

yellow:
mov byte ptr [color], 66h ; renk de�i�kenine 6 (sar�) atama
jmp done

done:
mov ah, 00 ; rengi ayarlamak i�in
mov bh, 00 ; arka plan rengini ayarlamak i�in
mov bl, [color] ; renk de�i�kenindeki de�ere g�re BL kaydedicisine renk atama

MOV     DL, 30   ; current column.
MOV     DH, 14   ; current row.

JMP next_char ; ilk sat�r� yazd�rmak icin

next_row:
INC     DH
CMP     DH, 23  ;sat�r say�s� 9 o y�zden 23 olmal�(14+9)
JE      stop_print
MOV     DL, 30

next_char:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '�'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

;INC     BL      ; next attributes.
INC     DL
CMP     DL, 48  ;soldan ka��nc� konumdan sonra asag� inecegi 
JE      next_row
JMP     next_char

stop_print:
; set cursor position at (DL,DH):
MOV     DL, 40  ; column.
MOV     DH, 19  ; row.
MOV     AH, 02h
INT     10h

MOV AH,02H  
MOV BH,00 
MOV DH,11  
MOV DL,46
INT 10H
lea dx,giris3
mov ah,9
int 21h
;yana  kap� rengiyle ilgli yaz� yazd� burada

mov ah, 00h ; klavyeden tu�a bas�ld���n� kontrol etmek i�in
int 16h     ; al�nan tu� kodu AH'ya atan�r
; kullan�c�n�n girdi�i say�ya g�re renk de�i�kenine atama yapal�m
cmp al, '1'
je red2
cmp al, '2'
je blue2
cmp al, '3'
je green2
cmp al, '4'
je yellow2
jmp done2

red2:
mov byte ptr [color2], 44h ; renk de�i�kenine 4 (k�rm�z�) atama
jmp done2

blue2:
mov byte ptr [color2], 11h ; renk de�i�kenine 1 (mavi) atama
jmp done2

green2:
mov byte ptr [color2], 22h ; renk de�i�kenine 2 (ye�il) atama
jmp done2

yellow2:
mov byte ptr [color2], 66h ; renk de�i�kenine 6 (sar�) atama
jmp done2

done2:
mov ah, 00 ; rengi ayarlamak i�in
mov bh, 00 ; arka plan rengini ayarlamak i�in
mov bl, [color2] ; renk de�i�kenindeki de�ere g�re BL kaydedicisine renk atama

MOV     DL, 35   ; current column.
MOV     DH, 18   ; current row.
MOV     BL, [color2]   ; current attributes. renk belirliyor

JMP next_char2 ; ilk sat�r� yazd�rmak icin(kap�)

next_row2:
INC     DH
CMP     DH, 23  ; kap�n�n sat�r say�s� (23-18)
JE      stop_print2
MOV     DL, 35

next_char2:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '�'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

INC     DL
CMP     DL, 43  ;soldan ka��nc� konumdan sonra asag� inecegi 
JE      next_row2
JMP     next_char2

stop_print2:
; set cursor position at (DL,DH):
MOV     DL, 40  ; column.
MOV     DH, 19  ; row.
MOV     AH, 02h
INT     10h

MOV     DL, 42   ; current column.
MOV     DH, 20   ; current row.
MOV     BL, 08h   ; kap� kolu rengi

MOV     AH, 02h
INT     10h
MOV     AL, '�'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

MOV AH,02H  
MOV BH,00 
MOV DH,11  
MOV DL,46
INT 10H
lea dx,giris4
mov ah,9
int 21h
;yana  cat� rengiyle ilgli yaz� yazd� burada

mov ah, 00h ; klavyeden tu�a bas�ld���n� kontrol etmek i�in
int 16h     ; al�nan tu� kodu AH'ya atan�r
; kullan�c�n�n girdi�i say�ya g�re renk de�i�kenine atama yapal�m
cmp al, '1'
je red3
cmp al, '2'
je blue3
cmp al, '3'
je green3
cmp al, '4'
je yellow3
jmp done3

red3:
mov byte ptr [color3], 44h ; renk de�i�kenine 4 (k�rm�z�) atama
jmp done3

blue3:
mov byte ptr [color3], 11h ; renk de�i�kenine 1 (mavi) atama
jmp done3

green3:
mov byte ptr [color3], 22h ; renk de�i�kenine 2 (ye�il) atama
jmp done3

yellow3:
mov byte ptr [color3], 66h ; renk de�i�kenine 6 (sar�) atama
jmp done3

done3:
mov ah, 00 ; rengi ayarlamak i�in
mov bh, 00 ; arka plan rengini ayarlamak i�in
mov bl, [color3] ; renk de�i�kenindeki de�ere g�re BL kaydedicisine renk atama

MOV     DL, 38   ; current column.
MOV     DH, 5   ; current row.
MOV     BL, [color3]   ; current attributes. renk belirliyor

MOV SI,[1000H]
MOV [1000H],0

JMP cati ; ilk sat�r� yazd�rmak icin

next_row_cati:

ADD     [1000H],1
MOV     CL,[1000H]

CMP     [1000H], 10 ; kap�n�n sat�r say�s� (23-18)
JE      stop_print_cati
MOV     DL, 39
MOV     DH,4
ADD     DH,CL 

cati:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '�'
MOV     BH, 0
;MOV     CX, 1
MOV     AH, 09h
INT     10h

DEC     DL
INC     DH
CMP     DH, 14  ;soldan ka��nc� konumdan sonra asag� inecegi 
JE      next_row_cati
JMP     cati

stop_print_cati:
; set cursor position at (DL,DH):
MOV     DL, 40  ; column.
MOV     DH, 19  ; row.
MOV     AH, 02h
INT     10h

MOV     DL, 42   ; current column.
MOV     DH, 20   ; current row.
MOV     BL, 08h   ; kap� kolu rengi

MOV     AH, 02h
INT     10h
MOV     AL, '�'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

RET

END