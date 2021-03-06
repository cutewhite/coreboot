## SPDX-License-Identifier: GPL-2.0-only

bootblock-y += early_init.c

smm-y += dock.c
smm-y += smihandler.c
ramstage-$(CONFIG_MAINBOARD_USE_LIBGFXINIT) += gma-mainboard.ads

romstage-y += dock.c
ramstage-y += dock.c
romstage-y += gpio.c
