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
;yana renklerle ilgili yazý yazdirdim burada

MOV AH,02H  
MOV BH,00 
MOV DH,10  
MOV DL,46
INT 10H
lea dx,giris1 
mov ah,9
int 21h
; yana yazi 

mov ax, 3 ;ekraný temizlemek için kullanýyoruz
int 10h   ;her iþlemin sonunda olmalý diyebiliriz

;koda giris yapalim
mov ah, 00h ; klavyeden tuþa basýldýðýný kontrol etmek için
int 16h     ; alýnan tuþ kodu AH'ya atanýr
; kullanýcýnýn girdiði sayýya göre renk deðiþkenine atama yapalým
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
mov byte ptr [color], 44h ; renk deðiþkenine 4 (kýrmýzý) atama
jmp done

blue:
mov byte ptr [color], 11h ; renk deðiþkenine 1 (mavi) atama
jmp done

green:
mov byte ptr [color], 22h ; renk deðiþkenine 2 (yeþil) atama
jmp done

yellow:
mov byte ptr [color], 66h ; renk deðiþkenine 6 (sarý) atama
jmp done

done:
mov ah, 00 ; rengi ayarlamak için
mov bh, 00 ; arka plan rengini ayarlamak için
mov bl, [color] ; renk deðiþkenindeki deðere göre BL kaydedicisine renk atama

MOV     DL, 30   ; current column.
MOV     DH, 14   ; current row.

JMP next_char ; ilk satýrý yazdýrmak icin

next_row:
INC     DH
CMP     DH, 23  ;satýr sayýsý 9 o yüzden 23 olmalý(14+9)
JE      stop_print
MOV     DL, 30

next_char:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '•'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

;INC     BL      ; next attributes.
INC     DL
CMP     DL, 48  ;soldan kaçýncý konumdan sonra asagý inecegi 
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
;yana  kapý rengiyle ilgli yazý yazdý burada

mov ah, 00h ; klavyeden tuþa basýldýðýný kontrol etmek için
int 16h     ; alýnan tuþ kodu AH'ya atanýr
; kullanýcýnýn girdiði sayýya göre renk deðiþkenine atama yapalým
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
mov byte ptr [color2], 44h ; renk deðiþkenine 4 (kýrmýzý) atama
jmp done2

blue2:
mov byte ptr [color2], 11h ; renk deðiþkenine 1 (mavi) atama
jmp done2

green2:
mov byte ptr [color2], 22h ; renk deðiþkenine 2 (yeþil) atama
jmp done2

yellow2:
mov byte ptr [color2], 66h ; renk deðiþkenine 6 (sarý) atama
jmp done2

done2:
mov ah, 00 ; rengi ayarlamak için
mov bh, 00 ; arka plan rengini ayarlamak için
mov bl, [color2] ; renk deðiþkenindeki deðere göre BL kaydedicisine renk atama

MOV     DL, 35   ; current column.
MOV     DH, 18   ; current row.
MOV     BL, [color2]   ; current attributes. renk belirliyor

JMP next_char2 ; ilk satýrý yazdýrmak icin(kapý)

next_row2:
INC     DH
CMP     DH, 23  ; kapýnýn satýr sayýsý (23-18)
JE      stop_print2
MOV     DL, 35

next_char2:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '•'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

INC     DL
CMP     DL, 43  ;soldan kaçýncý konumdan sonra asagý inecegi 
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
MOV     BL, 08h   ; kapý kolu rengi

MOV     AH, 02h
INT     10h
MOV     AL, '•'
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
;yana  catý rengiyle ilgli yazý yazdý burada

mov ah, 00h ; klavyeden tuþa basýldýðýný kontrol etmek için
int 16h     ; alýnan tuþ kodu AH'ya atanýr
; kullanýcýnýn girdiði sayýya göre renk deðiþkenine atama yapalým
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
mov byte ptr [color3], 44h ; renk deðiþkenine 4 (kýrmýzý) atama
jmp done3

blue3:
mov byte ptr [color3], 11h ; renk deðiþkenine 1 (mavi) atama
jmp done3

green3:
mov byte ptr [color3], 22h ; renk deðiþkenine 2 (yeþil) atama
jmp done3

yellow3:
mov byte ptr [color3], 66h ; renk deðiþkenine 6 (sarý) atama
jmp done3

done3:
mov ah, 00 ; rengi ayarlamak için
mov bh, 00 ; arka plan rengini ayarlamak için
mov bl, [color3] ; renk deðiþkenindeki deðere göre BL kaydedicisine renk atama

MOV     DL, 38   ; current column.
MOV     DH, 5   ; current row.
MOV     BL, [color3]   ; current attributes. renk belirliyor

MOV SI,[1000H]
MOV [1000H],0

JMP cati ; ilk satýrý yazdýrmak icin

next_row_cati:

ADD     [1000H],1
MOV     CL,[1000H]

CMP     [1000H], 10 ; kapýnýn satýr sayýsý (23-18)
JE      stop_print_cati
MOV     DL, 39
MOV     DH,4
ADD     DH,CL 

cati:
; set cursor position at (DL,DH):
MOV     AH, 02h
INT     10h

MOV     AL, '•'
MOV     BH, 0
;MOV     CX, 1
MOV     AH, 09h
INT     10h

DEC     DL
INC     DH
CMP     DH, 14  ;soldan kaçýncý konumdan sonra asagý inecegi 
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
MOV     BL, 08h   ; kapý kolu rengi

MOV     AH, 02h
INT     10h
MOV     AL, '•'
MOV     BH, 0
MOV     CX, 1
MOV     AH, 09h
INT     10h

RET

END