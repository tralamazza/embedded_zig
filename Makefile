# Disable built-in rules and variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables

BUILD_FLAGS = --release-small -target thumbv7m-freestanding-none
LINKER_SCRIPT = arm_cm3.ld
OBJS = startup.o main.o

%.o: %.zig
	zig build-obj ${BUILD_FLAGS} $<

firmware: ${OBJS}
#	zig build-exe ${BUILD_FLAGS} $(OBJS:%=--object %) --name $@ --linker-script ${LINKER_SCRIPT}
	arm-none-eabi-ld ${OBJS} -o $@ -T ${LINKER_SCRIPT} -Map $@.map --gc-sections

clean:
	rm -rf firmware firmware.map ${OBJS} $(OBJS:%.o=%.h) zig-cache

.PHONY: clean
