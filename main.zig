var x: u32 = 1;

export fn main() void {
    while (x > 0) {
        x += 1;
    }
}

export fn HardFault_Handler() void {
    while (true) {
        x += 1;
    }
}