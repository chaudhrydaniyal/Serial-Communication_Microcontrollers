ORG 00H
	mov 50h,#'1'
mov 51h,#'2'
mov 52h,#'3'
mov 53h,#'4'

jmp start
delayinkeypad:
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
start0:
mov a,#'#'
acall transfer
start:
	
;mode selection through keypad
MOV A,#11111111B // loads A with all 1's
MOV P0,#00000000B // initializes P0 as output port

BACK:MOV P1,#11111111B 
//clr p1.3// loads P1 with all 1's
     CLR P1.0  // makes row 1 low
     JB P1.4,NEXT1  // checks whether column 1 is low and jumps to NEXT1 if not low
     MOV A,#'1'   // loads a with 0D if column is low (that means key 1 is pressed)
     jmp rrr  // calls DISPLAY subroutine
	 NEXT1:
jb p1.5,back	 // checks whether column 2 is low and so on...
      MOV A,#'2'
      jmp rrr
	  

rrr:

acall delayinkeypad




//cjne a,#2d,n
mov tmod,#20h
mov th1,#-6
mov scon,#50h

setb tr1
acall transfer
cjne a,#'1',pt2
ast:
mov a,#'e'
acall transfer
mov a,#'n'

acall transfer
mov a,#'t'
acall transfer
mov a,#'e'
acall transfer
mov a,#'r'
acall transfer
mov a,#' '
acall transfer

mov a,#'n'
acall transfer
mov a,#'u'
acall transfer
mov a,#'m'
acall transfer
mov a,#'b'
acall transfer
mov a,#'e'
acall transfer
mov a,#'r'
acall transfer
jmp trrr
transfer:
mov sbuf,a
jnb ti,$
	clr ti
	ret
	
pt2:
	jmp mode2
	trrr:
	;numberselection
	numberselection:MOV P1,#11111111B // loads P1 with all 1's
 
 CLR P1.0  // makes row 1 low
     JB P1.4,ns1  // checks whether column 1 is low and jumps to NEXT1 if not low
     MOV A,#'1'   // loads a with 0D if column is low (that means key 1 is pressed)
      jmp nf // calls DISPLAY subroutine
	 ns1:
jb p1.5,ns2	 // checks whether column 2 is low and so on...
      MOV A,#'2'
	  jmp nf
	   ns2:
	   jb p1.6,ns3	 // checks whether column 2 is low and so on...
      MOV A,#'3'
	  jmp nf
	   ns3:
	   
	  setb p1.0
	  clr p1.1
	  jb p1.4,ns4
	  mov a,#'4'
	  jmp nf
	  
	  ns4:
	  clr p1.3
	  jb p1.6,n5
	  mov a,#'#'
	  jmp nf
	  n5:
	  jmp numberselection
	  nf:
	  mov r4,a
	  mov sbuf,a
	  jnb ti,$
	clr ti
	acall delayinkeypad
	mov a,r4
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
	jmp start
	
	
	
	
	
	
	
	//my name
	
	ais1:
	mov a,#'M'
acall transfer
acall delayfnd
acall delayfnd
acall delayfnd
jmp ag
DELAYfnd: 
mov r5,#8d

a1:
MOV R6,#250D
       MOV R7,#250D
LOOP1: DJNZ R6,LOOP1
LOOP2: DJNZ R7,LOOP1
LOOP3: DJNZ R5,a1
ret
ag:



mov a,#'y'
acall transfer
mov a,#' '
acall transfer
mov a,#'n'
acall transfer
mov a,#'a'
acall transfer
mov a,#'m'
acall transfer
mov a,#'e'
acall transfer
mov a,#' '
acall transfer
mov a,#'i'
acall transfer
mov a,#'s'
acall transfer
mov a,#' '
acall transfer
mov a,#'D'
acall transfer
mov a,#'a'
acall transfer
mov a,#'n'
acall transfer
mov a,#'i'
acall transfer
mov a,#'y'
acall transfer
mov a,#'a'
acall transfer
mov a,#'l'
acall transfer

jmp tcm



;i am doing serial project
ais2:
mov a,#'I'
acall transfer
acall delayfnd
acall delayfnd
acall delayfnd


mov a,#' '

acall transfer


mov a,#'a'
acall transfer
mov a,#'m'
acall transfer
mov a,#' '
acall transfer
mov a,#'d'
acall transfer

