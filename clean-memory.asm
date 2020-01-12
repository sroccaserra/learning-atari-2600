;; vim: set filetype=asmM6502:

    processor 6502

    seg code
    org $F000

Start:
    sei                 ; disable interrupts
    cld                 ; disable the BCD decimal math mode
    ldx #$FF
    txs                 ; transfer X register to S(tack) register

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clear the Zero Page region ($00 to $FF)
;; Meaning the entire TIA register space and also RAM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #0
    sta $FF
    ldx #$FF
MemLoop:
    dex
    sta $0,X
    bne MemLoop         ; Note: the Z(ero) flag set by dex is unchanged by sta

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Fill ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    org $FFFC
    .word Start         ; reset vector at $FFFC (where program starts)
    .word Start         ; interrupt vector at $FFFE (unused in vcs)
