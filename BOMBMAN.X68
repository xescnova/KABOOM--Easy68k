; =============================================================================
; BOMBMAN MANAGEMENT
; =============================================================================

; -----------------------------------------------------------------------------
BMNINIT
; INITIALIZES THE BOMBMAN
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.W  #SCRWIDTH/2,(BMNPOSX)
            MOVE.W  #(BMNHEIGH)+50,(BMNPOSY)
            MOVE.W  #129,(BMNDIR)
            RTS

; -----------------------------------------------------------------------------
BMNUPD
; UPDATES THE BOMBMAN MOTION
; INPUT    - NONE 
; OUTPUT   - NONE (MODIFIES BOMBMAN DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVE.B  (SCRCYCCT),D1
            AND     #$20,D1                 ; EVERY 16 CYCLES
            BNE     .ENDCICLE               ; NEW DIRECTION
            JSR     UTLRAND
            MOVE.W  (BMNPOSX),D1            ;BMNDIR=(BMNPOSX*128)/((SCRWIDTH)/2)
            MULU.W  #128,D1
            DIVU.W  #320,D1
            MOVE.W  D1,D2
            SWAP    D2
            MULU.W  #320,D2
            ADD.W   D2,D1
            MOVE.W  D1,(BMNDIR)             
.ENDCICLE                                    
            CMP.W   (BMNDIR),D0
            BGE     .CHKRT
            SUB.W   #BMNSPEED,(BMNPOSX)
            TST.W   (BMNPOSX)
            BGE     .END
            CLR.W   (BMNPOSX)
            JMP     .END
.CHKRT      ADD.W   #BMNSPEED,(BMNPOSX)
            CMP     #SCRWIDTH-BMNWIDTH,(BMNPOSX)
            BLE     .END
            MOVE.W  #SCRWIDTH-BMNWIDTH,(BMNPOSX)
.END        
            RTS

; -----------------------------------------------------------------------------
BMNPLOT
; PLOTS THE BOMBMAN 
; INPUT    - NONE
; OUTPUT   - NONE
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            MOVEM.L D0-D4,-(A7)
            MOVE.L  #BMNNRMCL,D1            ; DECIDE COLOR
*            BCLR.B  #PLRPBDMG,(PLRDMG)
*            BEQ     .NODMG
*            MOVE.L  #PLRDMGCL,D1
             MOVE.B  #80,D0
            TRAP    #15
            ADDQ.B  #1,D0
            TRAP    #15            
            MOVE.W  (BMNPOSX),D1            ; PLOT THE BOMBMAN
            MOVE.W  (BMNPOSY),D2            
            MOVE.W  D1,D3
            MOVE.W  D2,D4
            ADD.W   #BMNWIDTH,D3
            ADD.W   #BMNHEIGH,D4
*            MOVE.B  #88,D0
*            TRAP    #15
*            SUB.W   #PLRWIDTH/2,D3
            MOVE.B  #87,D0
            TRAP    #15

*            UTLSPEN #PLRTXTCL               ; PLOT THE SCORE TEXT
*            UTLSFIL #$00000000
*            UTLLOCT PLRTXTX,PLRTXTY
*            LEA     .SCORESTR,A1
*            CLR.L   D1
*            MOVE.W  (PLRSCORE),D1
*            MOVE.B  #17,D0
*            TRAP    #15
*
*            UTLSPEN #$00FFFFFF              ; PLOT LIFE
*            UTLSFIL #PLRLIFEC
*            MOVE.W  #(SCRWIDTH-PLRINIEN)/2,D1
*            MOVE.W  #PLRLIFEY,D2
*            MOVE.W  (PLRENER),D3
*            ADD.W   D1,D3
*            MOVE.W  #PLRLIFEY+PLRLIFEH,D4
*            MOVE.B  #87,D0
*            TRAP    #15
*            MOVE.W  #(SCRWIDTH+PLRINIEN)/2,D3
*            MOVE.B  #90,D0
*            TRAP    #15

            MOVEM.L (A7)+,D0-D4
            RTS
*.SCORESTR   DC.B    'SCORE: ',0













*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
