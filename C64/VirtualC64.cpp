/*!
 * @header      VirtualC64.h
 * @author      Dirk W. Hoffmann, www.dirkwhoffmann.de
 * @copyright   2017 Dirk W. Hoffmann
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

#include "VirtualC64.h"
#include "C64.h"

#ifdef __cplusplus
extern "C"
{
#endif

    // -----------------------------------------------------------------------------------------------
    //                                             C64
    // -----------------------------------------------------------------------------------------------

    VC64* c64_new() { return reinterpret_cast<VC64*>(new C64()); }
    void c64_delete(VC64* c64) { assert (c64 != NULL); delete reinterpret_cast<C64*>(c64); }
    
    void c64_reset(VC64 *c64) { reinterpret_cast<C64*>(c64)->reset(); }
    void c64_ping(VC64 *c64) { reinterpret_cast<C64*>(c64)->ping(); }
    void c64_dumpState(VC64 *c64) { reinterpret_cast<C64*>(c64)->dumpState(); }

    bool c64_isPAL(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isPAL(); }
    void c64_setPAL(VC64 *c64) { reinterpret_cast<C64*>(c64)->setPAL(); }
    bool c64_isNTSC(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isNTSC(); }
    void c64_setNTSC(VC64 *c64) { reinterpret_cast<C64*>(c64)->setNTSC(); }
    bool c64_getAudioFilter(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getAudioFilter(); }
    void c64_setAudioFilter(VC64 *c64, bool value) { reinterpret_cast<C64*>(c64)->setAudioFilter(value); }
    bool c64_getReSID(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getReSID(); }
    void c64_setReSID(VC64 *c64, bool value) { reinterpret_cast<C64*>(c64)->setReSID(value); }
    sampling_method c64_getSamplingMethod(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getSamplingMethod(); }
    void c64_setSamplingMethod(VC64 *c64, sampling_method value) { reinterpret_cast<C64*>(c64)->setSamplingMethod(value); }
    chip_model c64_getChipModel(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getChipModel(); }
    void c64_setChipModel(VC64 *c64, chip_model value) { reinterpret_cast<C64*>(c64)->setChipModel(value); }
    void c64_run(VC64 *c64) { reinterpret_cast<C64*>(c64)->run(); }
    void c64_threadCleanup(VC64 *c64) { reinterpret_cast<C64*>(c64)->threadCleanup(); } // TODO: MAKE PRIVATE
    bool c64_isRunnable(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isRunnable(); }
    bool c64_isRunning(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isRunning(); }
    void c64_halt(VC64 *c64) { reinterpret_cast<C64*>(c64)->halt(); }
    bool c64_isHalted(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isHalted(); }
    void c64_step(VC64 *c64) { reinterpret_cast<C64*>(c64)->step(); }
    bool c64_executeOneLine(VC64 *c64) { return reinterpret_cast<C64*>(c64)->executeOneLine(); }
    
    bool c64_getWarp(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getWarp(); }
    void c64_setWarp(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setWarp(b); }
    bool c64_getAlwaysWarp(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getAlwaysWarp(); }
    void c64_setAlwaysWarp(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setAlwaysWarp(b); }
    bool c64_getWarpLoad(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getWarpLoad(); }
    void c64_setWarpLoad(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->setWarpLoad(b); }
    void c64_restartTimer(VC64 *c64) { reinterpret_cast<C64*>(c64)->restartTimer(); }
    void c64_synchronizeTiming(VC64 *c64) { reinterpret_cast<C64*>(c64)->synchronizeTiming(); }
    uint64_t c64_getCycles(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getCycles(); }
    uint64_t c64_getFrame(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getFrame(); }
    uint16_t c64_getRasterline(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getRasterline(); }
    uint8_t c64_getRasterlineCycle(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getRasterlineCycle(); }
    uint8_t c64_getMissingRoms(VC64 *c64) { return reinterpret_cast<C64*>(c64)->getMissingRoms(); }
    bool c64_loadRom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadRom(filename); }
    bool c64_loadBasicRom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadBasicRom(filename); }
    bool c64_loadCharRom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadCharRom(filename); }
    bool c64_loadKernelRom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadKernelRom(filename); }
    bool c64_loadVC1541Rom(VC64 *c64, const char *filename) { return reinterpret_cast<C64*>(c64)->loadVC1541Rom(filename); }
    void c64_loadFromSnapshot(VC64 *c64, VC64_Snapshot *snapshot) {
        reinterpret_cast<C64*>(c64)->loadFromSnapshot(reinterpret_cast<Snapshot*>(snapshot)); }
    void c64_saveToSnapshot(VC64 *c64, VC64_Snapshot *snapshot) {
        reinterpret_cast<C64*>(c64)->saveToSnapshot(reinterpret_cast<Snapshot*>(snapshot)); }
    void c64_takeSnapshot(VC64 *c64) { reinterpret_cast<C64*>(c64)->takeSnapshot(); }
    unsigned c64_numHistoricSnapshots(VC64 *c64) { return reinterpret_cast<C64*>(c64)->numHistoricSnapshots(); }
    VC64_Snapshot *c64_getHistoricSnapshot(VC64 *c64, int nr) {
        return reinterpret_cast<VC64_Snapshot*>(reinterpret_cast<C64*>(c64)->getHistoricSnapshot(nr)); }
    bool c64_flushArchive(VC64 *c64, VC64_Archive *a, int item) {
        return reinterpret_cast<C64*>(c64)->flushArchive(reinterpret_cast<Archive*>(a), item); }
    bool c64_mountArchive(VC64 *c64, VC64_Archive *a) {
        return reinterpret_cast<C64*>(c64)->mountArchive(reinterpret_cast<Archive*>(a)); }
    bool c64_insertTape(VC64 *c64, VC64_TAPArchive *a) {
        return reinterpret_cast<C64*>(c64)->insertTape(reinterpret_cast<TAPArchive*>(a)); }
    bool c64_attachCartridge(VC64 *c64, VC64_Cartridge *c) {
        return reinterpret_cast<C64*>(c64)->attachCartridge(reinterpret_cast<Cartridge*>(c)); }
    void c64_detachCartridge(VC64 *c64) { reinterpret_cast<C64*>(c64)->detachCartridge(); }
    bool c64_isCartridgeAttached(VC64 *c64) { return reinterpret_cast<C64*>(c64)->isCartridgeAttached(); }
    VC64_Message *c64_getMessage(VC64 *c64) {
        return reinterpret_cast<VC64_Message*>(reinterpret_cast<C64*>(c64)->getMessage()); }
    void c64_putMessage(VC64 *c64, int id) {
        reinterpret_cast<C64*>(c64)->putMessage(id); }
    void c64_putCustomMessage(VC64 *c64, int id, int i, void *p, const char *c) {
        reinterpret_cast<C64*>(c64)->putMessage(id, i, p, c); }


    // -----------------------------------------------------------------------------------------------
    //                                             CPU
    // -----------------------------------------------------------------------------------------------
    
    void cpu_dumpState(VC64 *c64) { reinterpret_cast<C64*>(c64)->cpu.dumpState(); }
    bool cpu_tracingEnabled(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.tracingEnabled(); }
    void cpu_setTraceMode(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setTraceMode(b); }
    
    uint16_t cpu_getPC_at_cycle_0(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getPC_at_cycle_0(); }
    void cpu_setPC_at_cycle_0(VC64 *c64, uint16_t pc) { reinterpret_cast<C64*>(c64)->cpu.setPC_at_cycle_0(pc); }
    uint8_t cpu_getSP(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getSP(); }
    void cpu_setSP(VC64 *c64, uint8_t sp) { reinterpret_cast<C64*>(c64)->cpu.setSP(sp); }
    uint8_t cpu_getA(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getA(); }
    void cpu_setA(VC64 *c64, uint8_t a) { reinterpret_cast<C64*>(c64)->cpu.setA(a); }
    uint8_t cpu_getX(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getX(); }
    void cpu_setX(VC64 *c64, uint8_t x) { reinterpret_cast<C64*>(c64)->cpu.setX(x); }
    uint8_t cpu_getY(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getY(); }
    void cpu_setY(VC64 *c64, uint8_t y) { reinterpret_cast<C64*>(c64)->cpu.setY(y); }
    bool cpu_getN(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getN(); }
    void cpu_setN(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setN(b); }
    bool cpu_getZ(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getZ(); }
    void cpu_setZ(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setZ(b); }
    bool cpu_getC(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getC(); }
    void cpu_setC(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setC(b); }
    bool cpu_getI(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getI(); }
    void cpu_setI(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setI(b); }
    bool cpu_getB(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getB(); }
    void cpu_setB(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setB(b); }
    bool cpu_getD(VC64 *c64) { return reinterpret_cast<C64*>(c64)->cpu.getD(); }
    void cpu_setD(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setD(b); }
    bool cpu_getV(VC64 *c64)  { return reinterpret_cast<C64*>(c64)->cpu.getV(); }
    void cpu_setV(VC64 *c64, bool b) { reinterpret_cast<C64*>(c64)->cpu.setV(b); }
    
    // TODO: MOVE TO CPU CLASS
    // - (uint16_t) peekPC { return cpu->mem->peek(cpu->getPC_at_cycle_0()); }
    
    uint8_t cpu_getLengthOfInstruction(VC64 *c64, uint8_t opcode) {
        return reinterpret_cast<C64*>(c64)->cpu.getLengthOfInstruction(opcode); }
    uint8_t cpu_getLengthOfInstructionAtAddress(VC64 *c64, uint16_t addr) {
        return reinterpret_cast<C64*>(c64)->cpu.getLengthOfInstructionAtAddress(addr); }
    uint8_t cpu_getLengthOfCurrentInstruction(VC64 *c64) {
        return reinterpret_cast<C64*>(c64)->cpu.getLengthOfCurrentInstruction(); }
    uint16_t cpu_getAddressOfNextInstruction(VC64 *c64) {
        return reinterpret_cast<C64*>(c64)->cpu.getAddressOfNextInstruction(); }
    const char *cpu_getMnemonic(VC64 *c64, uint8_t opcode) {
        return reinterpret_cast<C64*>(c64)->cpu.getMnemonic(opcode); }
    
    // TODO: NEED C DATA TYPE. Add CPU_defs.h and use standard enums
    // CPU::AddressingMode cpu_getAddressingMode(uint8_t opcode) { return cpu->getAddressingMode(opcode); }
    
    int cpu_getTopOfCallStack(VC64 *c64) {
        return reinterpret_cast<C64*>(c64)->cpu.getTopOfCallStack(); }
    int cpu_getBreakpoint(VC64 *c64, int addr) {
        return reinterpret_cast<C64*>(c64)->cpu.getBreakpoint(addr); }
    void cpu_setBreakpoint(VC64 *c64, int addr, uint8_t t) {
        reinterpret_cast<C64*>(c64)->cpu.setBreakpoint(addr, t); }
    void cpu_setHardBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.setHardBreakpoint(addr); }
    void cpu_seleteHardBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.deleteHardBreakpoint(addr); }
    void cpu_toggleHardBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.toggleHardBreakpoint(addr); }
    void cpu_setSoftBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.setSoftBreakpoint(addr); }
    void cpu_deleteSoftBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.deleteSoftBreakpoint(addr); }
    void cpu_toggleSoftBreakpoint(VC64 *c64, int addr) {
        reinterpret_cast<C64*>(c64)->cpu.toggleSoftBreakpoint(addr); }

    
    
    // -----------------------------------------------------------------------------------------------
    //                                             Message
    // -----------------------------------------------------------------------------------------------
    
    int message_id(VC64_Message *msg) { return reinterpret_cast<Message*>(msg)->id; }
    char *message_c(VC64_Message *msg) { return reinterpret_cast<Message*>(msg)->c; };
    int message_i(VC64_Message *msg) { return reinterpret_cast<Message*>(msg)->i; };
    void *message_p(VC64_Message *msg) { return reinterpret_cast<Message*>(msg)->p; };

    
#ifdef __cplusplus
}
#endif
