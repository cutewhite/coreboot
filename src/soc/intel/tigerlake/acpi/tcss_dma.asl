/* SPDX-License-Identifier: GPL-2.0-or-later */

OperationRegion (DPME, SystemMemory, BASE(_ADR), 0x100)
Field (DPME, AnyAcc, NoLock, Preserve)
{
	VDID, 32,
	Offset(0x84),   /* 0x84, DMA CFG PM CAP */
	PMST, 2,        /* 1:0, PM_STATE */
	, 6,
	PMEE, 1,        /* 8, PME_EN */
	, 6,
	PMES, 1,        /* 15, PME_STATUS */
	Offset(0xC8),   /* 0xC8, TBT NVM FW Revision */
	,     31,
	INFR,  1,       /* TBT NVM FW Ready */
	Offset(0xEC),   /* 0xEC, TBT TO PCIE Register */
	TB2P, 32,       /* TBT to PCIe */
	P2TB, 32,       /* PCIe to TBT */
	Offset(0xFC),   /* 0xFC, DMA RTD3 Force Power */
	DD3E, 1,        /* 0:0 DMA RTD3 Enable */
	DFPE, 1,        /* 1:1 DMA Force Power */
	, 22,
	DMAD, 8         /* 31:24 DMA Active Delay */
}

Name (STAT, 0x1)  /* Variable to save power state 1 - D0, 0 - D3C */

Method (_S0W, 0x0)
{
	Return (0x4)
}

Method (_PR0)
{
	Return (Package() { \_SB.PCI0.D3C })
}

Method (_PR3)
{
	Return (Package() { \_SB.PCI0.D3C })
}

/*
 * RTD3 Exit Method to bring TBT controller out of RTD3 mode.
 */
Method (D3CX, 0, Serialized)
{
	DD3E = 0	/* Disable DMA RTD3 */
	STAT = 0x1
}

/*
 * RTD3 Entry method to enable TBT controller RTD3 mode.
 */
Method (D3CE, 0, Serialized)
{
	DD3E = 1	/* Enable DMA RTD3 */
	STAT = 0
}

/*
 * Variable to skip TCSS/TBT D3 cold; 1+: Skip D3CE, 0 - Enable D3CE
 * TCSS D3 Cold and TBT RTD3 is only available when system power state is in S0.
 */
Name (SD3C, 0)

Method (_PS0, 0, Serialized)
{
	If (DUID == 0) {
		\_SB.PCI0.TBT0._ON()
	} Else {
		\_SB.PCI0.TBT1._ON()
	}
}

Method (_PS3, 0, Serialized)
{
	If (DUID == 0) {
		\_SB.PCI0.TBT0._OFF()
	} Else {
		\_SB.PCI0.TBT1._OFF()
	}
}

Method (_DSW, 3)
{
	/* If entering Sx (Arg1 > 1), need to skip TCSS D3Cold & TBT RTD3/D3Cold. */
	SD3C = Arg1
}

Method (_PRW, 0)
{
	Return (Package() { 0x6D, 4 })
}

Method (_DSD, 0)
{
	Return(
		Package()
		{
			/* Thunderbolt GUID for IMR_VALID at ../drivers/acpi/property.c */
			ToUUID("C44D002F-69F9-4E7D-A904-A7BAABDF43F7"),
			Package ()
			{
				Package (2) { "IMR_VALID", 1 }
			},

			/* Thunderbolt GUID for WAKE_SUPPORTED at ../drivers/acpi/property.c */
			ToUUID("6C501103-C189-4296-BA72-9BF5A26EBE5D"),
			Package ()
			{
				Package (2) { "WAKE_SUPPORTED", 1 }
			}
		}
	)
}

Method (_DSM, 4, Serialized)
{
	Return (Buffer() { 0 })
}
