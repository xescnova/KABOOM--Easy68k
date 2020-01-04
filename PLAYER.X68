; =============================================================================
; PLAYER MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
PLRINIT
; INITIALIZES THE PLAYER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(PLRPOSX)
            MOVE.W  #(SCRHEIGH-PLRHEIGH)-25,(PLRPOSY)
            MOVE.W  #3,PLRLIFE 
            CLR.W   (PLRSCORE)
            RTS

; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
       
.NODMG      MOVE.W  D1,-(A7)
            MOVE.B  (KBDVAL),D1             ; PERFORM MOTION AND CHECK BOUNDS.
            ROR.B   #1,D1
            BCC     .CHKRT
            SUB.W   #PLRSPEED,(PLRPOSX)
            TST.W   (PLRPOSX)
            BGE     .CHKRT
            CLR.W   (PLRPOSX)
.CHKRT      ROR.B   #2,D1
            BCC     .NOFIRE
            ADD.W   #PLRSPEED,(PLRPOSX)
            CMP.W   #SCRWIDTH-PLRWIDTH,(PLRPOSX)
            BLE     .NOFIRE
            MOVE.W  #SCRWIDTH-PLRWIDTH,(PLRPOSX)
.NOFIRE     MOVE.W  (A7)+,D1
            RTS

; -----------------------------------------------------------------------------
PLRPLOT
; PLOTS THE PLAYER ITS LIFE AND THE SCORE
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D7,-(A7)
            MOVE.L  #PLRNRMCL,D1            ; DECIDE COLOR
            BCLR.B  #PLRPBDMG,(PLRDMG)
            BEQ     .NODMG
            MOVE.L  #PLRDMGCL,D1
.NODMG      MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15
            
            MOVE.W  (PLRPOSX),D1            ; PLOT THE PLAYER
            MOVE.W  (PLRPOSY),D2
            
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #PLRWIDTH,D3
            ADD.W   #PLRHEIGH,D4
            MOVE.B  #87,D0
            TRAP    #15

            UTLSPEN #PLRTXTCL               ; PLOT THE SCORE TEXT
            UTLSFIL #$00000000
            UTLLOCT PLRTXTX,PLRTXTY
            LEA     .SCORESTR,A1
            CLR.L   D1
            MOVE.W  (PLRSCORE),D1
            MOVE.B  #17,D0
            TRAP    #15
            MOVE.W PLRLIFE,D5
            SUBQ.W #1,D5
            
            MOVE.W  #520,D6
            MOVE.W  #530,D7
            
.HEART      UTLSPEN #$000000FF              ;PLOT THE HEARTS
            UTLSFIL #$000000FF
            
            ; FIRST LINE OF SQUARE
            MOVE.L  D7,D1
            MOVE.L  #15,D2
            ADD.L   #10,D7
            MOVE.L  D7,D3
            SUB.L   #10,D7
            MOVE.L  #25,D4
            MOVE.B  #84,D0
            TRAP    #15
            
            ; SECOND LINE OF SQUARE
            MOVE.L  D7,D1
            MOVE.L  #35,D2
            MOVE.B  #85,D0
            TRAP    #15
            
            ;THIRD LINE OF SQUARE
            MOVE.L  D6,D1
            MOVE.L  #25,D2
            MOVE.B  #85,D0
            TRAP    #15
            
            ; FOURTH LINE OF SQUARE
            MOVE.L  D7,D1
            MOVE.L  #15,D2
            MOVE.B  #85,D0
            TRAP    #15
            
            ; LEFT CIRCLE
            SUB.L  #12,D7
            MOVE.L  D7,D1
            MOVE.L  #13,D2
            ADD.L  #14,D7
            MOVE.L  D7,D3
            MOVE.L  #27,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ; RIGHT CIRCLE
            SUB.L  #4,D7
            MOVE.L  D7,D1
            MOVE.L  #13,D2
            ADD.L  #14,D7
            MOVE.L  D7,D3
            MOVE.L  #27,D4
            MOVE.B  #88,D0
            TRAP    #15
            
            ; RESTORE D7 VALUE
            SUB.L   #12,D7
            
            ; FILL HEART
            MOVE.L  D7,D1
            MOVE.L  #30,D2
            MOVE.B  #89,D0
            TRAP    #15

            ADD.L   #40,D6
            ADD.L   #40,D7
            DBRA D5,.HEART
            MOVEM.L (A7)+,D0-D7
            RTS
.SCORESTR   DC.B    'SCORE: ',0























*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
