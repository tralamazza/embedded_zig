const builtin = @import("builtin");

extern fn main() void;
extern var __text_end: u32;
extern var __data_start: u32;
extern var __data_size: u32;
extern var __bss_start: u32;
extern var __bss_size: u32;
extern var __stack_top: u32;

export fn Reset_Handler() void {
    // copy data from flash to RAM
    const data_size = @ptrToInt(&__data_size);
    const data = @ptrCast([*]u8, &__data_start);
    const text_end = @ptrCast([*]u8, &__text_end);
    for (text_end[0..data_size]) |b, i| data[i] = b;
    // clear the bss
    const bss_size = @ptrToInt(&__bss_size);
    const bss = @ptrCast([*]u8, &__bss_start);
    for (bss[0..bss_size]) |*b| b.* = 0;
    // start
    main();
}

export fn BusyDummy_Handler() void {
    while (true) {}
}

export fn Dummy_Handler() void {}

extern fn NMI_Handler() void;
extern fn HardFault_Handler() void;
extern fn MemManage_Handler() void;
extern fn BusFault_Handler() void;
extern fn UsageFault_Handler() void;
extern fn SVC_Handler() void;
extern fn DebugMon_Handler() void;
extern fn PendSV_Handler() void;
extern fn SysTick_Handler() void;

const Isr = extern fn () void;

export var vector_table linksection(".isr_vector") = [_]?Isr{
    Reset_Handler,
    NMI_Handler,
    HardFault_Handler,
    MemManage_Handler,
    BusFault_Handler,
    UsageFault_Handler,
    null,
    null,
    null,
    null,
    SVC_Handler,
    DebugMon_Handler,
    null,
    PendSV_Handler,
    SysTick_Handler,
};
