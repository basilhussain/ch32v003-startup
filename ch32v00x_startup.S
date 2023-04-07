;/********************************** (C) COPYRIGHT *******************************
;* File Name          : startup_ch32v00x.s
;* Author             : WCH
;* Version            : V1.0.0
;* Date               : 2022/08/08
;* Description        : vector table for eclipse toolchain.
;*********************************************************************************
;* Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
;* Attention: This software (modified or not) and binary are used for
;* microcontroller manufactured by Nanjing Qinheng Microelectronics.
;*******************************************************************************/

	.section .init, "ax", @progbits
	.globl _start
	.align 2
_start:
	.option norvc
	j     handle_reset
	.word 0
	.word NMI_Handler                 /* NMI Handler */
	.word HardFault_Handler           /* Hard Fault Handler */
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word SysTick_Handler             /* SysTick Handler */
	.word 0
	.word SW_Handler                  /* SW Handler */
	.word 0
	/* External Interrupts */
	.word WWDG_IRQHandler             /* Window Watchdog */
	.word PVD_IRQHandler              /* PVD through EXTI Line detect */
	.word FLASH_IRQHandler            /* Flash */
	.word RCC_IRQHandler              /* RCC */
	.word EXTI7_0_IRQHandler          /* EXTI Line 7..0 */
	.word AWU_IRQHandler              /* AWU */
	.word DMA1_Channel1_IRQHandler    /* DMA1 Channel 1 */
	.word DMA1_Channel2_IRQHandler    /* DMA1 Channel 2 */
	.word DMA1_Channel3_IRQHandler    /* DMA1 Channel 3 */
	.word DMA1_Channel4_IRQHandler    /* DMA1 Channel 4 */
	.word DMA1_Channel5_IRQHandler    /* DMA1 Channel 5 */
	.word DMA1_Channel6_IRQHandler    /* DMA1 Channel 6 */
	.word DMA1_Channel7_IRQHandler    /* DMA1 Channel 7 */
	.word ADC1_IRQHandler             /* ADC1 */
	.word I2C1_EV_IRQHandler          /* I2C1 Event */
	.word I2C1_ER_IRQHandler          /* I2C1 Error */
	.word USART1_IRQHandler           /* USART1 */
	.word SPI1_IRQHandler             /* SPI1 */
	.word TIM1_BRK_IRQHandler         /* TIM1 Break */
	.word TIM1_UP_IRQHandler          /* TIM1 Update */
	.word TIM1_TRG_COM_IRQHandler     /* TIM1 Trigger and Commutation */
	.word TIM1_CC_IRQHandler          /* TIM1 Capture Compare */
	.word TIM2_IRQHandler             /* TIM2 */
	.option rvc

	.weak NMI_Handler
	.weak HardFault_Handler
	.weak SysTick_Handler
	.weak SW_Handler
	.weak WWDG_IRQHandler
	.weak PVD_IRQHandler
	.weak FLASH_IRQHandler
	.weak RCC_IRQHandler
	.weak EXTI7_0_IRQHandler
	.weak AWU_IRQHandler
	.weak DMA1_Channel1_IRQHandler
	.weak DMA1_Channel2_IRQHandler
	.weak DMA1_Channel3_IRQHandler
	.weak DMA1_Channel4_IRQHandler
	.weak DMA1_Channel5_IRQHandler
	.weak DMA1_Channel6_IRQHandler
	.weak DMA1_Channel7_IRQHandler
	.weak ADC1_IRQHandler
	.weak I2C1_EV_IRQHandler
	.weak I2C1_ER_IRQHandler
	.weak USART1_IRQHandler
	.weak SPI1_IRQHandler
	.weak TIM1_BRK_IRQHandler
	.weak TIM1_UP_IRQHandler
	.weak TIM1_TRG_COM_IRQHandler
	.weak TIM1_CC_IRQHandler
	.weak TIM2_IRQHandler

#ifdef STARTUP_COMMON_IRQ_HANDLER
	.section .text.Default_Handler, "ax", @progbits
NMI_Handler:
HardFault_Handler:
SysTick_Handler:
SW_Handler:
WWDG_IRQHandler:
PVD_IRQHandler:
FLASH_IRQHandler:
RCC_IRQHandler:
EXTI7_0_IRQHandler:
AWU_IRQHandler:
DMA1_Channel1_IRQHandler:
DMA1_Channel2_IRQHandler:
DMA1_Channel3_IRQHandler:
DMA1_Channel4_IRQHandler:
DMA1_Channel5_IRQHandler:
DMA1_Channel6_IRQHandler:
DMA1_Channel7_IRQHandler:
ADC1_IRQHandler:
I2C1_EV_IRQHandler:
I2C1_ER_IRQHandler:
USART1_IRQHandler:
SPI1_IRQHandler:
TIM1_BRK_IRQHandler:
TIM1_UP_IRQHandler:
TIM1_TRG_COM_IRQHandler:
TIM1_CC_IRQHandler:
TIM2_IRQHandler:
Default_Handler:          1: j 1b
#else
	.section .text.NMI_Handler, "ax", @progbits
