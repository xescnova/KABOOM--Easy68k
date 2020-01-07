; =============================================================================
; SPAWNER MANAGEMENT.
; =============================================================================

; -----------------------------------------------------------------------------
SPWUPD
; UPDATES THE SPAWNER
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L  D0-D1/A1-A3,-(A7)
            MOVE.B  (SCRCYCCT),D0
            MOVE.W  (PLRSCORE),D1            
            CMP.W   #50,D1
            BGE .AUX2
            AND     #$5F,D0                 ; EVERY 16 CYCLES
            BRA .AUX
.AUX2        AND     #$F,D0              
.AUX        BNE     .END                    ; CREATE A NEW ASTEROID
            LEA     BOMBINIT,A1
            LEA     BOMBUPD,A2
            LEA     BOMBPLOT,A3
            MOVE.W  #ASTTYPE,D0
            JSR     AGLADD
.END        MOVEM.L (A7)+,D0-D1/A1-A3
            RTS




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
