ORG 0
	
		LCD EQU P2
		RS BIT P3.5
		RW BIT P3.6
		EN BIT P3.7
		MOV 40H,#49
		MOV 41H,#50
		MOV 42H,#51
		MOV 43H,#52
		
	LJMP MAIN2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	ORG 23H						// SERIAL INTERRUPTS
		LJMP SERIAL					
	
	ORG 40H
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	SERIAL:					// SERIAL SUBROUTINE
		JB TI,TRANS1			// CONDITION TO CHECK INTERRUPT DUE TO TRANSM
		MOV A,SBUF						
		CLR RI					// CLEAR RI FOR NEXT DATA
		RETI					
		TRANS1:	
		CLR TI					
		RETI		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ORG 80H								

MAIN2:
		MOV TMOD,#20H			
		MOV TH1,#-3				// BAUD RATE 9600
		MOV SCON,#50H
		MOV IE,#10010000B
		SETB TR1
		LCALL LLCDD_INI

MAIN:						//			MAIN STARTS
		LCALL MODE_SELECTION
		CJNE A,#48,MAIN1
		LCALL MODE1
		LJMP EXIT
		MAIN1: LCALL MODE2	
		LJMP EXIT
	//										MAIN ENDS
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	MODE1:	
	 PUSH 0
	 PUSH 1
	 PUSH 2
		MOV DPTR,#MODE_1TABLE
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		DO0_M1:
		MOV DPTR,#ENTER_NUMBER
		LCALL TRANSFER_STRING
		JZ $
		MOV R2,A
		LCALL LCD_CLR
		CJNE R2,#35,DO1_M1
		LJMP EXIT_MODE1
		DO1_M1:
		MOV A,R2
		LCALL WRITEDATAONLCD
		LCALL DELAY1SEC
		LCALL LCD_CLR
		MOV A,#0H
		DO5_M1:
		MOV R0,#2
		DO4_M1:		MOV R1,#16
		DO2_M1:
		JZ $
		CJNE A,#46,DO7_M1
		LJMP DO3_M1
		DO7_M1:
		LCALL WRITEDATAONLCD
		MOV A,#0H
		DJNZ R1,DO2_M1
		DJNZ R0,DO6_M1
		LCALL LCD_CLR
		LJMP DO5_M1
		DO6_M1:
		LCALL LCD_2LINE
		LJMP DO4_M1
		DO3_M1:
		LCALL DELAY1SEC
		LCALL DELAY1SEC
		LJMP DO0_M1			 
		EXIT_MODE1:
	 POP 2
	 POP 1
	 POP 0
	RET
	//											MODE 1 ENDS
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//											MODE 2 STARTS
	MODE2:	
	PUSH 0
	PUSH 1
		MOV DPTR,#MODE_2TABLE
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		MODE_2_START:
		MOV DPTR,#ENTER_CODE
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		JZ $
		MOV R0,A
		LCALL LCD_CLR
		MOV A,R0
		CJNE A,#35,DO0_M2
		LJMP EXIT_MODE2
		DO0_M2:
		MOV 44H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO1_M2
		LJMP EXIT_MODE2
		DO1_M2:	
		MOV 45H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO2_M2
		LJMP EXIT_MODE2
		DO2_M2:
		MOV 46H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO6_M2
		LJMP EXIT_MODE2
		DO6_M2:
		MOV 47H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		LCALL DELAY1SEC
		MOV A,44H
		CJNE A,40H,DO21_M2
		MOV A,45H
		CJNE A,41H,DO21_M2
		MOV A,46H
		CJNE A,42H,DO21_M2
		MOV A,47H
		CJNE A,43H,DO21_M2
		LJMP DO20_M2
		DO21_M2:
		LJMP INCR_CODE
		DO20_M2:
		MOV DPTR,#DOOR_OPEN
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		DO10_M2:
		MOV A,#0H
		JZ $
		CJNE A,#35,DO7_M2
		LJMP EXIT_MODE2
		DO7_M2:
		CJNE A,#42,DO8_M2
		MOV A,#0H
		CJNE A,#0,DO9_M2
		LCALL DELAY1SEC
		CJNE A,#0,DO9_M2
		LCALL DELAY1SEC
		CJNE A,#0,DO9_M2
		LCALL DELAY1SEC
		MOV DPTR,#DOOR_CLOSED
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		LCALL DELAY1SEC
		LJMP MODE_2_START
		DO9_M2:
		CJNE A,#48,DO10_M2
		MOV A,#0H
		JZ $
		CJNE A,#35,DO8_M2
		LJMP EXIT_MODE2
		DO8_M2:
		CJNE A,#42,DO10_M2
		MOV DPTR,#OLD_CODE
		LCALL TRANSFER_STRING
		JZ $
		CJNE A,#35,DO11_M2
		LJMP EXIT_MODE2
		DO11_M2:
		MOV 44H,A
		LCALL LCD_CLR
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO12_M2
		LJMP EXIT_MODE2
		DO12_M2:
		MOV 45H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO13_M2
		LJMP EXIT_MODE2
		DO13_M2:
		MOV 46H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO14_M2
		LJMP EXIT_MODE2
		DO14_M2:
		MOV 47H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		LCALL DELAY1SEC
		MOV A,44H
		CJNE A,40H,DO23_M2
		MOV A,45H
		CJNE A,41H,DO23_M2
		MOV A,46H
		CJNE A,42H,DO23_M2
		MOV A,47H
		CJNE A,43H,DO23_M2
		LJMP DO22_M2
		DO23_M2:
		LJMP INCR_CODE
		DO22_M2:
		MOV DPTR,#PASS_CORR
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		MOV DPTR,#NEW_CODE
		LCALL TRANSFER_STRING
		JZ $
		MOV 44H,A
		CJNE A,#35,DO15_M2
		LJMP EXIT_MODE2
		DO15_M2:
		MOV A,#0H
		LCALL LCD_CLR
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO16_M2
		LJMP EXIT_MODE2
		DO16_M2:
		MOV 45H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO17_M2
		LJMP EXIT_MODE2
		DO17_M2:
		MOV 46H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		MOV A,#0H
		JZ $
		CJNE A,#35,DO18_M2
		LJMP EXIT_MODE2
		DO18_M2:
		MOV 47H,A
		MOV A,#42
		LCALL WRITEDATAONLCD
		LCALL DELAY1SEC
		MOV A,44H
		MOV 40H,A
		MOV A,45H
		MOV 41H,A
		MOV A,46H
		MOV 42H,A
		MOV A,47H
		MOV 43H,A
		MOV A,#0H
		MOV DPTR,#PASS_CHANG
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		LJMP MODE_2_START
		INCR_CODE:
		MOV DPTR,#INCORRECT_CODE
		LCALL TRANSFER_STRING
		LCALL DELAY1SEC
		LCALL DELAY1SEC
		LJMP MODE_2_START
		EXIT_MODE2:
		POP 1
		POP 0
	RET
	//											MODE 2 ENDS
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//								MODE SELECTION STARTS
	MODE_SELECTION:
			MOV DPTR,#MODE_TABLE
			LCALL TRANSFER_STRING
			JZ $
	RET
	//									
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//	LCD INITIALIZING STARTS
	LLCDD_INI:
		MOV A,#38H
		LCALL COMMAND
		LCALL DELAY_LCD
		MOV A,#0FH
		LCALL COMMAND
		LCALL DELAY_LCD
	RET
	//	LCD INITIALIZING ENDS
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	// 	LCD COMMAND STARTS
	COMMAND:
		MOV LCD,A
		CLR RS
		CLR RW
		SETB EN
		NOP
		NOP
		NOP
		CLR EN
		LCALL DELAY_LCD
	RET
	// 	LCD COMMAND ENDS	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//	LCD DATA WRITE STARTS
	WRITEDATAONLCD:
		MOV LCD,A
		SETB RS
		CLR RW
		SETB EN
		NOP
		NOP
		NOP
		CLR EN
		LCALL DELAY_LCD
	RET
	//	LCD DATA WRITE ENDS
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//	DELAY LCD STARTS OF ALMOST 55 mSEC
	DELAY_LCD:
			PUSH 0			
			PUSH 1
		MOV R0,#100
		D1:
		MOV R1,#255
		DJNZ R1,$
		DJNZ R0,D1
			POP 1
			POP 0
	RET
	//	DELAY LCD ENDS
		
	//	LCD CLEARS STARTS
	LCD_CLR:
		MOV A,#01H
		LCALL COMMAND
	RET
	//	LCD CLEARS ENDS	
	
	//	LCD SECOND LINE STARTS
	LCD_2LINE:
		MOV A,#0C0H
		LCALL COMMAND
	RET
	//	LCD SECOND LINE ENDS	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//			TRANSFER STRING TO LCD STARTS
	TRANSFER_STRING:
	PUSH 0
	PUSH 1
		LCALL LCD_CLR
		MOV A,#0H
		TS1:
		MOV R0,#2
		TS2:	MOV R1,#16
		TS3:	CLR A
		MOVC A,@A+DPTR
		JZ END_TS
		LCALL WRITEDATAONLCD
		INC DPTR
		DJNZ R1,TS5
		DJNZ R0,TS4
		LCALL LCD_CLR
		JMP TS1
		TS4:	LCALL LCD_2LINE
		JMP TS2
		TS5:
		JMP TS3
		END_TS:
	MOV A,#0H
	POP 1
	POP 0
	RET
	//			TRANSFER STRING TO LCD ENDS
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//									DELAY 1 SEC STARTS
	DELAY1SEC:
MOV R0 , #20
MOV TMOD , #1
DDELAYY:
MOV TH0,#75
MOV TL0,#253

SETB TR0
AABC: JNB  TF0, AABC
CLR TF0
CLR TR0
DJNZ R0,DDELAYY
RET;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	//									DELAY 1 SEC ENDS
		
	//					LOOKUP TABLES STARTS
		MODE_TABLE:			DB "Enter Mode (1 or 2)",0
		MODE_1TABLE:		DB "MODE 1",0
		MODE_2TABLE:		DB "MODE 2",0
		ENTER_NUMBER:		DB "Enter Number (1 to 4)",0
		ENTER_CODE:			DB "Enter Code",0
		DOOR_OPEN:			DB "Door Open",0
		INCORRECT_CODE:		DB "Incorrect Code",0
		OLD_CODE:			DB "Enter Old Code",0
		PASS_CORR:			DB "Password Correct",0
		NEW_CODE:			DB "Enter New Code",0
		PASS_CHANG:			DB "Password Changed",0
		DOOR_CLOSED:		DB "Door Closed",0
	//					LOOKUP TABLES ENDS
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	EXIT:
	LJMP MAIN
	
	END