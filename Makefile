################################################################################
# BUILD OPTIONS
################################################################################

# For default dummy interrupt handlers, whether to have discrete handlers (i.e.
# one handler per IRQ) or a single common handler for all IRQs. For the former,
# specify 'discrete'; for the latter specify 'common'.
IRQ_HANDLERS ?= common

# Whether to enable the PFIC hardware prologue/epilogue feature (HPE). Should be
# enabled when using WCH fork of GCC and 'interrupt("WCH-Interrupt-fast")' ISR
# attributes.
PFIC_HPE ?= disabled

# Whether to include a call to a function named 'SystemInit' before 'main'. Use
# this when using the WCH 'EVT' library.
CALL_SYSINIT ?= disabled

# Prefix of the toolchain executables.
TOOL_PREFIX ?= riscv-none-elf

################################################################################

CC = $(TOOL_PREFIX)-gcc
CFLAGS = -march=rv32ec_zicsr -misa-spec=2.2 -mabi=ilp32e -ffunction-sections -Wall
ifeq ($(IRQ_HANDLERS),common)
	CFLAGS += -DSTARTUP_COMMON_IRQ_HANDLER
endif
ifeq ($(PFIC_HPE),enabled)
	CFLAGS += -DSTARTUP_ENABLE_HPE
endif
ifeq ($(CALL_SYSINIT),enabled)
	CFLAGS += -DSTARTUP_CALL_SYSINIT
endif

AR = $(TOOL_PREFIX)-ar
AFLAGS = -r -s

OD = $(TOOL_PREFIX)-objdump
ODFLAGS = --disassemble-all --disassemble-zeroes

ifeq ($(OS),Windows_NT)
	RM = cmd.exe /C del /Q
	MKDIR = mkdir
else
	RM = rm -fr
	MKDIR = mkdir -p
endif

LIBSRC = ch32v00x_startup.S

OBJDIR = obj
LIBOBJ = $(patsubst %.S,$(OBJDIR)/%.o,$(LIBSRC))

LIBDIS = $(patsubst %.o,%.lst,$(LIBOBJ))

LIBDIR = lib
LIBRARY = $(LIBDIR)/ch32v00x_startup.a

.PHONY: all clean

all: $(LIBRARY) $(LIBDIS)

$(LIBRARY): $(LIBOBJ) | $(LIBDIR)
	$(AR) $(AFLAGS) $@ $(LIBOBJ)

$(LIBDIS): $(LIBOBJ)

$(LIBOBJ): $(LIBSRC) | $(OBJDIR)

$(OBJDIR)/%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<

$(OBJDIR)/%.lst: $(OBJDIR)/%.o
	$(OD) $(ODFLAGS) $< > $@

$(OBJDIR) $(LIBDIR):
	$(MKDIR) $@

clean:
	$(RM) $(OBJDIR)
	$(RM) $(LIBDIR)
