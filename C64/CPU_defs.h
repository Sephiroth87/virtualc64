/*!
 * @header      CPU_defs.h
 * @author      Dirk W. Hoffmann, www.dirkwhoffmann.de
 * @copyright   2006 - 2017 Dirk W. Hoffmann
 */
/*              This program is free software; you can redistribute it and/or modify
 *              it under the terms of the GNU General Public License as published by
 *              the Free Software Foundation; either version 2 of the License, or
 *              (at your option) any later version.
 *
 *              This program is distributed in the hope that it will be useful,
 *              but WITHOUT ANY WARRANTY; without even the implied warranty of
 *              MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *              GNU General Public License for more details.
 *
 *              You should have received a copy of the GNU General Public License
 *              along with this program; if not, write to the Free Software
 *              Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef CPU_DEFS_H
#define CPU_DEFS_H

//! @brief    Processor models
enum ChipModel {
    CPU_MOS6510 = 0,
    CPU_MOS6502 = 1
};

//! @brief    Addressing modes
enum AddressingMode {
    CPU_ADDR_IMPLIED,
    CPU_ADDR_ACCUMULATOR,
    CPU_ADDR_IMMEDIATE,
    CPU_ADDR_ZERO_PAGE,
    CPU_ADDR_ZERO_PAGE_X,
    CPU_ADDR_ZERO_PAGE_Y,
    CPU_ADDR_ABSOLUTE,
    CPU_ADDR_ABSOLUTE_X,
    CPU_ADDR_ABSOLUTE_Y,
    CPU_ADDR_INDIRECT_X,
    CPU_ADDR_INDIRECT_Y,
    CPU_ADDR_RELATIVE,
    CPU_ADDR_DIRECT,
    CPU_ADDR_INDIRECT
};

/*! @brief    Error states of the virtual CPU
 *  @details  CPU_OK indicates normal operation. When a (soft or hard) breakpoint is reached,
 *            the CPU enters the CPU_BREAKPOINT_REACHED state. CPU_ILLEGAL_INSTRUCTION is
 *            entered when an opcode is not understood by the CPU. Once the CPU enters a
 *            different state than CPU_OK, the execution thread is terminated.
 */
enum ErrorState {
    CPU_OK = 0,
    CPU_SOFT_BREAKPOINT_REACHED,
    CPU_HARD_BREAKPOINT_REACHED,
    CPU_ILLEGAL_INSTRUCTION
};

/*! @brief    Breakpoint type
 *  @details  Each memory call is marked with a breakpoint tag. Originally, each cell is
 *            tagged with NO_BREAKPOINT which has no effect. CPU execution will stop if the
 *            memory cell is tagged with one of the following breakpoint types:
 *
 *            HARD_BREAKPOINT: execution is halted
 *            SOFT_BREAKPOINT: execution is halted and the tag is deleted
 */
enum Breakpoint {
    CPU_NO_BREAKPOINT   = 0x00,
    CPU_HARD_BREAKPOINT = 0x01,
    CPU_SOFT_BREAKPOINT = 0x02
};


#endif
