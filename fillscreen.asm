NUML    EQU 25                   ; Nombre de lignes "texte"
LSIZE   EQU 80                   ; Nombre d'octets par ligne
SCREEN  EQU #C000                ; Adresse Ecran vidéo
VBL     EQU #BD19                ; Routine d'attente VBL

        ORG $9000
        ; Point d'entrée
        LD  A,#01                ; Pattern de remplissage
        LD  HL,SCREEN            ; Destination: ecran
        LD  C,8                  ; 8 blocs DE 25 lignes
bloc:   LD  D,NUML               ; 25 lignes
ligne:  CALL  VBL                ; Attente balayage ecran
        LD  E,LSIZE              ; 1 ligne = 80 octets
pix:    LD  (HL),A               ; On ecrit le pattern en HL       
        INC HL                   ; Pixel(s) suivants
        DEC E           
        JR  NZ,pix               
        DEC D                    ; Ligne Suivante
        JR  NZ,ligne             
        LD  DE,#800-(LSIZE*NUML) ; Passage au bloc suivant 
        ADD HL,DE
        RRCA                     ; Rotation du pattern
        DEC c
        JR  NZ,bloc      
        RET
EndOfCode:

SAVE "FILL.BIN", #9000, EndOfCode-#9000, DSK, "fillscreen.dsk"
