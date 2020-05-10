/*****************************************************************************\
 * lbtable.h
 *****************************************************************************
 *  Please also read the file DISCLAIMER which is included in this software
 *  distribution.
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License (as published by the
 *  Free Software Foundation) version 2, dated June 1991.
 *
 *  This program is distributed in the hope that it will be useful, but
 *  WITHOUT ANY WARRANTY; without even the IMPLIED WARRANTY OF
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the terms and
 *  conditions of the GNU General Public License for more details.
\*****************************************************************************/

#ifndef LBTABLE_H
#define LBTABLE_H

#include "common.h"

void get_lbtable(void);
void get_layout_from_cmos_table(void);
void get_layout_from_cbfs_file(void);
void dump_lbtable(void);
void list_lbtable_choices(void);
void list_lbtable_item(const char item[]);
const struct lb_record *find_lbrec(uint32_t tag);

void process_layout(void);
#endif				/* LBTABLE_H */
