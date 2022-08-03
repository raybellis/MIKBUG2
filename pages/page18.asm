*
* RELATIVE BRANCH TYPE INSTRUCTION
* DETERMINE WHERE TO PUT SWI
* S- HOLDS POINTER TO USER STACK AFTER SWI
       PULA            GET CONDITION CODE
       DES             UPDATE STACK POINTER AFTER PULL
       ORAA   #%00010000 MAKE INT'S INHIBITED
       TAP             RESTORE USER'S C. CODE REG
       JMP    BRINS    GO SEE HOW RELATIVE BRANCH
*                            FARES
*
* BRANCH WAS NOGO - PUT SWI AT NEXT INSTRUCTION
*
BRNOGO LDAA   #2       A = # BYTES AFTER CURRENT INSTR
       BRA    CKOBRA   GO PUT SWI APPROPRIATELY
*
* BRANCH WAS GO, PUT SWI AT ADDRESS BEING
* JUMPED TO
*
BRGO   LDX    TRCADR   X : = TRACE ADDRESS
       LDAA   1,X      GET BRANCH OFFSET
       INX             OFFSET IS RELATIVE TO
       INX             INSTR FOLLOWING BRANCH
       BMI    BRGODC   BRANCH IF OFFSET NEGATIVE
BRG1   BSR    INCX     INCREMENT X BY AMOUNT IN
*                          A REG
BRG2   STX    TRCADR   SAVE ADDRESS OF NEXT
*                            INSTR TO STOP ON
       LDAA   0,X      GET INSTRUCTION TO BE REPLACED
       STAA   TRCINS   SAVE
       LDAA   #SWI     GET SWI OP CODE
       STAA   0,X      REPLACE INSTR WITH SWI
       LDS    SP       GET ORIGINAL STACK POINTER
       RTI             TRACE ANOTHER INSTR
*
* X NEEDS TO BE DECREMENTED (OFFSET NEGATIVE)
*
BRGODC DEX             DECREMENT ADDRESS
       INCA            INCREMENT COUNTER
       BNE    BRGODC   IF COUNTER NOT 0, BRANCH
       BRA    BRG2     IF DONE, GO RETURN TO USER PROG
*
* SUBROUTINE TO INCREMENT X BY CONTENTS OF A
*
INCX   TSTA            IS A = 0?
       BEQ    INCXR    IF SO, INC DONE
INXLP  INX             ELSE INCREMENT X
       DECA            DECREMENT COUNT
       BNE    INXLP    IF COUNT NOT YET 0, LOOP
INCXR  RTS             RETURN FROM THIS SUBROUTINE
