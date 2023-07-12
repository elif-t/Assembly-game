Stack_Size       EQU     0x400;
	
				 AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem        SPACE   Stack_Size
__initial_sp

				 AREA    RESET, DATA, READONLY
                 EXPORT  __Vectors
                 EXPORT  __Vectors_End

__Vectors        DCD     __initial_sp               ; Top of Stack
                 DCD     Reset_Handler              ; Reset Handler
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	0
				 DCD	Button_Handler					 
__Vectors_End    

				 AREA    |.text|, CODE, READONLY
Reset_Handler    PROC
                 EXPORT  Reset_Handler
				 ldr	 r0, =0xE000E100
				 movs	 r1,#1	
				 str	 r1,[r0]						 
			     CPSIE	 i					 
                 LDR     R0, =__main
                 BX      R0
                 ENDP				 

				 AREA	 button, CODE, READONLY

Button_Handler	 PROC
				 EXPORT	 Button_Handler
				  
				 PUSH{R0}  ;Stack is empty.
				 PUSH{R1}
				 PUSH{R2}
				 PUSH{R3}
				 PUSH{R4}
				 PUSH{R5}
				 PUSH{R6}
				 PUSH{R7}
					 
				 ldr R0, =0x40010010 
				 ldr r7,[r0]		 		; Equalized the value that has button register value to register 7 value.
				 movs r6, r7		 		; Copying everything that has r6 to r7.
				 movs r2,#0xFC       		; 11111100 and r7 is AND'ed. Thus, only the button bits remained.
				 ands r7,r7,r2		 
			     ldr r4, =STATE_B			;state of button
				 str r7, [r4]		 		;Loaded the intentioned button to r7.
                 LDR R2,=0x00000010	 		;Checking the up button exists or not.
                 
				 cmp R7,R2			 
				 beq UP			 
	
				 LDR R2, =0X00000020		;check for down button
				 CMP R7, R2
				 BEQ DOWN
				 
				 LDR R2, =0x00000080		;check for right button
				 CMP R7, R2
				 BEQ RIGHT
				 
				 str r6,[r0]		 
				 POP{R7}			 		;Popped the pushed registers by LIFO.
				 POP{R6}
				 POP{R5}
				 POP{R4}
				 POP{R3}
				 POP{R2}
				 POP{R1}
				 POP{R0}
				  
				 bx lr
				 ENDP
					 
UP			 
                 str r6,[r0]			;The part up action is progress.
                 LDR R5,=C_S_PLAYER		;current state fo player
                 LDR R5,[R5]
				 LDR R3,=C_S_PLAYER_2	;current state of player 2
                 LDR R3,[R3]			;takes the upper and lower row boundary of the spacehip
                 SUBS R5,R5,#20			;and decreased them as amount of up.
				 SUBS R3,R3,#20
                 ldr R4, =LOC
				 str R5, [r4] 
				 ldr R4, =LOC_2
				 str R3, [r4] 
                 				 
                 POP{R7}
				 POP{R6}
				 POP{R5}
				 POP{R4}
				 POP{R3}
				 POP{R2}
				 POP{R1}
				 POP{R0}   
			     bx lr
				 
DOWN 	
				 str r6,[r0]		;The part down action is progress.
                 LDR R5,=C_S_PLAYER
                 LDR R5,[R5]
				 LDR R3,=C_S_PLAYER_2
                 LDR R3,[R3]		;takes the upper and lower row boundary of the player
                 ADDS R5,R5,#20		;and increased them as amount of down.
				 ADDS R3,R3,#20
                 ldr R4, =LOC
				 str R5, [r4] 
				 ldr R4, =LOC_2
				 str R3, [r4] 
                 				 
                 POP{R7}
				 POP{R6}
				 POP{R5}
				 POP{R4}
				 POP{R3}
				 POP{R2}
				 POP{R1}
				 POP{R0}   
			     bx lr
				 

