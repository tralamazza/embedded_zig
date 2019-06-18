const builtin = @import("builtin");
const mem = @import("std").mem;

extern fn main() void;
extern var __text_end: usize;
extern var __data_start: usize;
extern var __data_size_ptr: *usize;
extern var __bss_start: usize;
extern var __bss_size_ptr: *usize;
extern var __stack_top: *usize;

export fn Reset_Handler() void {
    // TODO maybe reset VTOR?
    // copy data from flash to RAM
    var data = @ptrCast([*]u8, &__data_start);
    var text = @ptrCast([*]u8, &__text_end);
    const size_data = __data_size_ptr.*;
    for (text[0..size_data]) |b, i| data[i] = b;
    // zero bss
    var bss = @ptrCast([*]u8, &__bss_start);
    const size_bss = __bss_size_ptr.*;
    for (bss[0..size_bss]) |*b| b.* = 0;
    // start
    main();
}

export fn Dummy_Handler() void {
    while (true) {}
}

extern fn NMI_Handler() void;
extern fn HardFault_Handler() void;
extern fn MemManage_Handler() void;
extern fn BusFault_Handler() void;
extern fn UsageFault_Handler() void;
extern fn SVC_Handler() void;
extern fn DebugMon_Handler() void;
extern fn PendSV_Handler() void;
extern fn SysTick_Handler() void;

const Isr = extern fn() void;

export var vector_table linksection(".isr_vector") = [_]?Isr {
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