NMI_Handler:              1: j 1b
	.section .text.HardFault_Handler, "ax", @progbits
HardFault_Handler:        1: j 1b
	.section .text.SysTick_Handler, "ax", @progbits
SysTick_Handler:          1: j 1b
	.section .text.SW_Handler, "ax", @progbits
SW_Handler:               1: j 1b
	.section .text.WWDG_IRQHandler, "ax", @progbits
WWDG_IRQHandler:          1: j 1b
	.section .text.PVD_IRQHandler, "ax", @progbits
PVD_IRQHandler:           1: j 1b
	.section .text.FLASH_IRQHandler, "ax", @progbits
FLASH_IRQHandler:         1: j 1b
	.section .text.RCC_IRQHandler, "ax", @progbits
RCC_IRQHandler:           1: j 1b
	.section .text.EXTI7_0_IRQHandler, "ax", @progbits
EXTI7_0_IRQHandler:       1: j 1b
	.section .text.AWU_IRQHandler, "ax", @progbits
AWU_IRQHandler:           1: j 1b
	.section .text.DMA1_Channel1_IRQHandler, "ax", @progbits
DMA1_Channel1_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel2_IRQHandler, "ax", @progbits
DMA1_Channel2_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel3_IRQHandler, "ax", @progbits
DMA1_Channel3_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel4_IRQHandler, "ax", @progbits
DMA1_Channel4_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel5_IRQHandler, "ax", @progbits
DMA1_Channel5_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel6_IRQHandler, "ax", @progbits
DMA1_Channel6_IRQHandler: 1: j 1b
	.section .text.DMA1_Channel7_IRQHandler, "ax", @progbits
DMA1_Channel7_IRQHandler: 1: j 1b
	.section .text.ADC1_IRQHandler, "ax", @progbits
ADC1_IRQHandler:          1: j 1b
	.section .text.I2C1_EV_IRQHandler, "ax", @progbits
I2C1_EV_IRQHandler:       1: j 1b
	.section .text.I2C1_ER_IRQHandler, "ax", @progbits
I2C1_ER_IRQHandler:       1: j 1b
	.section .text.USART1_IRQHandler, "ax", @progbits
USART1_IRQHandler:        1: j 1b
	.section .text.SPI1_IRQHandler, "ax", @progbits
SPI1_IRQHandler:          1: j 1b
	.section .text.TIM1_BRK_IRQHandler, "ax", @progbits
TIM1_BRK_IRQHandler:      1: j 1b
	.section .text.TIM1_UP_IRQHandler, "ax", @progbits
TIM1_UP_IRQHandler:       1: j 1b
	.section .text.TIM1_TRG_COM_IRQHandler, "ax", @progbits
TIM1_TRG_COM_IRQHandler:  1: j 1b
	.section .text.TIM1_CC_IRQHandler, "ax", @progbits
TIM1_CC_IRQHandler:       1: j 1b
	.section .text.TIM2_IRQHandler, "ax", @progbits
TIM2_IRQHandler:          1: j 1b
#endif

	.section .text.handle_reset, "ax", @progbits
	.weak handle_reset
	.align 1
handle_reset:
	.option push
	.option norelax
	la gp, __global_pointer$
	.option pop
1:
	la sp, _eusrstack
2:

	/* Load data section from flash to RAM */
	la a0, _data_lma
	la a1, _data_vma
	la a2, _edata
	bgeu a1, a2, 2f
1:
	lw t0, (a0)
	sw t0, (a1)
	addi a0, a0, 4
	addi a1, a1, 4
	bltu a1, a2, 1b
2:

	/* Clear BSS section */
	la a0, _sbss
	la a1, _ebss
	bgeu a0, a1, 2f
1:
	sw zero, (a0)
	addi a0, a0, 4
	bltu a0, a1, 1b
2:

	/* Cause interrupts to be enabled later (when executing main) by setting
	   MPIE in mstatus */
	li t0, 0x80
	csrw mstatus, t0

#ifdef STARTUP_ENABLE_HPE
	/* Enable PFIC HPE and nesting */
	li t0, 0x3
#else
	/* Only enable nesting, not HPE */
	li t0, 0x2
#endif
	csrw 0x804, t0

	/* Set vector table base address and mode (table entries contain absolute
	   address of ISR and interrupt entry is determined by IRQ number multiplied
	   by 4) */
	la t0, _start
	ori t0, t0, 3
	csrw mtvec, t0

#ifdef STARTUP_CALL_SYSINIT
	jal SystemInit
#endif

	/* Execute main by setting it as address to be returned to, then return */
	la t0, main
	csrw mepc, t0
	mret
