;; vim: set filetype=asmM6502:

    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

Start:
    CLEAN_START

Loop:
    lda #$1E
    sta COLUBK
    jmp Loop

    org $FFFC
    .word Start
    .word Start
