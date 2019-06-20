OUTPUT_FORMAT ("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")

MEMORY
{
    FLASH (rx)    : ORIGIN = 0x08000000, LENGTH = 64K
    RAM (rxw)     : ORIGIN = 0x20000000, LENGTH = 20K
}

STACK_SIZE = 256;
HEAP_SIZE  = 256;

ENTRY(Reset_Handler)

PROVIDE(__stack_top = ALIGN(ORIGIN(RAM) + LENGTH(RAM) - 8 ,8));

PROVIDE(NMI_Handler = BusyDummy_Handler);
PROVIDE(HardFault_Handler = BusyDummy_Handler);
PROVIDE(MemManage_Handler = BusyDummy_Handler);
PROVIDE(BusFault_Handler = BusyDummy_Handler);
PROVIDE(UsageFault_Handler = BusyDummy_Handler);
PROVIDE(SVC_Handler = Dummy_Handler);
PROVIDE(DebugMon_Handler = Dummy_Handler);
PROVIDE(PendSV_Handler = Dummy_Handler);
PROVIDE(SysTick_Handler = Dummy_Handler);

SECTIONS {
    .text : {
        LONG(__stack_top);
        KEEP(*(.isr_vector))
        *(.text)
        *(.rodata)
        . = ALIGN(4);
    } > FLASH

    __exidx_start = .;
    .ARM.exidx : {
        *(.ARM.exidx*)
        . = ALIGN(4);
    } > FLASH
    __exidx_end = .;

    __text_end = .;

    .data : AT(__text_end) {
        __data_start = .;
        *(SORT_BY_ALIGNMENT(.data*))
        . = ALIGN(4);
    } > RAM
    __data_size = SIZEOF(.data);

    .bss (NOLOAD) : {
        __bss_start = .;
        *(SORT_BY_ALIGNMENT(.bss*) SORT_BY_ALIGNMENT(COMMON*))
        . = ALIGN(4);
    } > RAM
    __bss_size = SIZEOF(.bss);

    /* DWARF 4 */
    .debug_abbrev 0 : { *(.debug_abbrev) }
    .debug_aranges 0 : { *(.debug_aranges) }
    .debug_frame 0 : { *(.debug_frame) }
    .debug_info 0 : { *(.debug_info) }
    .debug_line 0 : { *(.debug_line) }
    .debug_loc 0 : { *(.debug_loc) }
    .debug_macinfo 0 : { *(.debug_macinfo) }
    .debug_pubnames 0 : { *(.debug_pubnames) }
    .debug_pubtypes 0 : { *(.debug_pubtypes) }
    .debug_ranges 0 : { *(.debug_ranges) }
    .debug_str 0 : { *(.debug_str) }
    .debug_types 0 : { *(.debug_types) }
}