mov a,#'o'
acall transfer
mov a,#'i'
acall transfer
mov a,#'n'
acall transfer
mov a,#'g'
acall transfer
mov a,#' '
acall transfer
mov a,#'S'
acall transfer
mov a,#'e'
acall transfer
mov a,#'r'
acall transfer
mov a,#'i'
acall transfer
mov a,#'a'
acall transfer
mov a,#'l'
acall transfer
mov a,#' '
acall transfer
mov a,#'P'
acall transfer
mov a,#'r'
acall transfer
mov a,#'o'
acall transfer
mov a,#'j'
acall transfer
mov a,#'e'
acall transfer
mov a,#'c'
acall transfer	
mov a,#'t'
acall transfer	
jmp tcm


;this is project 2 of mi....


ais3:
mov a,#'T'
acall transfer
acall delayfnd
acall delayfnd
acall delayfnd


mov a,#'h'

acall transfer


mov a,#'i'
acall transfer
mov a,#'s'
acall transfer
mov a,#' '
acall transfer
mov a,#'i'
acall transfer

mov a,#'s'
acall transfer
mov a,#' '
acall transfer
mov a,#'P'
acall transfer
mov a,#'r'
acall transfer
mov a,#'o'
acall transfer
mov a,#'j'
acall transfer
mov a,#'e'
acall transfer
mov a,#'c'
acall transfer
mov a,#'t'
acall transfer
;mov a,#' '
;acall transfer
mov a,#'2'
acall transfer
;mov a,#' '
;acall transfer
mov a,#'o'
acall transfer
mov a,#'f'
acall transfer
mov a,#' '
acall transfer
mov a,#'M'
acall transfer
mov a,#'i'
acall transfer
mov a,#'c'
acall transfer	
mov a,#'r'
acall transfer
mov a,#'o'
acall transfer
mov a,#'c'
acall transfer
mov a,#'o'
acall transfer
mov a,#'n'
acall transfer	
mov a,#'t'
acall transfer
mov a,#'r'
acall transfer
mov a,#'o'
acall transfer
mov a,#'l'
acall transfer
mov a,#'l'
acall transfer	
mov a,#'e'
acall transfer
mov a,#'r'
acall transfer
jmp tcm


;dept of mechatronics
ais4:
mov a,#'D'
acall transfer
acall delayfnd
acall delayfnd
acall delayfnd


mov a,#'e'

acall transfer


mov a,#'p'
acall transfer
mov a,#'t'
acall transfer
mov a,#' '
acall transfer
mov a,#'o'
acall transfer

mov a,#'f'
acall transfer
mov a,#' '
acall transfer
mov a,#'M'
acall transfer
mov a,#'e'
acall transfer
mov a,#'c'
acall transfer
mov a,#'h'
acall transfer
mov a,#'a'
acall transfer
mov a,#'t'
acall transfer
mov a,#'r'
acall transfer
mov a,#'o'
acall transfer
mov a,#'n'
acall transfer
mov a,#'i'
acall transfer
mov a,#'c'
acall transfer
mov a,#'s'
acall transfer
mov a,#' '
acall transfer
mov a,#'E'
acall transfer
mov a,#'n'
acall transfer
mov a,#'g'
acall transfer	
mov a,#'i'
acall transfer
mov a,#'n'
acall transfer
mov a,#'e'
acall transfer
mov a,#'e'
acall transfer
mov a,#'r'
acall transfer	
mov a,#'i'
acall transfer
mov a,#'n'
acall transfer
mov a,#'g'
acall transfer
tcm:
DELAYforstring: 
mov r5,#14d

sa1:
MOV R6,#250D
      MOV R7,#250D
sLOOP1: DJNZ R6,sLOOP1
sLOOP2: DJNZ R7,sLOOP1
sLOOP3: DJNZ R5,sa1
jmp ast







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



mode2:
ch:
jmp m2s
entern:
MOV P1,#11111111B // loads P1 with all 1's
 
 CLR P1.0  // makes row 1 low
     JB P1.4,ms1  // checks whether column 1 is low and jumps to NEXT1 if not low
     MOV A,#'1'   // loads a with 0D if column is low (that means key 1 is pressed)
      jmp mf // calls DISPLAY subroutine
	 ms1:
