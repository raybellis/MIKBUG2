*
* MAXIMAL SOFTWARE IMPLEMENTATION OF THE
*    RITTER-ZETTNER STANDARDS
*
* COPYRIGHT (C) 1977 MOTOROLA INC. AND T. F. RITTER
*
*      COMMANDS FOR EXORTAPE
* C L D S :
* C - CHECK TAPE
* L - LOAD FROM TAPE TO MEMORY
* D - DUMP FROM MEMORY TO TAPE
* S - SET BAUD RATE
*
* SPEED :
* ENTER 04 08 12 16 20
*
* FILE ID :
* ENTER FOUR HEX CHARACTERS
*
* STARTSTOP PAGES:
* ENTER STARTING PAGE, TWO HEX CHARACTERS
* ENTER STOPPAGE, TWO HEX CHARACTERS
*
*
*
*         FILE SPECIFICATIONS
* ALC := UNDEFINED BIT; AUTOMATIC LEVEL CONTROL
* POST := UNDEFINED BIT; MISSING PULSE PROTECT
* START SEQUENCE := 89AFH
* CRC := CYCLIC REDUNDENCY CHECK BIT; X16+X15+X2+X0
* HEADERECORD := (32 ALC) (START SEQUENCE) (08H)
*    (16 FILE ID) (8 # OF GOOD PAGES) (8 POST)
* TRAILERECORD := (16 ALC) (START SEQUENCE)
*    (20H) (8 # OF BAD PAGES) (8 POST)
* DUMPAGERECORD := (16 ALC) (START SEQUENCE) (10H)
*    (8 PAGE #) (2048 DATA) (16 CRC) (8 POST)
* CHARECORD := (32 ALC) (START SEQUENCE) (40H)
*    (8 LENGTH) (1-256 CHARS) (16 CRC) (8 POST)
* OTHERECORD := NEITHER HEADER NOR TRAILER RECORD
* SUBFILE := (HEADERECORD) (0-N OTHERECORDS)
* FILE := (1-N SUBFILES) (TRAILERECORD)
*
*
*         DATA SPECIFICATIONS
* SYNCHRONOUS DATA; NO START OR STOP BITS
* MSB SENT FIRST (CORRECT ORDER ON SCOPE)
* VOICE MESSAGES MAY BE PRESENT BETWEEN FILES
*
*
*         AUDIO MODULATION SPECIFICATIONS
* DOUBLE-FREQUENCY RETURN-TO-BIAS MODULATION
* LOGIC ONE = FIVE ELEMENT PATTERN: 0 1 0 1 0
* LOGIC ZERO = FIVE ELEMENT PATTERN 0 1 0 0 0
* LOCAL EL CHEAPO (REALISTIC CTR-34) DOES 1200 BAUD
*    (DATA RATE EQUALS 1650 BAUD 2-STOP ASYNC)
* 0 ERROS IN 2.6 MILLION BITS RECOVERED
* FROM MEMOREX MRX2
*