# Makefile for the AD7146 controller driver.

CROSS_COMPILE	:= /path/to/arm-linux-eabi-
ARCH		:= arm

KERNELDIR	:= /path/to/kernel/
PWD		:= $(shell pwd)


ifeq ($(DEBUG),ON)
EXTRA_CFLAGS	+= -DCONFIG_AD7146_DEBUG
endif

ifeq ($(LIST),ON)
EXTRA_CFLAGS	+= -DCONFIG_DEVICE_LIST
endif

ifeq ($(STG_HYS),ON)
EXTRA_CFLAGS	+= -DCONFIG_STG_HYS
endif

ifeq ($(NO_STG_CAL),ON)
EXTRA_CFLAGS	+= -DCONFIG_NOSTG_CAL_LAST
endif

obj-m   += ad7146.o

all:
	$ make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELDIR) M=$(PWD) modules

default:
	$ make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELDIR) M=$(PWD) modules
help:
	@echo "Use make DEBUG=ON for building with the Debug enabled"
	@echo "Use make LIST=ON for building with the driver with the ad7146_device_list"
	@echo "Use make STG_HYS=ON to include the Hysteresis Compensation routine in the driver build"
	@echo "Use make NO_STG_CAL=ON for building with driver that initializes in the same order as the given initialization registers"
clean:
	$ make ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) -C $(KERNELDIR) M=$(PWD) clean

