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
            MOVE.W  #(SCRHEIGH-PLRHEIGH)-100,(PLRPOSY)
            MOVE.W  #PLRCLIFE,(PLRLIFE)
            CLR.W   (PLRSCORE)
            CLR.W   (PLRDMG)
            RTS
            
; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            BCLR.B  #PLRUBDMG,(PLRDMG)
            BEQ     .NODMG
            SUB.W   #PLRCLIFE,(PLRLIFE)
            BNE     .NODMG
            MOVE.W  #STAGOVR,(STANEXT)      ; IF LIFE IS 0, GAME OVER
.NODMG      MOVE.W  D1,-(A7)
            MOVE.B  (KBDVAL),D1             ; PERFORM MOTION AND CHECK BOUNDS.
            ROR.B   #1,D1
            BCC     .CHKUP
            SUB.W   #PLRSPEED,(PLRPOSX)
            TST.W   (PLRPOSX)
            BGE     .CHKUP
            CLR.W   (PLRPOSX)
.CHKUP      ROR.B   #1,D1
            BCC     .CHKRT
            SUB.W   #PLRSPEED,(PLRPOSY)
            TST.W   (PLRPOSY)
            BGE     .CHKRT
            CLR.W   (PLRPOSY)
.CHKRT      ROR.B   #1,D1
            BCC     .CHKDN
            ADD.W   #PLRSPEED,(PLRPOSX)
            CMP.W   #SCRWIDTH-PLRWIDTH,(PLRPOSX)
            BLE     .CHKDN
            MOVE.W  #SCRWIDTH-PLRWIDTH,(PLRPOSX)
.CHKDN      ROR.B   #1,D1
            BCC     .MDONE
            ADD.W   #PLRSPEED,(PLRPOSY)
            CMP.W   #SCRHEIGH-PLRHEIGH,(PLRPOSY)
            BLE     .MDONE
            MOVE.W  #SCRHEIGH-PLRHEIGH,(PLRPOSY)
.MDONE      BTST.B  #KBDBITF1,(KBDEDGE)
            BEQ     .NOFIRE
            MOVEM.L A1-A3/D0-D2,-(A7)
            LEA     SHTINIT,A1
            LEA     SHTUPD,A2
            LEA     SHTPLOT,A3
            MOVE.W  #SHTTYPE,D0
            MOVE.W  (PLRPOSX),D1
            MOVE.W  (PLRPOSY),D2
            JSR     AGLADD
            MOVEM.L (A7)+,A1-A3/D0-D2
.NOFIRE     MOVE.W  (A7)+,D1
            RTS



*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