RIGHT
				 str r6,[r0]		;The part right action is progress.
                 LDR R5,=C_S_PLAYER
                 LDR R5,[R5]
				 LDR R3,=C_S_PLAYER_2
                 LDR R3,[R3]		;takes the upper and lower row boundary of the player to apply fireball
                 ;SUBS R5,R5,#20	;and decreased them as amount of jump.
				 ;SUBS R3,R3,#20
                 ldr R4, =LOC		;to check go up or down 
				 str R5, [r4] 
				 ldr R4, =LOC_2
				 str R3, [r4] 
                 				 
                 POP{R7}
				 POP{R6}
				 POP{R5}
				 POP{R4}
				 POP{R3}
				 POP{R2}
				 POP{R1}
				 POP{R0}   
			     bx lr
				 

				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	STATE_B
STATE_B        	 DCD        0
				
    			 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	C_S_PLAYER
C_S_PLAYER       DCD        0	
	
                 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	C_S_PLAYER_2
C_S_PLAYER_2     DCD        0	
				 
				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	LOC
LOC        	 	 DCD        0	
				 
				 
				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	LOC_2
LOC_2        	 DCD        0		
 
				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	LEFT_B
LEFT_B        	 DCD        0	
				 
				 
				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	RIGHT_B
RIGHT_B        	 DCD        0

				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	LEFT_B_S
LEFT_B_S         DCD        0	
				 
				 
				 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	RIGHT_B_S
RIGHT_B_S        DCD        0
	
                 AREA    GLOBALS, DATA, READWRITE
				 ALIGN
				 EXPORT	refresh
refresh        	 DCD        0				 

                 AREA    main, CODE, READONLY
                 EXPORT	 __main			 ;make __main visible to linker
				 IMPORT image			 ;player -> spacehip
				 IMPORT image2			 ;meteor
				 IMPORT image3			 ;spaceship
				 IMPORT image4			 ;fireball
				 IMPORT image5			 ;game over
                 ENTRY
__main           PROC
				 LDR R3,  =320 				;Right boundary of the LCD 
                 ldr r4, =RIGHT_B
				 str r3, [r4]
				  LDR R3,  =0 				;last enemy cames later to make it RIGHT_B_S defined
                 ldr r4, =RIGHT_B_S			; right border for enemy sapceship
                 str r3, [r4]				 
				 LDR R6, = 270 				;320-50=270 the lower column boundary of the enemy.
                 ldr r4, =LEFT_B			;left boundary
				 str r6, [r4]
                 ldr r4, =LEFT_B_S			;left boundary for enemy spaceship
                 str r6, [r4]				 
	             LDR R7,=240				;Bottom boundary of the LCD
                 MOVS R3,#120				      				 		                 
				 ldr r4, =LOC_2 			;Bottom ROW edge of the spaceship character.
				 str r3, [r4] 
				 MOVS R5,#100				;Spaceship first position adjustment.
				 ldr r4, =LOC
				 str r5, [r4]
				 MOVS R5,#0
				 ldr r4, =refresh			;to clear enemies and refresh the page
				 str r5, [r4]				 
loop_4			 
				 BL  Draw					;Draws player(spacehip)
				 LDR R2,=80					; 80-30 = 50 meteor 50*50 to print meteor
                 LDR R5,=30					; 30 pixel below the top of lcd
                 LDR R0, =image2
				 BL Enemy					; first enemy draw
				 LDR R2,=210				; second enemy bottom of the lcd 30 pixel above bottom of lcd
                 LDR R5,=160			
				 LDR R0, =image2
				 BL Enemy				 	;second enemy draw
				 PUSH{R4}					
				 LDR R4, =LEFT_B		
				 LDR R6, [R4] 	
                 SUBS R3,R3,#2				;enemies move from right to left              	
                 SUBS R6,R6,#2
                 ldr r4, =RIGHT_B			
				 str r3, [r4]
				 ldr r4, =LEFT_B
				 str r6, [r4]                 				 
                 LDR R2,=150				;150-43=107
                 LDR R5,=107				;the row values of the last enemy 
				 LDR R0, =image3			;spacehip enemy 
                 LDR R4, =RIGHT_B_S			;For the first time score arrives 80, it is 0.
				 LDR R4, [R4]  
				 CMP R4,#0
				 BEQ wait
				 BL Enemy_s					; last enemy spacehip draw
