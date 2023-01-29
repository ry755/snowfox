; ==================================================================
; Snowfox - based on MikeOS
; Copyright (C) 2006 - 2022 MikeOS Developers
; Copyright (C) 2023        ryfox
; see LICENSE.TXT
; ==================================================================
; VIDEO MODE AND GRAPHICS SYSTEM CALLS
; ==================================================================

; ------------------------------------------------------------------
; os_graphics_enable -- Enables 320x200 256-color graphics mode
; IN: Nothing
; OUT: Nothing

os_graphics_enable:
    pusha

    mov ax, 0x0013
    int 0x10

    popa
    ret


; ------------------------------------------------------------------
; os_graphics_disable -- Returns to text mode
; IN: Nothing
; OUT: Nothing

os_graphics_disable:
    pusha

    mov ax, 0x0003
    int 0x10

    ; ensure the high color bit is used as intensity, not blink
    mov ax, 0x1003
    mov bx, 0x0000
    int 0x10

    popa
    ret
