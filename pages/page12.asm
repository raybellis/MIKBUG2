       BEQ    CLRBRK   YES, SET BRKADR TO 0
*
       CMPA   #2       IS BRK ADDR TO BE PRINTED?
       BEQ    PRNTBK   YES, GO PRINT ADDRESS
*
* UPDATE LOOP INDEX AND LOOP IF APPROPRIATE
*
BKCON2 INX             MAKE X POINT TO
       INX             NEXT BREAK ADDRESS
BKCON3 CPX    #BRKINS  ANY MORE BREAKS?
       BNE    BRKLP    YES,LOOP
*
* WRAP-UP PROCESSING AND EXIT
*
       CLRA            A = BREAKS IN FLAG
       TST    ASAVE    IS FUNCTION = -1?
       BPL    BKPUT    NO, SO BRKSIN = 0
       INCA            FCTN = -1 => BRKSIN:=1
BKPUT  STAA   BRKSIN   STORE APPROPRIATE FLAG
*
* RESTORE S-REG AND RETURN TO CALLER
*
BKDONE LDS    SSAVE    RESTORE USER S-REG
       RTS             RETURN
*
*
* MISCELLANEOUS ROUTINES FOR BRKSUB
*
* BREAKPOINT ADDRESS = 0 - IF FUNCTION = 4 THEN
* PUT BREAKPOINT ADDRESS IN CURRENT POSITION
* A HOLDS THE FUNCTION #, X HOLDS BREAKPOINT INDEX
*
LN     CMPA   #4       IS FUNCTION = 4
       BNE    BKCON2   IF NOT, THEN CONTINUE LOOP
*
       LDS    XHI      GET NEW BREAK ADDRESS
       STS    0,X      PUT IN CURRENT POSITION
*
       DEC    ASAVE    DO NOT PLACE ADDRESS MORE
*                      THAN ONCE-CONT TO
*                      TAKE OUT BREAKPOINTS
       BRA    BKCON2   CONTINUE LOOP
*
* BREAKS ARE NOT IN AND ADDRESS IS NON-ZERO.
* IF FUNCTION = -1 THEN SWI'S ARE TO BE PUT IN.
* A HOLDS FUNCTION NUMBER, S HOLDS ADDRESS
*
NOBRIN TSTA            IS FUNCTION = -1
       BPL    BKCON1   NO, CONTINUE
*
       DES             MAKE ADDRESS POINT TO 1 LESS
       PULA            GET USER INSTRUCTION
       STAA   2*NBRBPT,X SAVE
       LDAA   #SWI     GET SWI OP CODE
       PSHA            REPLACE USER INSTRUCTION
       BRA    BKCON2   CONTINUE LOOP
*
* FUNCTION=0 BRK ADDR NOT = 0, USER'S INSTR
 