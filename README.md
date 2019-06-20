# embedded_zig

A "minimal" ARM cortex-M firmware in Zig.

## building

Get [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm) and [Zig](https://ziglang.org/) in `PATH` and type:

    make

## running on a [bluepill](http://wiki.stm32duino.com/index.php?title=Blue_Pill)

Run OpenOCD on a terminal:

    openocd -f /usr/share/openocd/scripts/interface/stlink-v2.cfg -f /usr/share/openocd/scripts/target/stm32f1x.cfg

Open your favorite GDB:

    arm-none-eabi-gdb firmware.elf -ex 'target extended-remote :3333'
    load
    r

Bonus: you can type `make` inside gdb and `load` it again.

## issues

You can try uncommenting the line below (in the `Makefile`) to use the lld (don't forget to comment out ld):

        zig build-exe ${BUILD_FLAGS} $(OBJS:%=--object %) --name $@.elf --linker-script ${LINKER_SCRIPT}
    #   arm-none-eabi-ld ${OBJS} -o $@.elf -T ${LINKER_SCRIPT} -Map $@.map --gc-sections

## raq (rarely asked questions)

a) Shouldn't the Makefile...

A: lalalala

b) How do I flash this?

A: see [running on a bluepill](#running-on-a-bluepill)
