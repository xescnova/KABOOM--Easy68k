; =============================================================================
; GAME STATE MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
STAINIT
; INITALIZES THE STATE MANAGER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            LEA.L   STATES,A2
            MOVE.L  1*4(A2),STATE 
            RTS
; -----------------------------------------------------------------------------
STAMENU
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------          
            LEA.L   STATESP,A3
            MOVE.L  (A3),STATEP   
            BTST.B  #4,KBDEDGE              ; IF "SPACE" IS PRESED
            BEQ     .END
            LEA.L   STATES,A2               ; A0 = STATES LIST
            MOVE.L  2*4(A2),STATE           ; UPDATES NEXT STATE
.END        RTS
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
STAGAME 
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
             JSR PLRINIT
             JSR BMNINIT            
             LEA.L   STATES,A2               ; A0 = STATES LIST
             MOVE.L  3*4(A2),STATE           ; STATE = STAUPDA
             RTS


STAUPD
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            LEA.L   STATESP,A3
            MOVE.L  1*4(A3),STATEP           ;UPDATE GAME PLOT
            TST.W   (PLRLIFE)                      
            BGE     .NOTOVER    
            LEA.L    STATES,A2
            MOVE.L  5*4(A2),STATE
            JMP     .FIN
.NOTOVER    BTST.B  #7,KBDEDGE
            BEQ     .NEXT
            LEA.L   STATES,A2               ; A0 = STATES LIST
            MOVE.L  4*4(A2),STATE           ; STATE = STAPAUS  
.NEXT       JSR     BMNUPD
            JSR     PLRUPD 
            JSR     SPWUPD
            JSR     AGLUPD           
.FIN        RTS


STAUPDP
; PERFORMS STATE UPDATE AND INIT IF NECESSARY
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     PLRPLOT      
            JSR     BMNPLOT            
            JSR     AGLPLOT    
.END        RTS
; -----------------------------------------------------------------------------


STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
             MOVE.L     STATEP,A4
             JSR        (A4)
             RTS

STAINTRP
; INTRO STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L A1/D0-D1,-(A7)
            UTLLOCT INTTITX,INTTITY
            UTLSPEN #INTTITC
            UTLSFIL #$00000000
            LEA     .TITSTR,A1
            MOVE.B  #14,D0
            TRAP    #15

            UTLLOCT INTPRSX,INTPRSY
            UTLSPEN #INTPRSC
            UTLSFIL #$00000000
            LEA     .PRSSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVEM.L (A7)+,A1/D0-D1
            RTS

.TITSTR     DC.B    'KABOOM! 68000',0
.PRSSTR     DC.B    'PUSH FIRE TO START',0
            DS.W    0


; -----------------------------------------------------------------------------
STAPAUS
; PERFORMS STATE PAUSED
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            LEA.L   STATESP,A3               ; A3 = STATES LIST
            MOVE.L  2*4(A3),STATEP           ; STATEP = STAUPAUSP           
            BTST.B  #7,KBDEDGE
            BEQ     .NEXT
            LEA.L   STATES,A2               ; A0 = STATES LIST
            MOVE.L  3*4(A2),STATE           ; STATE = STAPAUS 
.NEXT       RTS
       
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
STAPAUSP
; PERFORMS STATE PAUSED
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------     
            JSR     PLRPLOT      
            JSR     BMNPLOT            
            JSR     AGLPLOT      
            UTLLOCT PAUSTITX,PAUSTITY
            UTLSPEN #INTTITC
            UTLSFIL #$00000000
            LEA     .PAUSSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
.NEXT       RTS


            
.PAUSSTR    DC.B    'GAME PAUSED PUSH "P" TO START',0
; -----------------------------------------------------------------------------

; -----------------------------------------------------------------------------
STAGOVRU
; GAME OVER STATE UPDATE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
*           LEA.L   STATESP,A3               ; A0 = STATES LIST
            MOVE.L  3*4(A3),STATEP           ; UPDATES NEXT STATE
            BTST.B  #4,KBDEDGE
            BEQ     .END
            LEA.L   STATES,A2               ; A0 = STATES LIST
            MOVE.L  2*4(A2),STATE           ; UPDATES NEXT STATE
.END        RTS

; -----------------------------------------------------------------------------
STAGOVRP
; GAME OVER STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------           
            MOVEM.L A1/D0-D1,-(A7)
            UTLLOCT GOVSTRX,GOVSTRY
            UTLSPEN #GOVSTRC
            UTLSFIL #$00000000
            LEA     .GOVSTR,A1
            MOVE.B  #14,D0
            TRAP    #15
            MOVEM.L (A7)+,A1/D0-D1
            RTS

.GOVSTR     DC.B    'GAME  OVER',0
            DS.W    0



















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
