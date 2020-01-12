;; vim: set filetype=asmM6502:

    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000

BGColor equ $81

Start:
    CLEAN_START

NextFrame:
    lda #2              ; Turning on VBLANK and VSYNC
    sta VBLANK
    sta VSYNC

    sta WSYNC           ; Waiting for the three lines of VSYNC
    sta WSYNC
    sta WSYNC

    lda #0
    sta VSYNC

    ldx #37             ; Waiting during 37 lines of VBLANK
LoopVBlank:
    sta WSYNC
    dex
    bne LoopVBlank

    lda #0
    sta VBLANK

    ldx #192            ; Drawing 192 colored lines
    sta BGColor
LoopVisible:
    sta COLUBK
    sta WSYNC
    adc #2
    dex
    bne LoopVisible

    lda #2              ; Waiting for 30 lines of overscan
    sta VBLANK
    ldx #30
LoopOverscan:
    sta WSYNC
    dex
    bne LoopOverscan

    jmp NextFrame

    org $FFFC
    .word Start
    .word Start
