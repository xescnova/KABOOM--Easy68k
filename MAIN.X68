; =============================================================================
; TITLE    : EXAMPLE GAME
; AUTHOR   :
; CREATION :
; =============================================================================

            ORG     $1000

; --- CODE INCLUDES -----------------------------------------------------------

             INCLUDE "SYSCONST.X68"          ; SYSTEM CONSTANTS
            INCLUDE "SYSTEM.X68"            ; SYSTEM CODE
            INCLUDE "CONST.X68"             ; USER CONSTANTS
            INCLUDE "UTIL.X68"              ; UTILITY MACRO AND SUBROUTINES
            INCLUDE "PLAYER.X68"            ; PLAYER MANAGEMENT
            INCLUDE "AGENTLST.X68"          ; AGENT LIST MANAGEMENT
            INCLUDE "SHOT.X68"              ; SHOT AGENT MANAGEMENT
            INCLUDE "ASTEROID.X68"          ; ASTEROID AGENT MANAGEMENT
            INCLUDE "SPAWNER.X68"           ; SPAWNER (CREATES ASTEROIDS)
            INCLUDE "XPLOSION.X68"          ; EXPLOSION AGENT MANAGEMENT
            INCLUDE "STATES.X68"            ; GAME STATES MANAGEMENT

            ; TO DO: PUT YOUR GAME-RELATED INCLUDES HERE

; --- INITIALIZE --------------------------------------------------------------

START       JSR     SYSINIT
            ; TO DO: CALL GAME INITIALIZATION CODE HERE
            JSR     STAINIT                 ; INITIALIZE GAME STATE


; --- UPDATE ------------------------------------------------------------------

.LOOP       TRAP    #KBDTRAP                ; READ KEYBOARD

            ; TO DO: CALL GAME UPDATE CODE HERE
            JSR     STAUPD                  ; UPDATE DEPENDING ON THE STATE


; --- WAIT SYNCH --------------------------------------------------------------

.WINT       TST.B   (SCRINTCT)              ; WAIT FOR INTERRUPT
            BEQ     .WINT
            CLR.B   (SCRINTCT)

; --- PLOT --------------------------------------------------------------------

            ; TO DO: CALL GAME PLOT CODE HERE
            JSR     STAPLOT                 ; PLOT DEPENDING ON THE STATE
            TRAP    #SCRTRAP                ; SHOW GRAPHICS
            BRA     .LOOP
            SIMHALT

; --- VARIABLES ---------------------------------------------------------------

            INCLUDE "SYSVAR.X68"
            INCLUDE "VAR.X68"
            END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