jb p1.5,ms2	 // checks whether column 2 is low and so on...
      MOV A,#'2'
	  jmp mf
	   ms2:
	   jb p1.6,ms3	 // checks whether column 2 is low and so on...
      MOV A,#'3'
	  jmp mf
	   ms3:
	   
	  setb p1.0
	  clr p1.1
	  jb p1.4,ms4
	  mov a,#'4'
	  jmp mf
	  
	  ms4:
	  jb p1.5,ms5
	  mov a,#'5'
	  jmp mf
	  ms5:
	  jb p1.6,ms6
	  mov a,#'6'
	  jmp mf
	  ms6:
	  setb p1.1
	  clr p1.2
	  jb p1.4,ms7
	  mov a,#'7'
	  jmp mf
	  ms7:
	  jb p1.5,ms8
	  mov a,#'8'
	  jmp mf
	  ms8:
	  jb p1.6,ms9
	  mov a,#'9'
	  jmp mf
	  ms9:
	  setb p1.2
	  clr p1.3
	  jb p1.4,ms10
	  mov a,#'*'
	  jmp mf
	  ms10:
	  jb p1.5,ms11
	  mov a,#'0'
	  jmp mf
	  ms11:
	  jb p1.6,ms12
	  mov a,#'#'
	  jmp mf
	  ms12:
	  jmp entern
	  mf:
	  
	  acall delayinkeypad
ret
m2s:
acall entern
cjne a,#'*',nstar

jmp star
nstar:
cjne a,#'#',nhash
jmp start0
nhash:
mov 70h,a

acall entern
cjne a,#'#',nhash1
jmp start0
nhash1:
mov 71h,a
acall entern
cjne a,#'#',nhash2
jmp start0
nhash2:
mov 72h,a
acall entern
cjne a,#'#',nhash3
jmp start0
nhash3:
mov 73h,a

mov a,70h
acall transfer
acall delayfnd
acall delayfnd

mov a,71h

acall transfer
mov a,72h
acall transfer
mov a,73h
acall transfer
jmp m2s
star:
mov r0,#16

star1:
mov r1,#255
star11:
mov r2,#255
star111:
MOV P1,#11111111B // loads P1 with all 1's
 
 CLR P1.3  // makes row 1 low
     JB P1.5,o1  // checks whether column 1 is low and jumps to NEXT1 if not low
     MOV A,#'0'   // loads a with 0D if column is low (that means key 1 is pressed)
      jmp oo //
	  o1:
	  djnz r2,star111
	  djnz r1,star11
	  djnz r0,star1
	  
	  
mov a,#'*'
acall transfer
jmp ok
oo:


mov a,#'0'

acall transfer
	  acall delayinkeypad



acall entern
cjne a,#'#',nhash4
jmp start0
nhash4:
mov 70h,a


acall entern
cjne a,#'#',nhash5
jmp start0
nhash5:
mov 71h,a

acall entern
cjne a,#'#',nhash6
jmp start0
nhash6:
mov 72h,a

acall entern
cjne a,#'#',nhash7
jmp start0
nhash7:
mov 73h,a

mov a,70h
acall transfer
acall delayfnd
acall delayfnd
mov a,71h
acall transfer
mov a,72h
acall transfer
mov a,73h
acall transfer
compp:
mov a,70h
cjne a,50h,wrong
mov a,71h
cjne a,51h,wrong
mov a,72h
cjne a,52h,wrong
mov a,73h
cjne a,53h,wrong


acall entern
cjne a,#'#',nhash8
jmp start0
nhash8:
mov 70h,a
acall entern
cjne a,#'#',nhash9
jmp start0
nhash9:
mov 71h,a

acall entern
cjne a,#'#',nhash10
jmp start0
nhash10:
mov 72h,a

acall entern
cjne a,#'#',nhash11
jmp start0
nhash11:
mov 73h,a

mov a,70h
acall transfer
acall delayfnd
acall delayfnd
mov a,71h
acall transfer
mov a,72h
acall transfer
mov a,73h
acall transfer

mov a,70h
mov 50h,a
mov a,71h
mov 51h,a
mov a,72h
mov 52h,a
mov a,73h
mov 53h,a
acall delayinkeypad
acall delayinkeypad
acall delayinkeypad

jmp ch


wrong:
;mov a,#'@'
;acall transfer
ok:
jmp ch



	jmp $   
	
	n:


END
