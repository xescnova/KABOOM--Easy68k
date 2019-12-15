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
*            MOVE.W  #STANONE,(STACUR)
*            MOVE.W  #STAINTR,(STANEXT)

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
*            MOVEM.L D0-D3/A0-A2,-(A7)
*            CLR.L   D0
*            MOVE.W  (STANEXT),D0
*            CMP.W   (STACUR),D0
*            BEQ     .DOUPD
*            MOVE.W  D0,(STACUR)             ; IF STATE CHANGED, DO INIT            
*            LSL.L   #2,D0
*            MOVE.L  D0,A0
*            MOVE.L  .INITBL(A0),A0
*            JSR     (A0)
*            
*            MOVE.L  (STACUR),D1             IF STATE IS PLAY
*            MOVE.L  #STAPLAY,D2
*            CMP.L    D2,D1
*            BNE     .DOUPD
*            MOVE.L  STABMNI(A1),A1
*            JSR     (A1)            
*          
*.DOUPD      CLR.L   D0                      ; IN ANY CASE, DO UPDATE
*            MOVE.W  (STACUR),D0
*            LSL.L   #2,D0
*            MOVE.L  D0,A0
*            MOVE.L  .UPDTBL(A0),A0
*            JSR     (A0)
*            
*            MOVE.L  (STACUR),D1            ;  IF STATE IS PLAY
*            MOVE.L  #STAPLAY,D2
*            CMP.L    D2,D1
*            BNE     .END
*            MOVE.L  STABMNU(A2),A2
*            JSR     (A2) 
*                        
*.END        MOVEM.L (A7)+,D0-D3/A0-A2
*            RTS

            
            JSR     PLRUPD
            BRA     PLRPLOT
            JSR     BMNUPD
            BRA     BMNPLOT
            RTS



            
*.INITBL     DC.L    STAINTRI,STAPLAYI,STAEMPTY
*.INITBM     DC.L    STAINTRI,STABMNI,STAEMPTY
*.UPDTBL     DC.L    STAINTRU,STAPLAYU,STAGOVRU
*.UPDTBM     DC.L    STAINTRU,STABMNU,STAGOVRU
; -----------------------------------------------------------------------------
*STAPLOT
; PERFORMS STATE PLOT
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------

*            MOVEM.L D0-D1/A0-A1,-(A7)
*            CLR.L   D0
*            MOVE.W  (STACUR),D0
*            LSL.L   #2,D0
*            MOVE.L  D0,A0
*            MOVE.L  .PLTTBL(A0),A0
*            JSR     (A0)
*            
*            MOVE.L  (STACUR),D1             ; IF STATE IS PLAY
*            MOVE.L  #STAPLAY,D2
*            CMP.L   D2,D1
*            BNE     .END1
*            MOVE.L  STABMNP(A1),A1
*            JSR     (A1)            
*                      
*.END1            MOVEM.L (A7)+,D0-D1/A0-A1
*            RTS
*.PLTTBL     DC.L    STAINTRP,STAPLAYP,STAGOVRP
*.PLTTBM     DC.L    STAINTRP,STABMNP,STAGOVRP

; -----------------------------------------------------------------------------
STAEMPTY
; EMPTY SUBROUTINE FOR CASES WITH NOTHING TO DO
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A PLACEHOLDER. NOTHING TO DO.
; -----------------------------------------------------------------------------
            RTS

; -----------------------------------------------------------------------------
*STAPLAYI     EQU     PLRINIT
; PLAY STATE INITIALIZATION.
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; NOTE     - JUST A WRAPPER FOR PLRINIT
; -----------------------------------------------------------------------------

*STABMNI     EQU     BMNINIT
*; PLAY STATE INITIALIZATION.
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; NOTE     - JUST A WRAPPER FOR BMNINIT
*; -----------------------------------------------------------------------------
*
*; -----------------------------------------------------------------------------
*STAPLAYU
*; PLAY STATE UPDATE
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------
*            JSR     PLRUPD
*            JSR     SPWUPD
*            JSR     BMNUPD
*            BRA     AGLUPD
*; -----------------------------------------------------------------------------
*STABMNU
*; PLAY STATE UPDATE
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------
*            JSR     BMNUPD
*; -----------------------------------------------------------------------------
*
*
*STAPLAYP
*; PLAY STATE PLOT
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------
*            JSR     AGLPLOT
*            BRA     PLRPLOT
*
*; -----------------------------------------------------------------------------
*
*STABMNP
*; PLAY STATE PLOT
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------            
*            BRA     BMNPLOT
*; -----------------------------------------------------------------------------
*STAINTRI    EQU     DMMINIT
*; INTRO STATE INIT
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; NOTE     - JUST A WRAPPER FOR DMMINIT TO RELEASE ALL MEMORY
*; -----------------------------------------------------------------------------
*
*; -----------------------------------------------------------------------------
*STAINTRU
*; INTRO STATE UPDATE
*; INPUT    - NONE
*; OUTPUT   - NONE
*; MODIFIES - NONE
*; -----------------------------------------------------------------------------
*            BTST.B  #KBDBITF1,(KBDEDGE)
*            BEQ     .END
*            MOVE.W  #STAPLAY,(STANEXT)
*.END        RTS
*
; -----------------------------------------------------------------------------
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
