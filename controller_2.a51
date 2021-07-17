org 0000h
	mov 70h,#'1'
mov 71h,#'2'
mov 72h,#'3'
mov 73h,#'4'
jmp st
;defining functions for lcd
command:
mov p2,a
clr p1.0
clr p1.1
setb p1.2
acall delay
clr p1.2
acall delay
acall delay
ret 

write:
;lcall ready
mov p2,a
setb p1.0
clr p1.1
setb p1.2
acall delay
clr p1.2
acall delay
acall delay
ret

ready:
setb p2.7
clr p1.0
setb p1.1
wait:
clr p1.2
acall delay
setb p1.2
jb p2.7,wait
ret

delay:
mov r0,#1ch
rep:
djnz r0,rep
ret

delay_1s:
mov r3,#08h
df1s:
mov r2,#0ffh
d1s:
mov r1,#0ffh
de1s:
djnz r1,de1s
djnz r2,d1s
djnz r3,df1s
ret
pt2:
jmp mode2
;start of program

st:

port_ini:
mov p2,#00h
setb p1.0
setb p1.1
setb p1.2
acall delay_1s

Lcd_ini:
acall lcd

Display:
mov a,#'E'
acall write
mov a,#'n'
acall write
mov a,#'t'
acall write
mov a,#'e'
acall write
mov a,#'r'
acall write
mov a,#14h
acall command 
mov a,#'m'
acall write
mov a,#'o'
acall write



mov a,#'d'
acall write
mov a,#'e'
acall write

mov a,#14h
acall command

mov a,#'1'
acall write
mov a,#'o'
acall write
mov a,#'r'
acall write
mov a,#'2'
acall write


mov tmod,#20h
mov th1,#-6
mov scon,#50h
setb tr1
jnb ri,$
	mov a,sbuf
	clr ri
	cjne a,#'1',pt2
here:jnb ri,here
mov a,sbuf
mov 50h,a
clr ri
jnb ri,$
mov a,sbuf
mov 51h,a
clr ri
jnb ri,$
mov a,sbuf
mov 52h,a
clr ri
jnb ri,$
mov a,sbuf
mov 53h,a
clr ri
jnb ri,$
mov a,sbuf
mov 54h,a
clr ri
jnb ri,$
mov a,sbuf
mov 55h,a
clr ri
jnb ri,$
mov a,sbuf
mov 56h,a
clr ri
jnb ri,$
mov a,sbuf
mov 57h,a
clr ri
jnb ri,$
mov a,sbuf
mov 58h,a
clr ri
jnb ri,$
mov a,sbuf
mov 59h,a
clr ri
jnb ri,$
mov a,sbuf
mov 60h,a
clr ri
jnb ri,$
mov a,sbuf
mov 61h,a
clr ri


acall lcd


mov a,50h
acall write
mov a,51h
acall write
mov a,52h
acall write
mov a,53h
acall write
mov a,54h
acall write

mov a,55h
acall write
mov a,56h
acall write
mov a,57h
acall write
mov a,58h
acall write
mov a,59h
acall write
mov a,60h
acall write
mov a,61h
acall write

jnb ri,$
	mov a,sbuf
	clr ri
	mov 62h,a

	
	
	;reinitializing lcd
acall lcd


mov a,62h	
cjne a,#'#',con
jmp intofh
con:

acall write	

DELAYfornumdisplay: 
mov r5,#4d

a1:
MOV R6,#250D
       MOV R7,#250D
LOOP1: DJNZ R6,LOOP1
LOOP2: DJNZ R7,LOOP1
LOOP3: DJNZ R5,a1



	;reinitializing lcd
acall lcd

intofh:
mov a,62h
cjne a,#'1',c1
	jmp ais1
	c1:
	cjne a,#'2',c2
	jmp ais2
	c2:
	cjne a,#'3',c3
	jmp ais3
	c3:
	cjne a,#'4',c4
	jmp ais4
	c4:
	jmp st




//name writing
ais1:

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write



mov a,#0c0h
acall command

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jmp cwe


;i am doing.....
ais2:

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

mov a,#0c0h
acall command

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jmp cwe


;this is project 2

ais3:
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write




jnb ri,$
mov a,sbuf
clr ri
acall write
mov a,#0c0h
acall command

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write


jmp cwe


;dept of.....
ais4: 
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

mov a,#0c0h
acall command

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write


jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write

jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write
jnb ri,$
mov a,sbuf
clr ri
acall write



cwe:

acall DELAYforstring
jmp d111

DELAYforstring: 
mov r5,#14d

sa1:
MOV R6,#250D
      MOV R7,#250D
sLOOP1: DJNZ R6,sLOOP1
sLOOP2: DJNZ R7,sLOOP1
sLOOP3: DJNZ R5,sa1
ret
d111:



jmp here

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mode2:


ch:
mode2_port_ini:
mov p2,#00h
setb p1.0
setb p1.1
setb p1.2
acall delay_1s
jmp ss

Lcd:
mov a,#38h
acall command
mov a,#06h
acall command
mov a,#0ch
acall command
mov a,#01h
acall command
mov a,#80h
acall command
acall delay_1s
ret
ss:
acall lcd

