; =============================================================================
; SYSTEM CONSTANTS
; =============================================================================

; --- GAME STATES -------------------------------------------------------------

STANONE     EQU     -1                      ; PLACEHOLDER TO FORCE CHANGE
STAINTR     EQU     0                       ; INTRO/PRESS FIRE STATE
STAPLAY     EQU     1                       ; NORMAL GAME STATE
STAGOVR     EQU     2                       ; GAME OVER STATE

; --- AGENT TYPES -------------------------------------------------------------

BOMBTYPE    EQU     1

; --- PLAYER RELATED CONSTANTS ------------------------------------------------

PLRWIDTH    EQU     30                      ; PLAYER WIDTH (PIXELS)
PLRHEIGH    EQU     30                      ; PLAYER HEIGHT (PIXELS)
PLRSPEED    EQU     5                       ; PLAYER SPEED (PIXELS PER INT)
PLRNRMCL    EQU     $0000C0FF               ; PLAYER NORMAL COLOR
PLRTXTCL    EQU     $00FFFFFF               ; FONT COLOR
PLRTXTX     EQU     2                       ; SCORE X COORDINATE
PLRTXTY     EQU     1                       ; SCORE Y COORDINATE


; --- BOMBMAN RELATED CONSTANTS ------------------------------------------------

BMNWIDTH   EQU     30                      ;BOMBMAN WIDTH (PIXELS)
BMNHEIGH   EQU     30                      ;BOMBMAN HEIGHT (PIXELS)


; --- INTRO STATE RELATED CONSTANTS -------------------------------------------

INTTITX     EQU     31                      ; TITLE X COORDINATE
INTTITY     EQU     5                       ; TITLE Y COORDINATE
INTTITC     EQU     $000000FF               ; TITLE COLOR
INTPRSX     EQU     31                      ; PRESS FIRE X COORDINATE
INTPRSY     EQU     26                      ; PRESS FIRE Y COORDINATE
INTPRSC     EQU     $00FFFFFF               ; PRESS FIRE COLOR

; --- GAME OVER STATE RELATED CONSTANTS ---------------------------------------

GOVSTRX     EQU     35                      ; TITLE X COORDINATE
GOVSTRY     EQU     15                      ; TITLE Y COORDINATE
GOVSTRC     EQU     $00FFFFFF               ; TITLE COLOR





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
