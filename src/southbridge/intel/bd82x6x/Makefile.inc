## SPDX-License-Identifier: GPL-2.0-only

ifeq ($(CONFIG_SOUTHBRIDGE_INTEL_C216)$(CONFIG_SOUTHBRIDGE_INTEL_BD82X6X),y)

bootblock-y += bootblock.c
bootblock-y += early_pch.c

ramstage-y += pch.c
ramstage-y += azalia.c
ramstage-y += fadt.c
ramstage-y += lpc.c
ramstage-y += pci.c
ramstage-y += pcie.c
ramstage-y += sata.c
ramstage-y += usb_ehci.c
ramstage-y += usb_xhci.c
ramstage-y += me.c
ramstage-y += me_8.x.c
ramstage-y += smbus.c
ramstage-y += ../common/pciehp.c

ramstage-srcs += src/mainboard/$(MAINBOARDDIR)/hda_verb.c

ramstage-y += me_status.c

ramstage-$(CONFIG_ELOG) += elog.c

smm-y += smihandler.c me.c me_8.x.c pch.c

romstage-y += me_status.c
romstage-y += early_rcba.c
romstage-y += early_pch.c

ifeq ($(CONFIG_USE_NATIVE_RAMINIT),y)
romstage-y += early_thermal.c early_me.c early_usb.c
else
romstage-y += early_me_mrc.c early_usb_mrc.c
endif

endif