mode2Display:

mov a,#'E'
acall write
mov a,#'n'
acall write
mov a,#'t'
acall write
mov a,#'e'
acall write
mov a,#'r'
acall write
mov a,#14h
acall command 
mov a,#'c'
acall write
mov a,#'o'
acall write



mov a,#'d'
acall write
mov a,#'e'
acall write


jmp path
ptos:
jmp star
path:
jnb ri,$
acall lcd



mov a,sbuf
clr ri
cjne a,#'*',nptos
jmp ptos
nptos:
cjne a,#'#',nhash
jmp st
nhash:
cjne a,#'0',nzn
jmp zn
nzn:

mov 74h,a
clr ri

jnb ri,$
mov a,sbuf
cjne a,#'#',nhash1
jmp st
nhash1:
mov 75h,a
clr ri

jnb ri,$
mov a,sbuf
cjne a,#'#',nhash2
jmp st
nhash2:
mov 76h,a
clr ri

jnb ri,$
mov a,sbuf
cjne a,#'#',nhash3
jmp st
nhash3:
mov 77h,a
clr ri


mov a,74h
cjne a,70h,ic
mov a,75h
cjne a,71h,ic
mov a,76h
cjne a,72h,ic
mov a,77h
cjne a,73h,ic
jmp o00
lpa:
jmp lcd

o00:


mov a,#'D'
acall write
mov a,#'o'
acall write
mov a,#'o'
acall write
mov a,#'r'
acall write
mov a,#' '
acall write
mov a,#'o'
acall write
mov a,#'p'
acall write
mov a,#'e'
acall write
mov a,#'n'
acall write
 acall DELAYforstring
 jmp ch
ic:
mov a,#'I'
acall write
mov a,#'n'
acall write
mov a,#'c'
acall write
mov a,#'o'
acall write
mov a,#'r'
acall write
mov a,#'r'
acall write
mov a,#'e'
acall write
mov a,#'c'
acall write
mov a,#'t'
acall write
mov a,#' '
acall write
mov a,#'c'
acall write
mov a,#'o'
acall write
mov a,#'d'
acall write
mov a,#'e'
acall write
acall DELAYforstring
jmp ch

star:
mov a,#'d'
acall write
mov a,#'o'
acall write
mov a,#'o'
acall write
mov a,#'r'
acall write
mov a,#' '
acall write
mov a,#'c'
acall write
mov a,#'l'
acall write
mov a,#'o'
acall write
mov a,#'s'
acall write
mov a,#'e'
acall write
mov a,#'d'
acall write

acall DELAYforstring
jmp ch



zn:
mov a,#'e'
acall write
mov a,#'n'
acall write
mov a,#'t'
acall write
mov a,#'e'
acall write
mov a,#'r'
acall write
mov a,#' '
acall write

mov a,#'c'
acall write
mov a,#'u'
acall write
mov a,#'r'
acall write
mov a,#'r'
acall write
mov a,#'e'
acall write
mov a,#'n'
acall write
mov a,#'t'
acall write
mov a,#0c0h
acall command
mov a,#' '
acall write
mov a,#'c'
acall write
mov a,#'o'
acall write
mov a,#'d'
acall write
mov a,#'e'
acall write

jnb ri,$
	
mov a,sbuf
cjne a,#'#',nhash4
jmp st
nhash4:
mov 74h,a
clr ri

jnb ri,$

mov a,sbuf
;cjne a,#'#',nhash5
;jmp st
;nhash5:
mov 75h,a
clr ri

jnb ri,$

mov a,sbuf
;cjne a,#'#',nhash6
;jmp st
;nhash6:
mov 76h,a
clr ri

jnb ri,$
	
mov a,sbuf
;cjne a,#'#',nhash7
;jmp st
;nhash7:
mov 77h,a
clr ri

mov a,74h
cjne a,70h,aga0
mov a,75h
cjne a,71h,aga0
mov a,76h
cjne a,72h,aga0
mov a,77h
cjne a,73h,aga0
jmp aaaa
aga0:
jmp aga
aaaa:
acall lcd
mov a,#'E'
acall write
mov a,#'n'
acall write
mov a,#'t'
acall write
mov a,#'e'
acall write
mov a,#'r'
acall write
mov a,#' '
acall write
mov a,#'n'
acall write
mov a,#'e'
acall write
mov a,#'w'
acall write
mov a,#' '
acall write
mov a,#'c'
acall write
mov a,#'o'
acall write
mov a,#'d'
acall write
mov a,#'e'
acall write

jnb ri,$
	
mov a,sbuf
cjne a,#'#',nhash8
jmp st
nhash8:
mov 70h,a
clr ri

jnb ri,$
	
mov a,sbuf
cjne a,#'#',nhash9
jmp st
nhash9:
mov 71h,a
clr ri

jnb ri,$

mov a,sbuf
cjne a,#'#',nhash10
jmp st
nhash10:
mov 72h,a
clr ri

jnb ri,$

mov a,sbuf
	cjne a,#'#',nhash11
jmp st
nhash11:
mov 73h,a
clr ri
jmp ch
;jmp en
aga:



jmp mode2
	


;en:


;jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



end