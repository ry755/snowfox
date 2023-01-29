# Snowfox

**Snowfox** is an extended fork of MikeOS, which is a simple operating system targeting x86's 16-bit Real Mode.

# Changes

### Syscalls

 - `os_graphics_enable` - enable VGA mode 0x13 (320x200 bitmap, 256 colors)
 - `os_graphics_disable` - return to text mode

### BASIC

 - `genable` - call `os_graphics_enable`
 - `gdisable` - call `os_graphics_disable`
 - `gpoke` - poke a value into video memory
