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
            RTS

; -----------------------------------------------------------------------------
BMNUPD
; UPDATES THE BOMBMAN MOTION
; INPUT    - NONE 
; OUTPUT   - NONE (MODIFIES BOMBMAN DATA)
; MODIFIES - NONE
; -----------------------------------------------------------------------------
            JSR     UTLRAND
            CMP     #1,D0
            BEQ     .CHKRT
            SUB.W   #BMNSPEED,(BMNPOSX)
            TST.W   (BMNPOSX)
            BGE     .CHKRT
            CLR.W   (BMNPOSX)
*.CHKUP      ROR.B   #1,D1
*            BCC     .CHKRT
*            SUB.W   #PLRSPEED,(PLRPOSY)
*            TST.W   (PLRPOSY)
*            BGE     .CHKRT
*            CLR.W   (PLRPOSY)
.CHKRT      ADD.W   #BMNSPEED,(PLRPOSX)
            CMP.W   #SCRWIDTH-BMNWIDTH,(BMNPOSX)
            BLE     .END
            MOVE.W  #SCRWIDTH-BMNWIDTH,(BMNPOSX)
*.CHKDN      ROR.B   #1,D1
*            BCC     .MDONE
*            ADD.W   #PLRSPEED,(PLRPOSY)
*            CMP.W   #SCRHEIGH-PLRHEIGH,(PLRPOSY)
*            BLE     .MDONE
*            MOVE.W  #SCRHEIGH-PLRHEIGH,(PLRPOSY)
*.MDONE      BTST.B  #KBDBITF1,(KBDEDGE)
*            BEQ     .NOFIRE
*            MOVEM.L A1-A3/D0-D2,-(A7)
*            LEA     SHTINIT,A1
*            LEA     SHTUPD,A2
*            LEA     SHTPLOT,A3
*            MOVE.W  #SHTTYPE,D0
*            MOVE.W  (PLRPOSX),D1
*            MOVE.W  (PLRPOSY),D2
*            JSR     AGLADD
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
