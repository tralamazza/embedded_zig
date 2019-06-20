usingnamespace @import("stm32f10.zig");

export fn main() void {
    SystemInit();
    RCC.*.APB2ENR |= RCC_APB2Periph_GPIOC; // enable GPIOC clk
    GPIOC.*.CRH &= ~u32(0b1111 << 20); // PC13
    GPIOC.*.CRH |= u32(0b0010 << 20); // Out PP, 2MHz

    while (true) {
        GPIOC.*.ODR ^= GPIO_PIN_13; // toggle
        var i: u32 = 0;
        while (i < 1000000) {
            asm volatile ("nop");
            i += 1;
        }
    }
}
