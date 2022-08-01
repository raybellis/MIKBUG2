*
* PREAMBLE SENDS OUT ALC BITS, AND THE START SEQUENCE,
*     THEN INITS THE CRC REGISTERS
*
*     RAM:  R, S (CHANGED)
*     REGS:  ACCA, ACCB (DESTROYED)
*     EXIT:  ACCA = 0, ACCB UNDEFINED
*
PREAMB BSR    BYTOV1   ALC BITS
       BSR    BYTOV1
       LDAA   #$89     START SEQUENCE (H)
       BSR    BYTOV1
       LDAA   #$AF     START SEQUENCE (L)
       BSR    BYTOV1
       CLR    R        ) CLEAR THE CRC REGISTERS
       CLR    S        )
       RTS
*
* HEADERECORD SENDS ALC BITS, THE START SEQUENCE,
*     HEADRECORD-TYPE, FILE ID, AND THE NUMBER OF
*     PAGES TO BE DUMPED
*
*     RAM:  FIDH, FIDL (UNMODIFIED)
*           R, S (CHANGED)
*     REGS:  ACCA, ACCB (DESTROYED)
*     EXIT:  ACCA = 0, ACCB UNDEFINED
*
HEADER BSR    BYTOV1   ALC BITS
       BSR    BYTOV1
       BSR    PREAMB   START A RECORD
       LDAA   #$08     HEADERTYPE
       BSR    BYTOV1
       LDAA   FIDH     FILE ID(H)
       BSR    BYTOV1
       LDAA   FIDL     FILE ID(L)
       BSR    BYTOV1
       LDAA   STOPPG   STOPAGE
       SUBA   STARTP   STARTPAGE
       INCA
       BSR    BYTOV1   SEND # PAGES
       JMP    BYTEOV   EXTRA BITS