wait
                 POP{R4}
				 PUSH{R4}
				 PUSH{R3}
				 PUSH{R6}
				 ldr R4,=refresh		
				 LDR R3, [R4]
				 ADDS r3,r3,#1		;in order to take the loop active, refresh is being incremented by 1.
				 ldr r4, =refresh
				 str r3, [r4]
				 CMP R3,#80			;refresh arrives 80, so the last enemy shows up.
				 BNE GO_2
				 LDR R3,  =320
				 ldr r4, =RIGHT_B_S
				 str r3, [r4]				 
				 LDR R6, = 240
                 ldr r4, =LEFT_B_S
				 str r6, [r4]				 
GO_2		     CMP R3,#80
				 BNE GO
				 LDR R3,  =320
				 ldr r4, =RIGHT_B
				 str r3, [r4]				 ;same logic maintains not for the middle but for the other obstacles.
				 LDR R6, = 240
                 ldr r4, =LEFT_B
				 str r6, [r4]
			     movs r3,#0
				 ldr r4, =refresh
				 str r3, [r4]
				 b GO				 
GO           
				 POP{R6}
				 POP{R3}
				 POP{R4}
				 PUSH{R7}  
                 MOVS R7, #1
			     STR R7, [R4,#0xC]      ;Refreshing LCD
                 MOVS R7, #2
				 STR R7, [R4,#0xC]		;Clearing LCD
										;Refresh method is obligatory to draw the images we uploaded.
				 POP{R7} 				;and with clear, we are processing the images totally.           				
				 PUSH {R1}			
				 PUSH {R2} 			
				 LDR R1,=STATE_B		
                 LDR R1,[R1]		
				 LDR R2,=0x00000010		; Button Up 		 
                 CMP R1,R2				; Checking the button up is pressed or not.
		         BNE CHECK_DOWN			; Checking the button up is pressed or not.
				 
GO_R			 POP {R2}
				 POP {R1}
				 PUSH {R7}
				 LDR R7,=0
				 LDR R4,=STATE_B
				 STR R7, [R4]
				 POP {R7}
				 LDR R7,=240
				 B loop_4

CHECK_DOWN		 LDR R2,=0x00000020			; Button DOWN 			 
                 CMP R1,R2
				 BNE CHECK_RIGHT			; if it is succeed go to branch "done".                
				 BEQ GO_R

CHECK_RIGHT		 LDR R2, =0x00000080		;button right
				 CMP R1, R2
				 BNE done
				 BEQ fireball
				
done             POP {R2}
				 POP {R1}                
				 B loop_4 
				 ;ENDP
;#########################################################################################					 
fireball		 ;PROC
				 LDR R1,=120
				 LDR R0, =image4	
                 LDR R4, =0x40010000	
	             LDR R6,=80
				 PUSH{R4}
				 ldr R4, =LOC		;Loads upper and low values of fireball
				 LDR R5, [R4] 		
				 LDR R4, =LOC_2		
				 LDR R3, [R4]						
				 ldr r4,=C_S_PLAYER		;Stores these values
				 str r5, [r4] 
				 ldr r4,=C_S_PLAYER_2
				 str r3, [r4]
				 ADDS R3,R3,#2		                	
                 ADDS R6,R6,#2
				 POP {R4}
loop_5f			 CMP R5,R3			;The loop that controls the rows 
                 BHS done_5f				 
loop_6f			 CMP R6, R1	 		;Loop that controls the columns	 	 
                 BHS done_6f
                 PUSH {R1}				 
                 STR R5, [R4]
				 STR R6, [R4, #0x4]				 

				 LDR R1, [R0] 			

                 REV R1, R1				;reverse 
				 MOVS R2, #8			 ;changing the order
				 RORS R1, R1, R2
                 ldr     r2, =0xff000000	;!!ff!! in order to make it opacity full.
				 orrs R1,R1,R2        
                 STR R1, [R4, #0x8]				 				 
                 ADDS R6, R6, #1          
				 ADDS R0, R0, #4			;next word
                 POP {R1}				 
				 B loop_6f
done_6f			 
                 ADDS R5,R5,#1
                 SUBS R6,R6,#40;		;increases the row by 1 and makes the column 0.                 				  
                 B loop_5f
done_5f			                
			     ;BX LR
				 B loop_4
				 ENDP
;#########################################################################################					 
Draw             PROC				;Draws the player
                 LDR R1,=40
				 LDR R0, =image	
                 LDR R4, =0x40010000	
	             LDR R6,=0
				 PUSH{R4}
				 ldr R4, =LOC		;Loads the player upper and lower row values.
				 LDR R5, [R4] 		
				 LDR R4, =LOC_2		
				 LDR R3, [R4]						
				 ldr r4,=C_S_PLAYER		;Stores these values
				 str r5, [r4] 
				 ldr r4,=C_S_PLAYER_2
				 str r3, [r4]
				 POP {R4}
loop_5			 CMP R5,R3			;checks rows
                 BHS done_5				 
loop_6			 CMP R6,R1	 		;checks columns	 	 
                 BHS done_6	
                 PUSH {R1}				 
                 STR R5, [R4]
				 STR R6, [R4, #0x4]				 

				 LDR R1, [R0] 			

                 REV R1, R1					;reverse 
				 MOVS R2, #8			 	;changing the order
				 RORS R1, R1, R2
                 ldr     r2, =0xff000000	;!!ff!! in order to make it opacity full.
				 orrs R1,R1,R2        
                 STR R1, [R4, #0x8]				 				 
                 ADDS R6, R6, #1          
				 ADDS R0, R0, #4			;next word
                 POP {R1}				 
				 B loop_6
done_6			 
                 ADDS R5,R5,#1
                 SUBS R6,R6,#40;			;increases the row by 1 and makes the column 0.                 				  
                 B loop_5
done_5			                
			     BX LR	     
				 ENDP
					 
Enemy 			 PROC        				;draws the upper and lower enemies
	             PUSH{LR}		 			;Pushes the linked register of the "engel" branch.
				 PUSH{R4}
				 ldr R4, =RIGHT_B		
				 LDR R3, [R4] 		 		
				 LDR R4, =LEFT_B		
				 LDR R6, [R4] 	
                 
                 POP{R4}			
				 
                 LDR R4, =0x40010000 		;LCD row register			  
                  
loop_7			 CMP R5,R2	 				;writing row by row 	
                 BHS done_7
				 
loop_8			 CMP R6,R3			 	 
                 BHS done_8 
                 PUSH {R2}						 
                 STR R5, [R4]     			;stores the row 
				 STR R6, [R4, #0x4]			;stores the column
                 
				 BL game_over				;checking if the player is touched any enemy or not.
				 
             	 LDR R1, [R0] 			 
				 REV R1, R1				 
				 MOVS R2, #8			 
               	 RORS R1, R1, R2
                 ldr     r2,=0xff000000
				 orrs R1,R1,R2   				 
                 STR R1, [R4, #0x8]
                 				 
                 ADDS R6, R6, #1         ; next column 
				 ADDS R0, R0, #4
                 POP {R2}				 ; next word
				 B loop_8
done_8			 ADDS R5, R5, #1
                 PUSH{R4}
				 LDR R4, =LEFT_B		
				 LDR R6, [R4]
				 POP{R4}
                 B loop_7
done_7			  
				 POP{PC}
                 BX LR	
                 ENDP

Enemy_s 		PROC
	            PUSH{LR}		 	; get the first adress of the image
				PUSH{R4}
				ldr R4, =RIGHT_B_S		
				LDR R3, [R4] 		;last enemy
				LDR R4, =LEFT_B_S	;these part is logically repeating enemy loop
				LDR R6, [R4] 	
             
                POP{R4}								 
                LDR R4, =0x40010000 			  
                  
Enemy_s_1		CMP R5,R2	 		; we are writing row by row 	
                BHS dn2_1
                 
Enemy_s_2		CMP R6,R3			 	 
                BHS dn2_2
                PUSH {R2}				 
                STR R5, [R4]
				STR R6, [R4, #0x4]
                 
				BL game_over
				 
             	LDR R1, [R0] 		
				REV R1, R1			
				MOVS R2, #8			 
               	RORS R1, R1, R2
                ldr  r2,=0xff000000				 
				orrs R1,R1,R2 
                STR R1, [R4, #0x8]
                 				 
                ADDS R6, R6, #1         ; next column 
				ADDS R0, R0, #4
                POP {R2}				 ; next word
				B Enemy_s_2
dn2_2			ADDS R5, R5, #1
                PUSH{R4}
				LDR R4, =LEFT_B_S	
				LDR R6, [R4]
				POP{R4}
                B Enemy_s_1
dn2_1			
                	
				PUSH{R4}
				LDR R4, =LEFT_B_S	
				LDR R6, [R4] 	
                SUBS R3,R3,#2
                 	
                SUBS R6,R6,#2
                ldr r4, =RIGHT_B_S
				str r3, [r4]
				ldr r4, =LEFT_B_S
				str r6, [r4]
                POP{R4}
                POP{PC}				  
                BX LR	
                ENDP

game_over   PROC					;this block checks the game is over or not
			PUSH{R7}
			PUSH{R2}
			PUSH{R4}        
			ldr R4, =LOC		    ;Loading the upper and lower boundary of the player
			LDR R7, [R4] 		
			LDR R4, =LOC_2			
			LDR R2, [R4]	
				
			CMP R6,#40				;checking if enemy is reached the 40th column or not.
            BEQ game1				;to check if crash happened
            POP{R4}
			POP{R2}
			POP{R7}			
			BX LR					
				
game1      CMP	r7,r5		;Checking the row of the enemy is crashing with upper boundary of the player.
           BEQ gameo
		   CMP r2,r5		;same process but for lower boundary.
		   BEQ gameo
		   POP{R4}			
		   POP{R2}
		   POP{R7}	   
		   BX LR

gameo    
           LDR R4, =0x40010000
           MOVS R7, #2					;game over and clearing the LCD for finish screen.
		   STR R7, [R4, #0xC]   
sonsuz
				 LDR R0, =image5		;Prints the game over image to the screen	               
				 LDR R4, =0x40010000    ;Logic of printing is same for any other image load and storing.
				 MOVS R5, #60 
                 LDR R1,=80
				 
loop_1			 CMP R5, R1				
                 BHS done_1				
                 MOVS R6,#80 
         		 LDR R2,=240
                				 
loop_2			 CMP R6,R2			 	 
                 BHS done_2
                				 
                 STR R5, [R4]
				 STR R6, [R4, #0x4]				 
	             LDR R1, [R0] 			 
				 REV R1, R1	
                 MOVS R2, #8				 
	             RORS R1, R1, R2
                 ldr  r2,=0xff000000
				 
				 orrs R1,R1,R2
                 STR R1, [R4, #0x8]				 				 
                 ADDS R6, R6, #1       
				 ADDS R0, R0, #4
                 LDR R2,=240				 
				 B loop_2
done_2			 ADDS R5, R5, #1
                   
                 LDR R1,=80				   
                 B loop_1
done_1			 MOVS R7, #1
				 STR R7, [R4, #0xC]   
 			     B sonsuz

				 ENDP
                 END
