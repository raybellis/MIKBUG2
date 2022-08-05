*
*  VECTORS- IN OTHER VERSIONS OF THIS TAPE
*   INTERFACE THESE VECTORS WILL BE IMPLEMENTED
*   IN RAM TO ALLOW THE USER ACCESS TO
*   THE TAPE SYSTEM.
*
TAIN1  JMP    TAIN2    TAPE IN PORT VECTOR
TAOU1  JMP    TAOU2    TAPE OUT PORT VECTOR
LOADBV JMP    LOADBY   TAPE BYTE IN VECTOR
BYTEOV JMP    BYTEOU   TAPE BYTE OUT VECTOR
TTYIN1 JMP    TTYIN2   CONTROL IN PORT VECTOR
TTYO1  JMP    TTYO2    CONTROL OUT PORT VECTOR
LSETUP JMP    SETUP    TAPE OUT PIA INIT
DSETUP JMP    SETUP    TAPE IN PAI INIT
*
*
TAIN2  LDAA   TP       ACCA FROM TAPE
       RORA            DATA BIT IN CARRY
       RTS
TTYIN2 LDAA   TTY      ACCA FROM ACIA
       RTS
TTYO2  STAA   TTY      SEND ACCA TO ACIA
       RTS
TAOU2  STAB   TP       ACCB TO TAPE
       RTS
