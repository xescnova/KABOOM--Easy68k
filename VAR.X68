; =============================================================================
; GAME VARS
; =============================================================================

; TO DO: DECLARE GAME VARIABLES HERE.


; --- GAME STATE RELATED VARIABLES --------------------------------------------

STACUR      DS.W    1                       ; CURRENT GAME STATE
STANEXT     DS.W    1                       ; NEXT GAME STATE

STATES      DC.L    STAINIT                 ;INITIALIZE STATE 0
            DC.L    STAMENU                 ;MENU STATE       1
            DC.L    STAGAME                 ;GAME STATE       2
            DC.L    STAUPD                  ;UPDATE STATE     3 
            DC.L    STAGOVR                 ;GAME OVER STATE  4
            
STATE       DS.L    1                       ;CURRENT STATE

; --- PLAYER RELATED VARIABLES ------------------------------------------------

PLRPOSX     DS.W    1                       ; PLAYER X POSITION (PIXELS)
PLRPOSY     DS.W    1                       ; PLAYER Y POSITION (PIXELS)
PLRENER     DS.W    1                       ; PLAYER ENERGY
PLRSCORE    DS.W    1                       ; PLAYER SCORE


PLRLIFE     DS.W    1                       ; PLAYER IN GAME LIFE

PLRDMG      DS.B    1                       ; BIT0: UPD DAMAGE, BIT1 PLOT DMG
            DS.W    0

; --- BOMBMAN RELATED VARIABLES ------------------------------------------------

BMNPOSX     DS.W    1                       ; BOMBMAN X POSITION  (PIXELS) 
BMNPOSY     DS.W    1                       ; BOMBMAN Y POSITION  (PIXELS)
; --- UTILITY VARIABLES ------------------------------------------------------

UTLRNDIX    DS.B    1                       ; NEXT INDEX TO RANDOM NUMBER
            DS.W    0








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
