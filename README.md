# embedded_zig

A "minimal" ARM cortex-M firmware in Zig.

## building

Get [GNU Arm Embedded Toolchain](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm) and [Zig](https://ziglang.org/) in `PATH` and type:

    make

## issues

You can try uncommenting the line below (in the `Makefile`) to use the lld (don't forget to comment out ld):

        zig build-exe ${BUILD_FLAGS} $(OBJS:%=--object %) --name $@.elf --linker-script ${LINKER_SCRIPT}
    #   arm-none-eabi-ld ${OBJS} -o $@.elf -T ${LINKER_SCRIPT} -Map $@.map --gc-sections

## raq (rarely asked questions)

a) Shouldn't the Makefile...

A: lalalala

b) How do I flash this?

A: yes
