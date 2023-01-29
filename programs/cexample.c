#include "mlib.h"

void graphics_write(unsigned int offset, unsigned char byte);

int main(int argc, char *argv[]) {
    dialog_box("Hello world!!", "You are now entering the wonderful", "world of ***graphics***", 0);
    graphics_enable();

    for (int y = 0; y < 200; y++) {
        for (int x = 0; x < 320; x++) {
            graphics_write(y * 320 + x, x);
        }
    }

    wait_for_key();
    graphics_disable();

    dialog_box(NULL, "See, wasn't that so cool?", NULL, 0);
    return 0;
}

void graphics_write(unsigned int offset, unsigned char byte) {
    asm("push ax");
    asm("push di");
    asm("push es");
    asm("mov ax, 0xA000");
    asm("mov es, ax");
    asm("mov di, word [bp+4]");
    asm("mov ax, word [bp+6]");
    asm("mov byte [es:di], al");
    asm("pop es");
    asm("pop di");
    asm("pop ax");
}
