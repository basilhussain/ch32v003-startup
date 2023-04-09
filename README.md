# Overview

The [CH32V003](http://www.wch-ic.com/products/CH32V003.html) series from [WCH](http://www.wch-ic.com) is a 32-bit RISC-V microcontroller with an RV32EC core that can run at up to 48 MHz and features 16 kB of flash and 2 kB of RAM. Variants are available with a variety of pin counts in TSSOP, QFN, and SOP packages.

This repository contains a fork of the [startup assembly code provided by WCH](https://github.com/openwch/ch32v003/blob/main/EVT/EXAM/SRC/Startup/startup_ch32v00x.S), modified with several changes to default behaviour, as well as giving improvements to code size.

Building this modified startup code will produce a statically-linked library file containing the startup code that can be linked with your CH32V003 application firmware projects.

# Features

The following changes have been made:

### Single, Common Default Interrupt Handler

The original startup code implements a discrete, separate default handler for each interrupt/exception vector. Each consists of a single jump instruction implementing an infinite loop. If, should a default interrupt handler ever be entered into, you do not care about being able to identify with a debugger *which* handler was entered, this needlessly wastes space. (Although it should be noted that in lieu of that the RISC-V `mcause` CSR can actually provide this information.)

By default the startup code is modified to coalesce all default handlers into a single common handler. This saves up to 52 bytes of flash memory (26 times a 2-byte jump instruction).

This feature can be disabled (to return to the use of separate default handlers) by providing the appropriate build option.

### Individual Sections for Discrete Default Interrupt Handlers

Should the above feature be disabled, and discrete default interrupt handlers retained, each handler is placed in a separate `.text` section so that the linker (when using `--gc-sections` option) can garbage-collect redundant default handler code from any interrupts that have been overridden by a handler in user code. This reduces code size, the exact amount depending on how many user handlers are implemented.

For example, if user code implements ISRs for the two I2C plus UART interrupts, the preceding ADC default interrupt handler will feature redundant code like so:

```
000002ec <ADC1_IRQHandler>:
     2ec:	a001                	j	2ec <ADC1_IRQHandler>
     2ee:	a001                	j	2ee <ADC1_IRQHandler+0x2>
     2f0:	a001                	j	2f0 <ADC1_IRQHandler+0x4>
     2f2:	a001                	j	2f2 <ADC1_IRQHandler+0x6>
```

Everything after the first `j` instruction above is redundant, leftover code and wastes space.

### Hardware Prologue/Epilogue (HPE) Disabled

The CH32V003 Programmable Fast Interrupt Controller (PFIC) features an optional hardware-driven stacking facility that will, upon an interrupt firing, automatically save a set of 10 caller-saved CPU registers (x1, x5-7, x10-15) to the stack, and restore them upon the ISR returning. This means that code within the ISR does not have to perform this work, and thus  potentially enhances performance by decreasing interrupt latency. The original WCH startup code enables HPE by default.

However, in order to use HPE, WCH's custom fork of GCC version 8.x must be used, because ISR functions must be flagged with the proprietary `__attribute__((interrupt("WCH-Interrupt-fast")))` attribute. This attribute instructs the compiler not to generate prologue and epilogue code that saves/restores this set of 10 registers.

If one wishes to use mainline GCC - which does not support that function attribute - then HPE must be disabled. When disabled, regular `__attribute__((interrupt))` attributes can be used instead.

You may also wish to disable HPE for other reasons; namely that it does not actually give a universal improvement to interrupt latency in all scenarios. For simple ISRs that do not call any other functions and don't use more than 3 or 4 CPU registers, software stacking is actually faster than HPE saving all 10.

HPE can be re-enabled by providing the appropriate build option.

### Pre-`main` Call to `SystemInit` Omitted

The original startup code makes a call to the WCH 'EVT' SPL/HAL library function `SystemInit` prior to entering `main`. This function configures system clocks (oscillator, PLL, etc.) and the flash interface (wait states, etc.). If you are not using the HAL library, then this call is unwanted.

It can be re-enabled by providing the appropriate build option.

# Building

Run `make` in the code's root folder. The options described below may optionally be given as arguments to the `make` command.

* `IRQ_HANDLERS=<common|discrete>`: Whether to have discrete default interrupt handlers (i.e. one handler per interrupt) or a single common handler for all interrupts. Without this argument, default is common.
* `PFIC_HPE=<enabled|disabled>`: Whether to enable the hardware prologue/epilogue feature (HPE) of the PFIC. Without this argument, default is disabled.
* `CALL_SYSINIT=<enabled|disabled>`: Whether to enable the pre-`main` call to the `SystemInit` function. Without this argument, default is disabled.
* `TOOL_PREFIX=<...>`: If the prefix of your RISC-V GCC toolchain executables is not `riscv-none-elf`, then specify the prefix string with this option.

The output `.a` library file will be placed in the `lib` folder (which is created if it doesn't exist).

# Usage

When linking your application code, provide the path to the `.a` file with the `-l` GCC command-line option.

Note also that when setting `IRQ_HANDLERS` to `discrete`, you should provide the linker option `--gc-sections`.

# References

* [Official WCH CH32V003 GitHub repository](https://github.com/openwch/ch32v003)
* [QingKeV2 Processor Manual](http://www.wch-ic.com/downloads/QingKeV2_Processor_Manual_PDF.html)
* [CH32V003 Reference Manual](http://www.wch-ic.com/downloads/CH32V003RM_PDF.html)
* [CH32V003 Datasheet](http://www.wch-ic.com/downloads/CH32V003DS0_PDF.html)
* [MounRiver Studio IDE](http://www.mounriver.com) (for WCH custom versions of GCC and OpenOCD)
