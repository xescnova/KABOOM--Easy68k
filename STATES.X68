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
            JSR     STAINTRP
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
            JSR     BMNUPD
            JSR     BMNPLOT   
            JSR     PLRUPD
            JSR     PLRPLOT          
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

.TITSTR     DC.B    'STAR FIGHTER 68000',0
.PRSSTR     DC.B    'PUSH FIRE TO START',0
            DS.W    0

; -----------------------------------------------------------------------------
*STAGOVRU
*; GAME OVER STATE UPDATE
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------
*            BTST.B  #KBDBITF1,(KBDEDGE)
*            BEQ     .END
*            MOVE.W  #STAINTR,(STANEXT)
*.END        RTS

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
