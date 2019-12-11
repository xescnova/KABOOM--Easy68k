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
   
; -----------------------------------------------------------------------------
PLRUPD
; UPDATES THE PLAYER MOTION
; INPUT    - NONE (ACCESSES KBDVAL AND KBDEDGE)
; OUTPUT   - NONE (MODIFIES PLAYER DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
             MOVE.W  #PLRWIDTH/2,(PLRPOSX)
             MOVE.W  #(SCRHEIGH-PLRHEIGH)/4,(PLRPOSY)
             
            

*~Font name~Courier New~
*~Font size~10~
*~Tab type~0~
*~Tab size~4~
