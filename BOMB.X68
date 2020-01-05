; =============================================================================
; BOMB MANAGEMENT. IT IS AN AGENT.
; LOCAL MEMORY IS:
; +0 WORD X COORDINATE
; +2 WORD Y COORDINATE
; +4 WORD X SPEED
; +6 WORD Y SPEED
; =============================================================================

; -----------------------------------------------------------------------------
BOMBINIT
; INITALIZES A BOMB 
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - ASSUMES SCRHEIGH IS GREATER THAN 255
; -----------------------------------------------------------------------------
            MOVEM.W  D0,-(A7)
            MOVE.W  (BMNPOSX),(A0)         ; X POSITION 
            MOVE.W  (BMNPOSY),D0   
            ADD.W    #BOMBSIZE,D0                 
            MOVE.W   D0,2(A0)              ; Y POSITION           
            MOVE.W   #0,4(A0)              ; X SPEED 
            MOVE.W   #7,6(A0)              ; Y SPEED 
            MOVEM.W  (A7)+,D0
            RTS

; -----------------------------------------------------------------------------
BOMBUPD
; UPDATES A BOMB 
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.W  D0-D1,-(A7)
            MOVE.W  4(A0),D0                ; UPDATE COORDINATES
            SUB.W   D0,(A0)
            MOVE.W  6(A0),D0
            ADD.W   D0,2(A0)
.COLPLAY    MOVE.W  (A0),D0
            MOVE.W  2(A0),D1
            MOVE.W  #BOMBSIZE,D4
            MOVE.W  D4,D6
            MOVE.W  (PLRPOSX),D2
            MOVE.W  (PLRPOSY),D3
            MOVE.W  #PLRWIDTH,D5
            MOVE.W  #PLRHEIGH,D7
            JSR     UTLCHCOL
            TST.B   D0
            BEQ     .DMG
            JSR     AGLKILL  
            UTLSND .CATCH
            ADD.W   #BOMBSCORE,(PLRSCORE)  
.END        MOVEM.W  (A7)+,D0-D1
            RTS
.KILL       JSR     AGLKILL
            BRA     .COLPLAY
.DMG        MOVE.W 2(A0),D0
            MOVE.W PLRPOSY,D1
            ADD.W  #PLRHEIGH,D1
            CMP D1,D0
            BMI .END
            SUB.W #BOMBDMG,PLRLIFE                        
            JSR     AGLKILL            
            BRA   .END  
.CATCH      DC.L 'SOUND/PING.WAV',0
; -----------------------------------------------------------------------------
BOMBPLOT
; PLOTS A BOMB 
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            UTLSPEN #BOMBPENCL
            UTLSFIL #BOMBFILCL
            MOVEM.W D1-D4,-(A7)
            MOVE.W  (A0),D1
            MOVE.W  2(A0),D2
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #BOMBSIZE,D3
            ADD.W   #BOMBSIZE,D4
            MOVE.B  #88,D0
            TRAP    #15
            MOVEM.W (A7)+,D1-D4
            RTS

; -----------------------------------------------------------------------------
BOMBXPLO
; EXPLODES A BOMB 
; INPUT    - A0 POINTER TO THE LOCAL MEMORY
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1-A3/D0-D4,-(A7)
            MOVE.W  #BOMBFRAG,D4
.LOOP       LEA     XPLINIT,A1
            LEA     XPLUPD,A2
            LEA     XPLPLOT,A3
            MOVE.W  #XPLTYPE,D0
            MOVE.W  (A0),D1
            ADD.W   #BOMBSIZE/2,D1
            MOVE.W  2(A0),D2
            ADD.W   #BOMBSIZE/2,D2
            JSR     AGLADD
            DBRA.W  D4,.LOOP
            JSR     AGLKILL
            MOVEM.L (A7)+,A1-A3/D0-D4
            RTS











*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
