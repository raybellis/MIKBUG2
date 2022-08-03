*
* PRINT CONTENTS OF STACK
*
PRINT  JSR    PCRLF    PRINT CR LF
       LDX    SP       PRINT OUT STACK
       INX
       BSR    OT2HS    CONDITION CODES
       BSR    OT2HS    ACC-B
       BSR    OT2HS    ACC-A
       BSR    OT4HS    X-REG
       BSR    OT4HS    P-COUNTER
       LDX    #SP
       BSR    OT4HS    STACK POINTER
       RTS


*     PUNCH DUMP
*     PUNCH FROM BEGINNING ADDRESS ( BEGA ) THRU ENDING
*     ADDRESS ( ENDA )
*

MTAPE1 FCB    $D,$A,0,0,0,0,'S,'1,4 PUNCH FORMAT

PUNCH  EQU    *

       JSR    GETADD   GET ADDRESS
       LDAA   #$12     TURN TTY PUNCH ON
       JSR    OUTCH    OUT CHAR
*
*      PUNCH LEADER - 25 NULLS
*
       LDAB   #25      B HOLDS # NULLS TO PUNCH
PNULL  CLRA            A=0 ( NULL CHAR )
       JSR    OUTCH    GO OUTPUT NULL
       DECB            DECREMENT COUNTER
       BNE    PNULL    IF NOT DONE, THEN LOOP
*
       LDX    BEGA
       STX    TW       TEMP BEGINNING ADDRESS
PUN11  LDAA   ENDA+1
       SUBA   TW+1
       LDAB   ENDA
       SBCB   TW
       BNE    PUN22
       CMPA   #16
       BCS    PUN23
PUN22  LDAA   #15
PUN23  ADDA   #4
       STAA   MCONT    FRAME COUNT THIS RECORD
*       PUNCH C/R,L/F,NULLS,S,1
       LDX    #MTAPE1
       JSR    PDATA1
       CLRB            ZERO CHECKSUM
