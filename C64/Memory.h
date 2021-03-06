/*!
 * @header      Memory.h
 * @author      Dirk W. Hoffmann, www.dirkwhoffmann.de
 * @copyright   2006 - 2016 Dirk W. Hoffmann
 */
/* This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef _MEMORY_INC
#define _MEMORY_INC

#include "basic.h"
#include "VirtualComponent.h"
#include "Memory_types.h"

// Forward declarations
class CPU;

class Memory : public VirtualComponent {

    friend CPU;
    
public:

	// --------------------------------------------------------------------------------
	//                                Constant definitions
	// --------------------------------------------------------------------------------
		
	//! @brief    Returns true, if the specified address is a valid memory address.
	virtual bool isValidAddr(uint16_t addr, MemoryType type) = 0;
	
	//! @brief    Reference to the connected virtual CPU
	CPU *cpu; 

public:
	
	//! @brief    Constructor
	Memory();
	
	//! @brief    Destructor
	~Memory();

    // --------------------------------------------------------------------------------
    //                                    Read
    // --------------------------------------------------------------------------------
    
    //! @brief    Reads a byte from RAM.
    virtual uint8_t readRam(uint16_t addr) = 0;
    
    //! @brief    Reads a byte from ROM.
    virtual uint8_t readRom(uint16_t addr) = 0;
    
    //! @brief    Reads a byte from I/O space.
    virtual uint8_t readIO(uint16_t addr) = 0;
    
    //! @brief    Reads a byte from the specified memory source.
    uint8_t readFrom(uint16_t addr, MemoryType source);

    //! @brief    Same as peek, but without side effects
    virtual uint8_t read(uint16_t addr) = 0;
    
    //! @brief    Reads two bytes in a row
    uint16_t readWord(uint16_t addr) { return LO_HI(read(addr),read(addr+1)); }

    
	// --------------------------------------------------------------------------------
	//                                    Peek
	// --------------------------------------------------------------------------------

private:
	
    //! @brief    Reads a byte from I/O space.
	virtual uint8_t peekIO(uint16_t addr) = 0;
    
	/*! @brief    Reads a byte from memory.
	 *  @details  This function implements the native memory peek of the original C64
     *            including all side effects.
     */
	virtual uint8_t peek(uint16_t addr) = 0;
	
	//! @brief    Convenience wrapper for peek
    uint8_t peek(uint8_t lo, uint8_t hi) { return peek(LO_HI(lo, hi)); }

    
	// --------------------------------------------------------------------------------
	//                                    Poke
	// --------------------------------------------------------------------------------

private:

	//! @brief    Writes a byte into RAM
    virtual void pokeRam(uint16_t addr, uint8_t value) = 0;
	
    //! @brief    Writes a byte into ROM
	virtual void pokeRom(uint16_t addr, uint8_t value) = 0;

    //! @brief    Writes a byte into I/O space
	virtual void pokeIO(uint16_t addr, uint8_t value) = 0;
	
public:
	
	//! Write a BYTE to the specified memory.
	/*! Depending in the specified memory type, either \a pokeRam, \a pokeRom, or \a pokeIO is called. */
	void pokeTo(uint16_t addr, uint8_t value, MemoryType dest);

	//! Write a BYTE to memory.
	/*! This functions implements the native memory poke of the original C64 including all side effects.
	 The functions automatically determines the correct memory source by the value of the processor 
	 port register. Afterwards, the value is written either to RAM, ROM, or the I/O address space and.
	 \param addr Memory address
	 \param value Value to write
	 */
	virtual void poke(uint16_t addr, uint8_t value) = 0;

	//! Wrapper around poke
	/*!	Memory address is provided in LO/HIBYTE format.
		\param lo Low-Byte of the memory address 
		\param hi High-Byte of the memory address
		\param value Value to write
	*/
    void poke(uint8_t lo, uint8_t hi, uint8_t value)
		{ poke(((uint16_t)hi << 8) + lo, value); }  

	//! Wrapper around peek
	/*!	Memory address is provided in three parts.
		\param lo Low-Byte of the memory address 
		\param hi High-Byte of the memory address
		\param index The effective address is computed by adding index
		\param value Value to write
	*/
    void poke(uint8_t lo, uint8_t hi, uint8_t index, uint8_t value)
		{ poke((uint16_t)(hi << 8) + lo + index, value); }

	//! Wrapper around peek
	/*!	Write 16 bit value to the provided address
		\param addr Memory Addr
		\param value Value to write
		\remark The C64 is a little endian machine. Hence, the low byte comes first. 
	*/	
    void pokeWord(uint16_t addr, uint16_t value)
		{ poke (addr, LO_BYTE(value)); poke (addr+1, HI_BYTE(value)); }

	//! Load a ROM image into memory.
	/*! All bytes of the specified file are read into the ROM memory, starting at the specified location.
	   The function is unsafe, i.e., it does not check if the file is a valid ROM file or if the address 
	   is adequate. Hence, call checkRomFile prior to this function. 
	   \param filename Name of the file being loaded
	   \param start Start address in ROM memory 
	*/
	void flashRom(const char *filename, uint16_t start);
};

#endif
