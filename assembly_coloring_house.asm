#make_COM#

; COM file is loaded at CS:0100h
ORG 100h

.model small
.STACK 100H
.data
yildiz db '�', '$'
giris1 db 'evin rengi icin say� seciniz','$'
color2 db ?

giris2 db 'k�rm�z:1 mavi:2 yesil:3 sar�:4','$'
giris3 db 'kap� rengini seciniz','$'

color db ?

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
;yana yazi yazdirdim burada



MOV AH,02H  
MOV BH,00 
MOV DH,10  
MOV DL,46
INT 10H
lea dx,giris1 
mov ah,9
int 21h
;burada yana yazi yazdirdim

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
;MOV     BL, 44h   ; current attributes. renk belirliyor

;JMP sol

JMP next_char ; ilk sat�r� yazd�rmak icin?

next_row:
INC     DH
CMP     DH, 23  ;sat�r say�s� 11 o y�zden 25 olmal�(14+11)
JE      stop_print
MOV     DL, 30
;INC     BL
;MOV     DH, 14   ; current row.
;MOV     BL, 11h 

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
;yana yazi yazdirdim burada

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

JMP next_char2 ; ilk sat�r� yazd�rmak icin?

next_row2:
INC     DH
CMP     DH, 23  ;sat�r say�s� 11 o y�zden 25 olmal�(14+11)
JE      stop_print2
MOV     DL, 35
;INC     BL
;MOV     DH, 14   ; current row.
;MOV     BL, 11h 

next_char2:
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
MOV     BL, 88h   ; current attributes. renk belirliyor

MOV     AH, 02h
INT     10h
MOV     AL, '�'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h


MOV DH,4   
MOV DL,39
call sol 
MOV DH,4   
MOV DL,38
call sag

MOV DH,5   
MOV DL,39
call sol
MOV DH,5   
MOV DL,38
call sag 

MOV DH,6   
MOV DL,39
call sol
MOV DH,6   
MOV DL,38
call sag

MOV DH,7   
MOV DL,39
call sol
MOV DH,7   
MOV DL,38
call sag  

MOV DH,8   
MOV DL,39
call sol
MOV DH,8   
MOV DL,38
call sag 

MOV DH,9   
MOV DL,39
call sol
MOV DH,9   
MOV DL,38
call sag  

MOV DH,10   
MOV DL,39
call sol
MOV DH,10   
MOV DL,38
call sag  

MOV DH,11   
MOV DL,39
call sol
MOV DH,11   
MOV DL,38
call sag   
 
MOV DH,12   
MOV DL,39

sol:
    MOV AH,02H  
    MOV BH,00 
    ADD DH,1
    SUB DL,1
    INT 10H
    call yaz
    cmp DH,12
    jle sol
  
MOV DH,12   
MOV DL,38   
sag:
    MOV AH,02H  
    MOV BH,00 
    ADD DH,1 ;ekleme i�lemi, cursor hareketi i�in olacak bu aradki bo�luk gibi
    ADD DL,1
    INT 10H
    call yaz ;yazd�rma i�in
    cmp DH,12
    jle sag ;if dh>=15
;burada ucgenin sag kismini yaptik ilk basta


yaz proc
    ;push ax
    ;push bx
    mov ah, 02h
    int 10h ; 0Ch konsol ekran�nda renkli karakterler yazd�rmak i�in kullan�l�r
    mov bh, 0 ; arka plan rengi (siyah)
    mov bl, 44h ; �n plan rengi (sar�)
    mov al, yildiz
    MOV AH, 09h
    int 10h
    ;pop bx
    ;pop ax
    ret
yaz endp
;bu fonksiyonun amaci
;yildizlari kolayca yazdirmak.

RET

END